//
//  MyGroupsRouter.swift
//  VkClient-2
//
//  Created by Денис Сизов on 20.05.2022.
//

import UIKit

// MARK: - MyGroupsRouter
final class MyGroupsRouter {
	
	// MARK: - Properties
	
	weak var viewController: UIViewController?
}

// MARK: - VkLoginRouterInputProtocol
extension MyGroupsRouter: MyGroupsRouterInputProtocol {
	func navigateToSearchGroups() {
		guard let contoller = viewController as? MyGroupsViewInputProtocol else {
			return
		}
		viewController?.navigationController?.pushViewController(
			SearchGroupsBuilder.build(
				parentalControllerLink: contoller
			), animated: true
		)
	}
}
