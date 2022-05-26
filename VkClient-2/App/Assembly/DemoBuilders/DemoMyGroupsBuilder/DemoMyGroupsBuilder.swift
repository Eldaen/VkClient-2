//
//  DemoMyGroupsBuilder.swift
//  VkClient-2
//
//  Created by Денис Сизов on 26.05.2022.
//

import UIKit

// MARK: - DemoMyGroupsBuilder
final class DemoMyGroupsBuilder {
	
	/// Билдер модуля экрана отображения групп пользователя в демо режиме
	/// - Returns: Контроллер экрана групп пользователя
	static func build() -> MyCustomUIViewController {
		let networkManager = NetworkManager()
		let cache = ImageCacheManager()
		let service = DemoGroupsService(networkManager: networkManager, cache: cache)
		let viewController = MyGroupsViewController()
		let interactor = MyGroupsInteractor(groupsService: service)
		let router = MyGroupsRouter()
		let presenter = MyGroupsPresenter(router: router, interactor: interactor, view: viewController)
		
		viewController.output = presenter
		presenter.interactor = interactor
		presenter.view = viewController
		router.viewController = viewController
		interactor.output = presenter
		
		return viewController
	}
}
