//
//  MyGroupsRouter.swift
//  VkClient-2
//
//  Created by Денис Сизов on 20.05.2022.
//

import UIKit

// MARK: - MyGroupsRouter
final class MyGroupsRouter {
	weak var viewController: UIViewController?
}

// MARK: - VkLoginRouterInputProtocol
extension MyGroupsRouter: MyGroupsRouterInputProtocol {
	func navigateToSearchGroups() {
		viewController?.navigationController?.pushViewController(SearchGroupsBuilder.build(), animated: true)
	}
}
