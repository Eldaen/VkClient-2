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
}

// MARK: - VkLoginRouterInputProtocol
extension VkLoginRouter: VkLoginRouterInputProtocol {

	/// Переход на таб бар контроллер
	func pushRealApp() {
		viewController?.navigationController?.pushViewController(TabBarController(), animated: true)
	}
	
	/// Переход на таб бар контроллер со статическими данными
	func pushDemoApp() {
		// TODO: Добавить демо режим
	}
}
