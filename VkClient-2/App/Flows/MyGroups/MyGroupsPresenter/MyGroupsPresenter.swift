//
//  MyGroupsPresenter.swift
//  VkClient-2
//
//  Created by Денис Сизов on 20.05.2022.
//

import UIKit.UIImage

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
	func search(_ query: String) {
		interactor.search(for: query, in: view?.groups ?? []) { [weak self] groups in
			self?.view?.filteredGroups = groups
			self?.view?.stopLoadAnimation()
			self?.view?.reloadTableView()
		}
	}
	
	func cancelSearch() {
		view?.filteredGroups = view?.groups ?? []
	}
	
	func leaveGroup(id: Int, index: IndexPath) {
		interactor.leaveGroup(id: id, index: index)
	}
	
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
		view?.filteredGroups.remove(at: indexPath.row)
		view?.deleteGroupFromView(at: indexPath)
		view?.startLoadAnimation()
		
		interactor.fetchGroups() { [weak self] result in
			switch result {
			case .success (let groups):
				self?.view?.groups = groups
				self?.view?.stopLoadAnimation()
			case .failure(let error):
				debugPrint(error.localizedDescription)
			}
		}
	}
	
	func showGroupLeavingError(_ error: Error) {
		view?.showGroupsLeavingErrorText("Не удалось выйти из группы")
	}
}
