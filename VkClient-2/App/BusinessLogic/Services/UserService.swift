//
//  FriendsService.swift
//  VkClient-2
//
//  Created by Денис Сизов on 23.05.2022.
//

import UIKit.UIImage

// MARK: - UserLoader Protocol
/// Протокол загрузки данных пользователей
protocol UserLoader: LoaderProtocol {
	
	/// Загружает список друзей
	func loadFriends(completion: @escaping ([FriendsSection]) -> Void)
	
	/// Загружает все фото пользователя
	func loadUserPhotos(for id: String, completion: @escaping ([ApiImage]) -> Void)
	
	/// Запрашивает кол-во друзей пользователя
	func getFriendsCount(completion: @escaping (Int) -> Void)
}

// MARK: - UserService
/// Сервис для загрузки данных пользователей из сети
final class UserService: UserLoader {
	
	// MARK: - Properties
	
	internal var networkManager: NetworkManagerProtocol
	internal var cache: ImageCacheInput
	//internal var persistence: PersistenceManager
	
	/// Ключ для сохранения данных о просрочке в Userdefaults
	let cacheKey = "usersExpiry"
	
	private var friendsArray: [UserModel]?
	
	// MARK: - Init
	
	required init(networkManager: NetworkManagerProtocol, cache: ImageCacheInput/*, persistence: PersistenceManager*/) {
		self.networkManager = networkManager
		self.cache = cache
		//self.persistence = persistence
	}
	
	// MARK: - Methods
	
	/// Загружает список друзей
	func loadFriends(completion: @escaping ([FriendsSection]) -> Void) {
		let params = [
			"order" : "name",
			"fields" : "photo_100",
		]
		
//		if checkExpiry(key: cacheKey) {
//			var friends: [UserModel] = []
//
//			persistence.read(UserModel.self) { result in
//				friends = Array(result)
//			}
//
//			if !friends.isEmpty {
//				let sections = formFriendsArray(from: friends)
//				completion(sections)
//				return
//			}
//		}
		
		networkManager.request(method: .friendsGet,
							   httpMethod: .get,
							   params: params) { [weak self] (result: Result<VkFriendsMainResponse, Error>) in
			switch result {
			case .success(let friendsResponse):
				let friends = friendsResponse.response.items
				//self?.persistence.create(friends) { _ in }
				
				var sections = [FriendsSection]()
				DispatchQueue.global().async {
					guard let sortedSections = self?.formFriendsArray(from: friends) else {
						return
					}
					sections = sortedSections
				}
				
				DispatchQueue.main.async {
					// Ставим дату просрочки данных
					if let cacheKey = self?.cacheKey {
						self?.setExpiry(key: cacheKey, time: 10 * 60)
					}
					
					completion(sections)
				}
			case .failure(let error):
				debugPrint("Error: \(error.localizedDescription)")
			}
		}
	}
	
	/// Запрашивает кол-во друзей пользователя
	func getFriendsCount(completion: @escaping (Int) -> Void) {
		networkManager.request(method: .friendsGet,
							   httpMethod: .get,
							   params: [:]) { (result: Result<FriendsCountMainResponse, Error>) in
			switch result {
			case .success(let friendsResponse):
				completion(friendsResponse.response.count)
			case .failure(let error):
				debugPrint("Error: \(error.localizedDescription)")
			}
		}
	}
	
	/// Загружает все фото пользователя
	func loadUserPhotos(for id: String, completion: @escaping ([ApiImage]) -> Void) {
		let params = [
			"owner_id" : id,
			"count": "50",
		]
		networkManager.request(method: .photosGetAll,
							   httpMethod: .get,
							   params: params) { (result: Result<UserImagesMainResponse, Error>) in
			switch result {
			case .success(let imagesResponse):
				let imagesModels = imagesResponse.response.items
				completion(imagesModels)
			case .failure(_):
				break
			}
		}
	}
}

// MARK: - Private methods

private extension UserService {
	
	/// Раскидывает друзей по ключам, в зависимости от первой буквы имени
	private func sortFriends(_ array: [UserModel]) -> [Character: [UserModel]] {
		
		var newArray: [Character: [UserModel]] = [:]
		for user in array {
			//проверяем, чтобы строка имени не оказалась пустой
			guard let firstChar = user.name.first else {
				continue
			}
			
			// Если секции с таким ключом нет, то создадим её
			guard var array = newArray[firstChar] else {
				let newValue = [user]
				newArray.updateValue(newValue, forKey: firstChar)
				continue
			}
			
			// Если секция нашлась, то добавим в массив ещё модель
			array.append(user)
			newArray.updateValue(array, forKey: firstChar)
		}
		return newArray
	}
	
	private func formFriendsSections(_ array: [Character: [UserModel]]) -> [FriendsSection] {
		var sectionsArray: [FriendsSection] = []
		for (key, array) in array {
			sectionsArray.append(FriendsSection(key: key, data: array))
		}
		
		//Сортируем секции по алфавиту
		sectionsArray.sort { $0 < $1 }
		
		return sectionsArray
	}
	
	private func formFriendsArray(from array: [UserModel]?) -> [FriendsSection] {
		guard let array = array else {
			return []
		}
		let sorted = sortFriends(array)
		return formFriendsSections(sorted)
	}
}
