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
	weak var view: MyGroupsViewInputProtocol?
	
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
	func leaveGroup(id: Int, index: IndexPath) {
		interactor.leaveGroup(id: id, index: index)
	}
	
	func fetchGroups() {
		interactor.fetchGroups() { [weak self] result in
			switch result {
			case .success (let groups):
				self?.view?.groups = groups
				self?.view?.reloadTableView()
			case .failure:
				self?.view?.showGroupsLoadingErrorText("Не удалось загрузить группы")
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

// MARK: - MyGroupsInteractorOutputProtocol
extension MyGroupsPresenter: MyGroupsInteractorOutputProtocol {
	func removeGroup(at indexPath: IndexPath) {
		view?.groups.remove(at: indexPath.row)
		view?.deleteGroupFromView(at: indexPath)
	}
	
	func showGroupsLeavingError(_ error: Error) {
		view?.showGroupsLeavingErrorText("Не удалось выйти из группы")
	}
}
