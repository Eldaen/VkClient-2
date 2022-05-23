//
//  GroupsService.swift
//  VkClient-2
//
//  Created by Денис Сизов on 20.05.2022.
//

import UIKit.UIImage

// MARK: - GroupsLoader protocol
/// Протокол загрузки данных групп
protocol GroupsLoader: LoaderProtocol {
	
	/// Загружает список групп пользователя
	/// - Parameter completion: Клоужер с результатом запроса, массив групп или ошибка
	func loadGroups(completion: @escaping (Result<[GroupModel], Error>) -> Void)
	
	/// Ищет группы, подходящие под текстовый запрос
	/// - Parameters:
	///   - query: Строка поискового запроса
	///   - completion: Клоужер с результатом запроса, массив групп или ошибка
	func searchGroups(with query: String, completion: @escaping (Result<[GroupModel], Error>) -> Void)
	
	/// Запрос на вступление в группу по id
	/// - Parameters:
	///   - id: id гуппы, в которую нужно вступить
	///   - completion: Клоужер с результатом запроса, код ответа или ошибка
	func joinGroup(id: Int, completion: @escaping (Result<Int, Error>) -> Void)
	
	/// Запрос на выход из группы по id
	/// - Parameters:
	///   - id: id группы, из которой нужно выйти
	///   - completion: Клоужер с результатом запроса, код ответа или ошибка
	func leaveGroup(id: Int, completion: @escaping (Result<Int, Error>) -> Void)
}

// MARK: - GroupsService
/// Сервис загрузки данных для групп из сети
final class GroupsService: GroupsLoader {
	
	// MARK: - Properties
	
	internal var networkManager: NetworkManagerProtocol
	internal var cache: ImageCacheInput
	//private var persistence: PersistenceManager
	
	/// Ключ для сохранения данных о просрочке в Userdefaults
	let cacheKey = "groupsExpiry"
	
	// MARK: - Init
	
	init(networkManager: NetworkManagerProtocol, cache: ImageCacheInput/*, persistence: PersistenceManager*/) {
		self.networkManager = networkManager
		self.cache = cache
		//self.persistence = persistence
	}
	
	// MARK: - Methods
	
	/// Загружает список групп пользователя
	func loadGroups(completion: @escaping (Result<[GroupModel], Error>) -> Void) {
		let params = [
			"order" : "name",
			"extended" : "1",
		]
		
//		if checkExpiry(key: cacheKey) {
//			var groups: [GroupModel] = []
//
//			persistence.read(GroupModel.self) { result in
//				groups = Array(result)
//			}
//
//			if !groups.isEmpty {
//				completion(groups)
//				return
//			}
//		}
		
		networkManager.request(method: .groupsGet,
							   httpMethod: .get,
							   params: params) { [weak self] (result: Result<GroupsMyMainResponse, Error>) in
			switch result {
			case .success(let groupsResponse):
				let groups = groupsResponse.response.items
				//self?.persistence.delete(GroupModel.self) { _ in }
				//self?.persistence.create(items) { _ in }
				
				// Ставим дату просрочки данных
				if let cacheKey = self?.cacheKey {
					self?.setExpiry(key: cacheKey, time: 10 * 60)
				}
				completion(.success(groups))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
	
	/// Ищет группы, подходящие под текстовый запрос
	func searchGroups(with query: String, completion: @escaping (Result<[GroupModel], Error>) -> Void) {
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
				completion(.success(groupsResponse.response.items))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
	
	/// Запрос на вступление в группу по id
	func joinGroup(id: Int, completion: @escaping (Result<Int, Error>) -> Void) {
		let params = [
			"group_id" : "\(id)",
			"extended" : "1",
		]
		
		networkManager.request(method: .groupsJoin,
							   httpMethod: .post,
							   params: params) {[weak self] (result: Result<ApiBoolResponse, Error>) in
			switch result {
			case .success(let response):
				
				// Нужно перекачать данные групп, сбросим кэш
				if let cacheKey = self?.cacheKey {
					self?.dropCache(key: cacheKey)
				}
				completion(.success(response.response))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
	
	/// Запрос на вступление в группу по id
	func leaveGroup(id: Int, completion: @escaping (Result<Int, Error>) -> Void) {
		let params = [
			"group_id" : "\(id)",
			"extended" : "1",
		]
		
		networkManager.request(method: .groupsLeave,
							   httpMethod: .post,
							   params: params) { [weak self] (result: Result<ApiBoolResponse, Error>) in
			switch result {
			case .success(let response):
				//self?.persistence.delete(GroupModel.self, keyValue: "\(id)") { _ in }
				
				// Нужно перекачать данные групп, сбросим кэш
				if let cacheKey = self?.cacheKey {
					self?.dropCache(key: cacheKey)
				}
				
				completion(.success(response.response))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
}
