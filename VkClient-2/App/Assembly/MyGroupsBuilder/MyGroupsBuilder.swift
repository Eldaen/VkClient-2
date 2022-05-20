//
//  MyGroupsBuilder.swift
//  VkClient-2
//
//  Created by Денис Сизов on 05.05.2022.
//

import UIKit

// MARK: - MyGroupsBuilder
final class MyGroupsBuilder {
	
	/// Билдер модуля экрана отображения групп пользователя
	/// - Returns: Контроллер экрана групп пользователя
	static func build() -> UIViewController {
		let networkManager = NetworkManager()
		let cache = ImageCacheManager()
		let service = GroupsService(networkManager: networkManager, cache: cache)
		let viewController = MyGroupsViewController()
		let interactor = MyGroupsInteractor(groupsService: service)
		let router = MyGroupsRouter()
		let presenter = MyGroupsPresenter(router: router, interactor: interactor, view: viewController)
		
		viewController.output = presenter
		presenter.interactor = interactor
		presenter.view = viewController
		router.viewController = viewController
		
		return viewController
	}
}
