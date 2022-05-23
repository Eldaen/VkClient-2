//
//  SearchGroupsRouter.swift
//  VkClient-2
//
//  Created by Денис Сизов on 20.05.2022.
//

import UIKit

// MARK: - SearchGroupsRouter
final class SearchGroupsRouter {
	
	// MARK: - Properties
	
	weak var viewController: UIViewController?
}

// MARK: - SearchGroupsRouterInputProtocol
extension SearchGroupsRouter: SearchGroupsRouterInputProtocol {
	func navigateToMyGroups() {
		viewController?.navigationController?.popViewController(animated: true)
	}
}
