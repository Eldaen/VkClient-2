//
//  FriendsProfilePresenter.swift
//  VkClient-2
//
//  Created by Денис Сизов on 23.05.2022.
//

import UIKit.UIImage

// MARK: - FriendsProfilePresenter
final class FriendsProfilePresenter {
	
	// MARK: - Properties
	
	var router: FriendsProfileRouterInputProtocol
	var interactor: FriendsProfileInteractorInputProtocol
	weak var view: FriendsProfileViewInputProtocol?
	
	/// ID друга, чей профиль открываем
	var friend: UserModel
	
	// MARK: - Init
	
	init(
		router: FriendsProfileRouterInputProtocol,
		interactor: FriendsProfileInteractorInputProtocol,
		view: FriendsProfileViewInputProtocol,
		friend: UserModel
	) {
		self.router = router
		self.interactor = interactor
		self.view = view
		self.friend = friend
	}
}

// MARK: - FriendsProfileViewOutputProtocol
extension FriendsProfilePresenter: FriendsProfileViewOutputProtocol {
	func loadProfile() {
		interactor.loadUserPhotos(for: String(friend.id)) { [weak self] result in
			switch result {
			case .success(let images):
				self?.view?.storedImages = images
				self?.view?.stopLoadAnimation()
				self?.view?.reloadСollectionView()
			case .failure:
				self?.view?.showProfileLoadingErrorText("Не удалось загрузить фото")
			}
		}
	}
	
	func loadImage(_ url: String, completion: @escaping (UIImage) -> Void) {
		interactor.loadImage(url) { image in
			completion(image)
		}
	}
}

// MARK: - FriendsProfileInteractorOutputProtocol
extension FriendsProfilePresenter: FriendsProfileInteractorOutputProtocol {
	
}

// MARK: - Private methods
private extension FriendsProfilePresenter {
	
}
