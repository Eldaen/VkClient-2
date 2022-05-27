//
//  VkLoginRouter.swift
//  VkClient-2
//
//  Created by Денис Сизов on 05.05.2022.
//

import UIKit

// MARK: - VkLoginRouter
final class VkLoginRouter {
	weak var viewController: UIViewController?
	weak var restartDelegate: RestartDelegate?
}

// MARK: - VkLoginRouterInputProtocol
extension VkLoginRouter: VkLoginRouterInputProtocol {
	func pushRealApp() {
		viewController?.navigationController?.pushViewController(
			TabBarController(isDemoModeEnabled: false, restartDelegate: restartDelegate),
			animated: true
		)
	}
	
	func pushDemoApp() {
		viewController?.navigationController?.pushViewController(
			TabBarController(isDemoModeEnabled: true, restartDelegate: restartDelegate),
			animated: true
		)
	}
}
