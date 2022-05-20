//
//  SearchGroupsPresenter.swift
//  VkClient-2
//
//  Created by Денис Сизов on 20.05.2022.
//

import UIKit.UIImage

// MARK: - SearchGroupsPresenter
final class SearchGroupsPresenter {
	
}

// MARK: - SearchGroupsViewOutputProtocol
extension SearchGroupsPresenter: SearchGroupsViewOutputProtocol {
	func fetchGroups() {
		
	}
	
	func joinGroup(id: Int, index: IndexPath) {
		
	}
	
	func loadImage(_ url: String, completion: @escaping (UIImage) -> Void) {
		
	}
	
	func search(_ query: String) {
		
	}
	
	func cancelSearch() {
		
	}
}

// MARK: - SearchGroupsInteractorOutputProtocol
extension SearchGroupsPresenter: SearchGroupsInteractorOutputProtocol {
	func showGroupJoiningError(_ error: Error) {
		
	}
}
