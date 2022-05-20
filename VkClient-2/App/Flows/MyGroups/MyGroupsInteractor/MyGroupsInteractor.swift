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
	
	/// Cсылка на презентер
	weak var output: MyGroupsInteractorOutputProtocol?
	
	/// Cервис по работе с группами
	private var groupsLoader: GroupsLoader
	
	// MARK: - Init
	
	init(groupsService: GroupsLoader) {
		self.groupsLoader = groupsService
	}
}

// MARK: - MyGroupsInteractorInputProtocol
extension MyGroupsInteractor: MyGroupsInteractorInputProtocol {
	func leaveGroup(id: Int, index: IndexPath) {
		groupsLoader.leaveGroup(id: id) { [weak self] result in
			switch result {
			case .success(let resultCode):
				if resultCode == 1 {
					self?.output?.removeGroup(at: index)
				} else {
					debugPrint("Group leaving code was \(resultCode)")
				}
			case .failure(let error):
				self?.output?.showGroupsLeavingError(error)
				debugPrint(error.localizedDescription)
			}
		}
	}
	
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
