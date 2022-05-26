//
//  DemoFriendsProfileBuilder.swift
//  VkClient-2
//
//  Created by Денис Сизов on 26.05.2022.
//

import UIKit

// MARK: - DemoFriendsProfileBuilder
final class DemoFriendsProfileBuilder {
	
	/// Билдер модуля экрана профиля друга в демо режиме
	/// - Returns: Контроллер экрана профиля друга в демо режиме
	static func build() -> UIViewController {
		let networkManager = NetworkManager()
		let cache = ImageCacheManager()
		let service = DemoFriendsListService(networkManager: networkManager, cache: cache)
		let viewController = FriendsProfileViewController()
		let interactor = FriendsProfileInteractor(friendsService: service)
		let router = FriendsProfileRouter()
		let presenter = FriendsProfilePresenter(
			router: router,
			interactor: interactor,
			view: viewController,
			friend: UserModel(name: "Вася", image: "vasia", id: 1)
		)
		
		viewController.output = presenter
		presenter.interactor = interactor
		presenter.view = viewController
		router.viewController = viewController
		router.isDemoModeOn = true
		interactor.output = presenter
		
		return viewController
	}
}
