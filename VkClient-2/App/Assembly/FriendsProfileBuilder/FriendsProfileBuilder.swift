//
//  FriendsProfileBuilder.swift
//  VkClient-2
//
//  Created by Денис Сизов on 23.05.2022.
//

import UIKit

// MARK: - FriendsListBuilder
final class FriendsProfileBuilder {
	
	/// Билдер модуля экрана профиля друга
	/// - Returns: Контроллер экрана профиля друга
	static func build(userModel: UserModel) -> UIViewController {
		let networkManager = NetworkManager()
		let cache = ImageCacheManager()
		let service = UserService(networkManager: networkManager, cache: cache)
		let viewController = FriendsProfileViewController()
		let interactor = FriendsProfileInteractor(friendsService: service)
		let router = FriendsProfileRouter()
		let presenter = FriendsProfilePresenter(
			router: router,
			interactor: interactor,
			view: viewController,
			friend: userModel
		)
		
		viewController.output = presenter
		presenter.interactor = interactor
		presenter.view = viewController
		router.viewController = viewController
		interactor.output = presenter
		
		return viewController
	}
}
