//
//  DemoGalleryBuilder.swift
//  VkClient-2
//
//  Created by Денис Сизов on 26.05.2022.
//

import UIKit

// MARK: - DemoGalleryBuilder
final class DemoGalleryBuilder {
	
	/// Билдер модуля экрана подробно просмотра фото в демо режиме
	/// - Returns: Контроллер экрана подробно просмотра фото в демо режиме
	static func build(photoId: Int, imageModels: [ApiImage]) -> UIViewController {
		let networkManager = NetworkManager()
		let cache = ImageCacheManager()
		let service = DemoFriendsListService(networkManager: networkManager, cache: cache)
		let viewController = GalleryViewController()
		let interactor = GalleryInteractor(friendsService: service, images: imageModels)
		let presenter = GalleryPresenter(
			interactor: interactor,
			view: viewController,
			selectedPhoto: photoId
		)
		
		viewController.output = presenter
		presenter.interactor = interactor
		presenter.view = viewController
		interactor.output = presenter
		
		return viewController
	}
}
