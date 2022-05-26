//
//  SearchGroupsPresenter.swift
//  VkClient-2
//
//  Created by Денис Сизов on 20.05.2022.
//

import UIKit.UIImage

// MARK: - SearchGroupsPresenter
final class SearchGroupsPresenter {
	
	// MARK: - Properties
	
	var router: SearchGroupsRouterInputProtocol
	var interactor: SearchGroupsInteractorInputProtocol
	weak var view: SearchGroupsViewInputProtocol?
	
	// MARK: - Init
	
	init(
		router: SearchGroupsRouterInputProtocol,
		interactor: SearchGroupsInteractorInputProtocol,
		view: SearchGroupsViewInputProtocol
	) {
		self.router = router
		self.interactor = interactor
		self.view = view
	}
}

// MARK: - SearchGroupsViewOutputProtocol
extension SearchGroupsPresenter: SearchGroupsViewOutputProtocol {
	func fetchGroups() {
		interactor.fetchGroups() { [weak self] result in
			switch result {
			case .success (let groups):
				self?.view?.groups = groups
				self?.view?.filteredGroups = groups
				self?.view?.reloadTableView()
				self?.view?.stopLoadAnimation()
			case .failure:
				self?.view?.showGroupsLoadingErrorText("Не удалось загрузить группы")
			}
		}
	}
	
	func joinGroup(id: Int) {
		interactor.joinGroup(id: id) { [weak self] result in
			switch result {
			case .success:
				self?.router.navigateToMyGroups()
			case .failure:
				self?.view?.showGroupJoiningErrorText("Не удалось вступить в группу")
			}
		}
	}
	
	func loadImage(_ url: String, completion: @escaping (UIImage) -> Void) {
		interactor.loadImage(url) { image in
			completion(image)
		}
	}
	
	func search(_ query: String) {
		interactor.search(for: query) { [weak self] result in
			switch result {
			case .success (let groups):
				self?.view?.groups = groups
				self?.view?.filteredGroups = groups
				self?.view?.reloadTableView()
			case .failure:
				self?.view?.showGroupsLoadingErrorText("Не удалось загрузить найденные группы")
			}
		}
	}
	
	func cancelSearch() {
		view?.filteredGroups = view?.groups ?? []
	}
}

// MARK: - SearchGroupsInteractorOutputProtocol
extension SearchGroupsPresenter: SearchGroupsInteractorOutputProtocol {
	func showGroupJoiningError(_ error: Error) {
		view?.showGroupJoiningErrorText("Не удалось вступить в группу")
		debugPrint(error.localizedDescription)
	}
}
