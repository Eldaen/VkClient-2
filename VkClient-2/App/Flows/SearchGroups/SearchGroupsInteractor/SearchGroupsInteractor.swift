//
//  SearchGroupsInteractor.swift
//  VkClient-2
//
//  Created by Денис Сизов on 20.05.2022.
//

import Foundation

// MARK: - SearchGroupsInteractor
final class SearchGroupsInteractor {
	
}

// MARK: - SearchGroupsInteractorInputProtocol
extension SearchGroupsInteractor: SearchGroupsInteractorInputProtocol {
	func fetchGroups(_ completion: @escaping (Result<[GroupModel], Error>) -> Void) {
		
	}
	
	func joinGroup(id: Int, index: IndexPath) {
		
	}
	
	func loadImage(_ url: String, completion: @escaping (UIImage) -> Void) {
		
	}
	
	func search(for query: String, in groups: [GroupModel], completion: @escaping ([GroupModel]) -> Void) {
		
	}
}
