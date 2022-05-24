//
//  GalleryBuilder.swift
//  VkClient-2
//
//  Created by Денис Сизов on 24.05.2022.
//

import UIKit

// MARK: - GalleryBuilder
final class GalleryBuilder {
	
	/// Билдер модуля экрана подробно просмотра фото
	/// - Returns: Контроллер экрана подробно просмотра фото
	static func build(photoId: Int, imageModels: [ApiImage]) -> UIViewController {
//		let networkManager = NetworkManager()
//		let cache = ImageCacheManager()
//		let service = UserService(networkManager: networkManager, cache: cache)
//		let viewController = FriendsProfileViewController()
//		let interactor = FriendsProfileInteractor(friendsService: service)
//		let router = FriendsProfileRouter()
//		let presenter = FriendsProfilePresenter(
//			router: router,
//			interactor: interactor,
//			view: viewController,
//			friend: userModel
//		)
//
//		viewController.output = presenter
//		presenter.interactor = interactor
//		presenter.view = viewController
//		router.viewController = viewController
//		interactor.output = presenter
//
//		return viewController
		return UIViewController()
	}
}
