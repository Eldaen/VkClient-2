//
//  FriendsProfileInteractor.swift
//  VkClient-2
//
//  Created by Денис Сизов on 23.05.2022.
//

import UIKit.UIImage

// MARK: - FriendsProfileInteractor
final class FriendsProfileInteractor {
	
	// MARK: - Properties
	
	/// Cсылка на презентер
	weak var output: FriendsProfileInteractorOutputProtocol?
	
	/// Сохранённые модели фото пользователя
	var storedModels = [ApiImage]()
	
	/// Cервис по работе с группами
	private var friendsLoader: UserLoader
	
	// MARK: - Init
	
	init(friendsService: UserLoader) {
		self.friendsLoader = friendsService
	}
}

// MARK: - FriendsProfileInteractorInputProtocol
extension FriendsProfileInteractor: FriendsProfileInteractorInputProtocol {
	func loadUserPhotos(for id: String, completion: @escaping (Result<[String], Error>) -> Void) {
		friendsLoader.loadUserPhotos(for: id) { [weak self] result in
			switch result {
			case .success(let images):
				self?.storedModels = images
				if let imagesLinks = self?.friendsLoader.sortImage(by: "m", from: images) {
					completion(.success(imagesLinks))
				} else {
					debugPrint("Не удалось отфильтровать картинки из модели")
				}
			case .failure(let error):
				completion(.failure(error))
				debugPrint(error.localizedDescription)
			}
		}
	}
	
	func loadImage(_ url: String, completion: @escaping (UIImage) -> Void) {
		friendsLoader.loadImage(url: url) { image in
			completion(image)
		}
	}
}

// MARK: - Private methods
private extension FriendsProfileInteractor {
	
}
