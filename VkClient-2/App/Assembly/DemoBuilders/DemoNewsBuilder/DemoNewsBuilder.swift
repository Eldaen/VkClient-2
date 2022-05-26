//
//  DemoNewsBuilder.swift
//  VkClient-2
//
//  Created by Денис Сизов on 26.05.2022.
//

import UIKit

// MARK: - NewsBuilder
final class DemoNewsBuilder {
	
	// Билдер модуля экрана ленты новостей
	/// - Returns: Контроллер экрана ленты новостей
	static func build() -> MyCustomUIViewController {
		let networkManager = NetworkManager()
		let cache = ImageCacheManager()
		let service = DemoNewsService(networkManager: networkManager, cache: cache)
		let viewController = NewsViewController()
		let interactor = NewsInteractor(newsService: service)
		let presenter = NewsPresenter(
			interactor: interactor,
			view: viewController
		)
		
		viewController.output = presenter
		presenter.interactor = interactor
		presenter.view = viewController
		interactor.output = presenter
		
		return viewController
	}
}
