//
//  MyGroupsInteractor.swift
//  VkClient-2
//
//  Created by Денис Сизов on 20.05.2022.
//

import UIKit

// MARK: - MyGroupsInteractor
final class MyGroupsInteractor {
	
	// MARK: - Properties
	
	/// Cервис по работе с группами
	private var groupsLoader: GroupsLoader
	
	// MARK: - Init
	
	init(groupsService: GroupsLoader) {
		self.groupsLoader = groupsService
	}
}

// MARK: - MyGroupsInteractorInputProtocol
extension MyGroupsInteractor: MyGroupsInteractorInputProtocol {
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
	
	func loadImage(_ url: String, completion: @escaping (UIImage) -> Void) {
		groupsLoader.loadImage(url: url) { image in
			completion(image)
		}
	}
}
