//
//  MyGroupsPresenter.swift
//  VkClient-2
//
//  Created by Денис Сизов on 20.05.2022.
//

import UIKit

// MARK: - MyGroupsPresenter
final class MyGroupsPresenter {
	
	// MARK: - Properties
	
	var router: MyGroupsRouterInputProtocol
	var interactor: MyGroupsInteractorInputProtocol
	var view: MyGroupsViewInputProtocol
	
	// MARK: - Init
	
	init(
		router: MyGroupsRouterInputProtocol,
		interactor: MyGroupsInteractorInputProtocol,
		view: MyGroupsViewInputProtocol
	) {
		self.router = router
		self.interactor = interactor
		self.view = view
	}
}

// MARK: - MyGroupsViewOutputProtocol
extension MyGroupsPresenter: MyGroupsViewOutputProtocol {
	func fetchGroups() {
		interactor.fetchGroups() { [weak self] result in
			switch result {
			case .success (let groups):
				self?.view.groups = groups
			case .failure(let error):
				self?.view.showGroupsLoadingError(error)
			}
		}
	}
	
	func loadImage(_ url: String, completion: @escaping (UIImage) -> Void) {
		interactor.loadImage(url) { image in
			completion(image)
		}
	}
	
	func navigateToSearchGroups() {
		router.navigateToSearchGroups()
	}
}
