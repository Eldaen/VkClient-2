//
//  GalleryInteractor.swift
//  VkClient-2
//
//  Created by Денис Сизов on 24.05.2022.
//

import UIKit.UIImage

// MARK: - GalleryInteractor
final class GalleryInteractor {
	
	// MARK: - Properties
	
	/// Cсылка на презентер
	weak var output: GalleryInteractorOutputProtocol?
	
	/// Сохранённые модели фото пользователя
	var storedModels: [ApiImage]
	
	/// Cтандартный размер изображений для галереи
	var defaultImageSize: String = "x"
	
	/// Cервис по работе с группами
	private var friendsLoader: UserLoader
	
	// MARK: - Init
	
	init(friendsService: UserLoader, images: [ApiImage]) {
		self.friendsLoader = friendsService
		self.storedModels = images
	}
}

// MARK: - GalleryInteractorInputProtocol
extension GalleryInteractor: GalleryInteractorInputProtocol {
	func loadImage(_ url: String, completion: @escaping (UIImage) -> Void) {
		friendsLoader.loadImage(url: url) { image in
			completion(image)
		}
	}
	
	func getStoredImages(completion: @escaping ([String]) -> Void) {
		let imageLinks = friendsLoader.sortImage(by: defaultImageSize, from: storedModels)
		completion(imageLinks)
	}
}
