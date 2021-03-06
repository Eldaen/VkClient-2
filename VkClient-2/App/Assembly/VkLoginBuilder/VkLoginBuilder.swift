//
//  VkLoginBuilder.swift
//  VkClient-2
//
//  Created by Денис Сизов on 26.04.2022.
//

import UIKit

// MARK: - VkLoginBuilder
final class VkLoginBuilder {
	
	/// Билд модуля отображения экрана авторизации
	/// - Returns: UIViewController для отображения экрана авторизации
	static func build(restartDelegate: RestartDelegate) -> UIViewController {
		let service = VkLoginService()
		let router = VkLoginRouter()
		let viewController = VkLoginViewController()
		let presenter = VkLoginPresenter()
		let interactor = VkLoginInteractor()
		
		router.viewController = viewController
		router.restartDelegate = restartDelegate
		viewController.output = presenter
		presenter.interactor = interactor
		presenter.view = viewController
		presenter.router = router
		interactor.service = service
		
		return viewController
	}
}
