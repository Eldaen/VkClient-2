//
//  NewsBuilder.swift
//  VkClient-2
//
//  Created by Денис Сизов on 05.05.2022.
//

import UIKit

// MARK: - NewsBuilder
final class NewsBuilder {
	
	static func build() -> UIViewController {
		let networkManager = NetworkManager()
		let cache = ImageCacheManager()
		let service = NewsService(networkManager: networkManager, cache: cache)
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
