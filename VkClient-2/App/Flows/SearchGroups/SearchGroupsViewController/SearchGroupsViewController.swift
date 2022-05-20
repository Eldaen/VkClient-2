//
//  SearchGroupsViewController.swift
//  VkClient-2
//
//  Created by Денис Сизов on 20.05.2022.
//

import UIKit

// MARK: - SearchGroupsViewController
final class SearchGroupsViewController: UIViewController {
	
	// MARK: - Properties
	
	var groups = [GroupModel]()
	var filteredGroups = [GroupModel]()
	
}

// MARK: - SearchGroupsViewInputProtocol
extension SearchGroupsViewController: SearchGroupsViewInputProtocol {
	
	func reloadTableView() {
		
	}
	
	func showGroupsLoadingErrorText(_ text: String) {
		
	}
	
	func showGroupJoiningErrorText(_ text: String) {
		
	}
}
