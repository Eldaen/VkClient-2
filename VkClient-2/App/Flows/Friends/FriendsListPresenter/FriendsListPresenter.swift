//
//  FriendsListPresenter.swift
//  VkClient-2
//
//  Created by Денис Сизов on 23.05.2022.
//

import UIKit.UIImage

// MARK: - FriendsListPresenter
final class FriendsListPresenter {
	
	// MARK: - Properties
	
	var router: FriendsListRouterInputProtocol
	var interactor: FriendsListInteractorInputProtocol
	weak var view: FriendsListViewInputProtocol?
	
	// MARK: - Init
	
	init(
		router: FriendsListRouterInputProtocol,
		interactor: FriendsListInteractorInputProtocol,
		view: FriendsListViewInputProtocol
	) {
		self.router = router
		self.interactor = interactor
		self.view = view
	}
}

// MARK: - FriendsListViewOutputProtocol
extension FriendsListPresenter: FriendsListViewOutputProtocol {
	func getFriendFromSection(at indexPath: IndexPath) -> UserModel? {
		guard let view = view else { return nil }
		guard indexPath.section < view.filteredFriends.count else { return nil }
		
		let section = view.filteredFriends[indexPath.section]
		guard indexPath.row < section.data.count else { return nil}
		
		let friend = section.data[indexPath.row]
		return friend
	}
	
	func fetchFriends() {
		interactor.fetchFriends { [weak self] result in
			switch result {
			case .success (let friends):
				self?.view?.friends = friends
				self?.view?.filteredFriends = friends
				self?.formSectionHeaders(for: friends)
				self?.view?.reloadTableView()
				self?.view?.stopLoadAnimation()
			case .failure:
				self?.view?.showFriendsLoadingErrorText("Не удалось загрузить список друзей")
			}
		}
	}
	
	func loadImage(_ url: String, completion: @escaping (UIImage) -> Void) {
		interactor.loadImage(url) { image in
			completion(image)
		}
	}
	
	func search(_ query: String) {
		interactor.search(for: query, in: view?.friends ?? []) { [weak self] friends in
			self?.view?.filteredFriends = friends
			self?.view?.reloadTableView()
		}
	}
	
	func cancelSearch() {
		view?.filteredFriends = view?.friends ?? []
	}
}

// MARK: - FriendsListnteractorOutputProtocol
extension FriendsListPresenter: FriendsListInteractorOutputProtocol {
	
}

// MARK: - Private methods
private extension FriendsListPresenter {
	func formSectionHeaders(for sections: [FriendsSection]) {
		var result = [String]()
		for section in sections {
			result.append(String(section.key))
		}
		view?.lettersOfNames = result
	}
}
