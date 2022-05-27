//
//  DemoFriendsListService.swift
//  VkClient-2
//
//  Created by Денис Сизов on 26.05.2022.
//

import UIKit.UIImage

// MARK: - DemoFriendsListService
final class DemoFriendsListService {
	
	// MARK: - Properties
	
	var friends: [UserModel] = []
	var networkManager: NetworkManagerProtocol
	var cache: ImageCacheInput
	
	// MARK: - Init
	
	required init(networkManager: NetworkManagerProtocol, cache: ImageCacheInput) {
		self.networkManager = networkManager
		self.cache = cache
	}
}

// MARK: - UserLoader
extension DemoFriendsListService: UserLoader {
	func loadFriends(completion: @escaping (Result<[FriendsSection], Error>) -> Void) {
		
		// читаем файлик ./friends.json
		if let filepath = Bundle.main.path(forResource: "friends", ofType: "json") {
			do {
				let contents = try Data(contentsOf: URL(fileURLWithPath: filepath))
				let decodedData = try JSONDecoder().decode([UserModel].self, from: contents)
				friends = decodedData
			} catch {
				print(error)
			}
		}
		
		let sortedArray = sortFriends(friends)
		let sectionsArray = formFriendsSections(sortedArray)
		completion(.success(sectionsArray))
	}
	
	func loadUserPhotos(for id: String, completion: @escaping (Result<[ApiImage], Error>) -> Void) {
		let images = [
			ApiImage(sizes: [
				ImageSizes(url: "vasia", type: "x", height: 320, width: 240),
				ImageSizes(url: "vasia", type: "m", height: 320, width: 240)
			]),
			ApiImage(sizes: [
				ImageSizes(url: "vasia", type: "x", height: 320, width: 240),
				ImageSizes(url: "vasia", type: "m", height: 320, width: 240)
			]),
			ApiImage(sizes: [
				ImageSizes(url: "vasia", type: "x", height: 320, width: 240),
				ImageSizes(url: "vasia", type: "m", height: 320, width: 240)
			]),
			ApiImage(sizes: [
				ImageSizes(url: "vasia", type: "x", height: 320, width: 240),
				ImageSizes(url: "vasia", type: "m", height: 320, width: 240)
			]),
			ApiImage(sizes: [
				ImageSizes(url: "vasia", type: "x", height: 320, width: 240),
				ImageSizes(url: "vasia", type: "m", height: 320, width: 240)
			]),
			ApiImage(sizes: [
				ImageSizes(url: "vasia", type: "x", height: 320, width: 240),
				ImageSizes(url: "vasia", type: "m", height: 320, width: 240)
			]),
			ApiImage(sizes: [
				ImageSizes(url: "vasia", type: "x", height: 320, width: 240),
				ImageSizes(url: "vasia", type: "m", height: 320, width: 240)
			]),
			ApiImage(sizes: [
				ImageSizes(url: "vasia", type: "x", height: 320, width: 240),
				ImageSizes(url: "vasia", type: "m", height: 320, width: 240)
			]),
			ApiImage(sizes: [
				ImageSizes(url: "vasia", type: "x", height: 320, width: 240),
				ImageSizes(url: "vasia", type: "m", height: 320, width: 240)
			]),
			ApiImage(sizes: [
				ImageSizes(url: "vasia", type: "x", height: 320, width: 240),
				ImageSizes(url: "vasia", type: "m", height: 320, width: 240)
			]),
			ApiImage(sizes: [
				ImageSizes(url: "vasia", type: "x", height: 320, width: 240),
				ImageSizes(url: "vasia", type: "m", height: 320, width: 240)
			]),
			ApiImage(sizes: [
				ImageSizes(url: "vasia", type: "x", height: 320, width: 240),
				ImageSizes(url: "vasia", type: "m", height: 320, width: 240)
			]),
			ApiImage(sizes: [
				ImageSizes(url: "vasia", type: "x", height: 320, width: 240),
				ImageSizes(url: "vasia", type: "m", height: 320, width: 240)
			]),
		]
		completion(.success(images))
	}
	
	func getFriendsCount(completion: @escaping (Int) -> Void) {
		completion(135)
	}
	
	func loadImage(url: String, completion: @escaping (UIImage) -> Void) {
		guard let image = UIImage(named: url) else {
			return
		}
		completion(image)
	}
}

// MARK: - Private methods
private extension DemoFriendsListService {
	
	// Раскидываем друзей по ключам, в зависимости от первой буквы имени
	func sortFriends(_ array: [UserModel]) -> [Character: [UserModel]] {
		
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
	
	func formFriendsSections(_ array: [Character: [UserModel]]) -> [FriendsSection] {
		var sectionsArray: [FriendsSection] = []
		for (key, array) in array {
			sectionsArray.append(FriendsSection(key: key, data: array))
		}
		
		//Сортируем секции по алфавиту
		sectionsArray.sort { $0 < $1 }
		
		return sectionsArray
	}
}
