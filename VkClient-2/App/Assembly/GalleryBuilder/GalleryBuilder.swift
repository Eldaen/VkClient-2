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
		let networkManager = NetworkManager()
		let cache = ImageCacheManager()
		let persistenceManager = DataStoreManager()
		let service = UserService(networkManager: networkManager, cache: cache, persistence: persistenceManager)
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
