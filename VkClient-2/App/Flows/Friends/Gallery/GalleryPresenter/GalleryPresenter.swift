//
//  GalleryPresenter.swift
//  VkClient-2
//
//  Created by Денис Сизов on 24.05.2022.
//

import UIKit.UIImage

// MARK: - GalleryPresenter
final class GalleryPresenter {

	// MARK: - Properties
	
	var interactor: FriendsProfileInteractorInputProtocol
	weak var view: FriendsProfileViewInputProtocol?
	
	// MARK: - Init
	
	init(interactor: FriendsProfileInteractorInputProtocol, view: FriendsProfileViewInputProtocol) {
		self.interactor = interactor
		self.view = view
	}
}

// MARK: - GalleryViewOutputProtocol
extension GalleryPresenter: GalleryViewOutputProtocol {
	func fetchPhotos(array: [Int]) {
		
	}
	
	func loadImage(_ url: String, completion: @escaping (UIImage) -> Void) {
		
	}
	
	func getStoredImages() {
		
	}
}

// MARK: - GalleryInteractorOutputProtocol
extension GalleryPresenter: GalleryInteractorOutputProtocol {
	
}
