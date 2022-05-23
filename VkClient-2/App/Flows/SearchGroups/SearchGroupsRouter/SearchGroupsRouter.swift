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
	
	/// Ссылка на родительский контроллер, чтобы обновлять список групп при переходе обратно
	weak var parentalController: MyGroupsViewInputProtocol?
}

// MARK: - SearchGroupsRouterInputProtocol
extension SearchGroupsRouter: SearchGroupsRouterInputProtocol {
	func navigateToMyGroups() {
		parentalController?.reloadViewData()
		viewController?.navigationController?.popViewController(animated: true)
	}
}
