//
//  DemoFriendsListBuilder.swift
//  VkClient-2
//
//  Created by Денис Сизов on 26.05.2022.
//

import UIKit

// MARK: - FriendsListBuilder
final class DemoFriendsListBuilder {
	
	/// Билдер модуля экрана списка друзей в демо режиме
	/// - Returns: Контроллер экрана списка друзей
	static func build() -> UIViewController {
		let networkManager = NetworkManager()
		let cache = ImageCacheManager()
		let service = DemoFriendsListService(networkManager: networkManager, cache: cache)
		let viewController = FriendsListViewController()
		let interactor = FriendsListInteractor(friendsService: service)
		let router = FriendsListRouter()
		let presenter = FriendsListPresenter(router: router, interactor: interactor, view: viewController)
		
		viewController.output = presenter
		presenter.interactor = interactor
		presenter.view = viewController
		router.viewController = viewController
		router.isDemoModeOn = true
		interactor.output = presenter
		
		return viewController
	}
}
