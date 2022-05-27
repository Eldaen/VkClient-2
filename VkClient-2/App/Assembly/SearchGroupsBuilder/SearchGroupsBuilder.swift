//
//  SearchGroupsBuilder.swift
//  VkClient-2
//
//  Created by Денис Сизов on 20.05.2022.
//

import UIKit

// MARK: - SearchGroupsBuilder
final class SearchGroupsBuilder {
	
	/// Билдер модуля экрана поиска групп
	/// - Returns: Контроллер экрана поиска групп
	static func build(parentalControllerLink: MyGroupsViewInputProtocol) -> UIViewController {
		let networkManager = NetworkManager()
		let persistenceManager = DataStoreManager()
		let cache = ImageCacheManager()
		let service = GroupsService(networkManager: networkManager, cache: cache, persistence: persistenceManager)
		let viewController = SearchGroupsViewController()
		let interactor = SearchGroupsInteractor(groupsService: service)
		let router = SearchGroupsRouter()
		let presenter = SearchGroupsPresenter(router: router, interactor: interactor, view: viewController)
		
		viewController.output = presenter
		presenter.interactor = interactor
		presenter.view = viewController
		router.viewController = viewController
		router.parentalController = parentalControllerLink
		interactor.output = presenter
		
		return viewController
	}
}
