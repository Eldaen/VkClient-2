//
//  SearchGroupsInteractor.swift
//  VkClient-2
//
//  Created by Денис Сизов on 20.05.2022.
//

import UIKit.UIImage

// MARK: - SearchGroupsInteractor
final class SearchGroupsInteractor {
	
	// MARK: - Properties
	
	/// Cсылка на презентер
	weak var output: SearchGroupsInteractorOutputProtocol?
	
	/// Cервис по работе с группами
	private var groupsLoader: GroupsLoader
	
	// MARK: - Init
	
	init(groupsService: GroupsLoader) {
		self.groupsLoader = groupsService
	}
}

// MARK: - SearchGroupsInteractorInputProtocol
extension SearchGroupsInteractor: SearchGroupsInteractorInputProtocol {
	func fetchGroups(_ completion: @escaping (Result<[GroupModel], Error>) -> Void) {
		groupsLoader.loadGroups { result in
			switch result {
			case .success(let groups):
				completion(.success(groups))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
	
	func joinGroup(id: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
		groupsLoader.joinGroup(id: id) { result in
			switch result {
			case .success(let result):
				if result == 1 { // 1 это если получилось вступить
					completion(.success(true))
				} else {
					completion(.success(false))
				}
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
	
	func loadImage(_ url: String, completion: @escaping (UIImage) -> Void) {
		groupsLoader.loadImage(url: url) { image in
			completion(image)
		}
	}
	
	func search(for query: String, completion: @escaping (Result<[GroupModel], Error>) -> Void) {
		var queryText = query
		
		// Если отправить запрос с пустой строкой поиска, то оно не будет искать, так что ищем с пробелом
		if queryText == "" {
			queryText = " "
		}
		
		groupsLoader.searchGroups(with: queryText) { result in
			switch result {
			case .success(let groups):
				completion(.success(groups))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
}
