//
//  DemoGroupsService.swift
//  VkClient-2
//
//  Created by Денис Сизов on 26.05.2022.
//

import UIKit.UIImage

// MARK: - DemoGroupsService
final class DemoGroupsService {
	
	// MARK: - Properties
	
	var groups: [GroupModel] = []
	var networkManager: NetworkManagerProtocol
	var cache: ImageCacheInput
	
	// MARK: - Init
	
	required init(networkManager: NetworkManagerProtocol, cache: ImageCacheInput) {
		self.networkManager = networkManager
		self.cache = cache
	}
}

// MARK: - GroupsLoader
extension DemoGroupsService: GroupsLoader {
	func loadGroups(completion: @escaping (Result<[GroupModel], Error>) -> Void) {
		
		// читаем файлик ./groups.json
		if let filepath = Bundle.main.path(forResource: "groups", ofType: "json") {
			do {
				let contents = try Data(contentsOf: URL(fileURLWithPath: filepath))
				let decodedData = try JSONDecoder().decode([GroupModel].self, from: contents)
				groups = decodedData
				completion(.success(decodedData))
			} catch {
				print(error)
			}
		}
	}
	
	func searchGroups(with query: String, completion: @escaping (Result<[GroupModel], Error>) -> Void) {
		var filteredGroups: [GroupModel] = []
		
		// Если строка поиска пустая, то показываем все группы
		if query == "" {
			filteredGroups = groups
			completion(.success(filteredGroups))
		} else {
			for group in groups {
				if group.name.lowercased().contains(query.lowercased()) {
					filteredGroups.append(group)
				}
			}
			completion(.success(filteredGroups))
		}
	}
	
	func joinGroup(id: Int, completion: @escaping (Result<Int, Error>) -> Void) {
		completion(.success(1))
	}
	
	func leaveGroup(id: Int, completion: @escaping (Result<Int, Error>) -> Void) {
		completion(.success(1))
	}
	
	func loadImage(url: String, completion: @escaping (UIImage) -> Void) {
		guard let image = UIImage(named: url) else {
			return
		}
		completion(image)
	}
}
