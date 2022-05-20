//
//  GroupsService.swift
//  VkClient-2
//
//  Created by Денис Сизов on 20.05.2022.
//

import UIKit.UIImage

/// Протокол загрузки данных групп
protocol GroupsLoader: Loader {
	
	/// Загружает список групп пользователя
	func loadGroups(completion: @escaping ([GroupModel]) -> Void)
	
	/// Ищет группы, подходящие под текстовый запрос
	func searchGroups(with query: String, completion: @escaping ([GroupModel]) -> Void)
	
	/// Запрос на вступление в группу по id
	func joinGroup(id: Int, completion: @escaping (Int) -> Void)
	
	/// Запрос на вступление в группу по id
	func leaveGroup(id: Int, completion: @escaping (Int) -> Void)
}

/// Сервис загрузки данных для групп из сети
final class GroupsService: GroupsLoader {
	
	private var networkManager: NetworkManagerProtocol
	private var cache: ImageCache
	//private var persistence: PersistenceManager
	
	/// Очередь операций для загрузки данных групп
	let operationQueue: OperationQueue = {
		let operationQueue = OperationQueue()
		operationQueue.name = "groupsLoadQueue"
		operationQueue.qualityOfService = .utility
		return operationQueue
	}()
	
	/// Ключ для сохранения данных о просрочке в Userdefaults
	let cacheKey = "groupsExpiry"
	
	init(networkManager: NetworkManagerInterface, cache: ImageCache/*, persistence: PersistenceManager*/) {
		self.networkManager = networkManager
		self.cache = cache
		//self.persistence = persistence
	}
	
	/// Загружает список групп пользователя
	func loadGroups(completion: @escaping ([GroupModel]) -> Void) {

//		if checkExpiry(key: cacheKey) {
//			var groups: [GroupModel] = []
//			self.persistence.read(GroupModel.self) { result in
//				groups = Array(result)
//			}
//
//			if !groups.isEmpty {
//				completion(groups)
//				return
//			}
//		}
		
		let params = [
			"order" : "name",
			"extended" : "1",
		]
		
		let getData = GroupsDataOperation(method: .groupsGet, params: params)
		let parseData = GroupsDataParseOperation()
		let completionOperation = GroupsCompletionOperation(completion)
		let updateRealm = UpdateRealmDataOperation(manager: persistence, cacheHandler: self, cacheKey: cacheKey)
		
		parseData.addDependency(getData)
		completionOperation.addDependency(parseData)
		updateRealm.addDependency(completionOperation)
		
		operationQueue.addOperations([getData, parseData], waitUntilFinished: false)
		
		// Realm редиска и не хочет работать из другого потка, если был инициализирован в мейне
		OperationQueue.main.addOperations([completionOperation, updateRealm], waitUntilFinished: false)
	}
	
	/// Ищет группы, подходящие под текстовый запрос
	func searchGroups(with query: String, completion: @escaping ([GroupModel]) -> Void) {
		let params = [
			"order" : "name",
			"extended" : "1",
			"q" : "\(query)",
			"count" : "40"
		]
		
		networkManager.request(method: .groupsSearch,
							   httpMethod: .get,
							   params: params) { (result: Result<GroupsMyMainResponse, Error>) in
			switch result {
			case .success(let groupsResponse):
				completion(groupsResponse.response.items)
			case .failure(let error):
				debugPrint("Error: \(error.localizedDescription)")
			}
		}
	}
	
	/// Запрос на вступление в группу по id
	func joinGroup(id: Int, completion: @escaping (Int) -> Void) {
		let params = [
			"group_id" : "\(id)",
			"extended" : "1",
		]
		
		networkManager.request(method: .groupsJoin,
							   httpMethod: .post,
							   params: params) {[weak self] (result: Result<BoolResponse, Error>) in
			switch result {
			case .success(let response):
				
				// Нужно перекачать данные групп, сбросим кэш
				if let cacheKey = self?.cacheKey {
					self?.dropCache(key: cacheKey)
				}
				completion(response.response)
			case .failure(let error):
				debugPrint("Error: \(error.localizedDescription)")
			}
		}
	}
	
	/// Запрос на вступление в группу по id
	func leaveGroup(id: Int, completion: @escaping (Int) -> Void) {
		let params = [
			"group_id" : "\(id)",
			"extended" : "1",
		]
		
		networkManager.request(method: .groupsLeave,
							   httpMethod: .post,
							   params: params) { [weak self] (result: Result<BoolResponse, Error>) in
			switch result {
			case .success(let response):
				self?.persistence.delete(GroupModel.self, keyValue: "\(id)") { _ in }
				
				// Нужно перекачать данные групп, сбросим кэш
				if let cacheKey = self?.cacheKey {
					self?.dropCache(key: cacheKey)
				}
				
				completion(response.response)
			case .failure(let error):
				debugPrint("Error: \(error.localizedDescription)")
			}
		}
	}
}
