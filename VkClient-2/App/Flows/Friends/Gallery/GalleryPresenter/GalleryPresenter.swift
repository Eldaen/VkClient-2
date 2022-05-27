//
//  GalleryPresenter.swift
//  VkClient-2
//
//  Created by Денис Сизов on 24.05.2022.
//

import UIKit

// MARK: - GalleryPresenter
final class GalleryPresenter {
	
	// MARK: - Properties
	
	var interactor: GalleryInteractorInputProtocol
	weak var view: GalleryViewInputProtocol?
	var selectedPhoto: Int
	
	// MARK: - Init
	
	init(
		interactor: GalleryInteractorInputProtocol,
		view: GalleryViewInputProtocol,
		selectedPhoto: Int
	) {
		self.interactor = interactor
		self.view = view
		self.selectedPhoto = selectedPhoto
	}
}

// MARK: - GalleryViewOutputProtocol
extension GalleryPresenter: GalleryViewOutputProtocol {
	func fetchPhotos(array: [Int]) {
		guard let view = view else { return }
		for index in array {
			interactor.loadImage(view.storedImages[index]) { [weak self] image in
				guard let view = self?.view else { return }
				view.photoViews[index].image = image
				view.photoViews[index].layoutIfNeeded()
			}
		}
	}
	
	func getStoredImages() {
		interactor.getStoredImages() { [weak self] imageLinks in
			self?.view?.storedImages = imageLinks
		}
	}
	
	func createImageViews() {
		guard let viewInput = view else { return }
		for _ in viewInput.storedImages {
			let view = UIImageView()
			view.contentMode = .scaleAspectFit
			
			viewInput.photoViews.append(view)
		}
	}
}

// MARK: - GalleryInteractorOutputProtocol
extension GalleryPresenter: GalleryInteractorOutputProtocol {
	
}
