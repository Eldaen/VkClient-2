//
//  NewsPresenter.swift
//  VkClient-2
//
//  Created by Денис Сизов on 25.05.2022.
//

import UIKit.UIImage

// MARK: - NewsPresenter
final class NewsPresenter {
	
	// MARK: - Properties
	
	var interactor: NewsInteractorInputProtocol
	weak var view: NewsViewInputProtocol?
	
	// MARK: - Init
	
	init(
		interactor: NewsInteractorInputProtocol,
		view: NewsViewInputProtocol
	) {
		self.interactor = interactor
		self.view = view
	}
}

// MARK: - NewsViewOutputProtocol
extension NewsPresenter: NewsViewOutputProtocol {
	func fetchNews() {
		
	}
	
	func loadImage(_ url: String, completion: @escaping (UIImage) -> Void) {
		
	}
}

// MARK: - NewsInteractorOutputProtocol
extension NewsPresenter: NewsInteractorOutputProtocol {
	func showNewsLoadingError(_ error: Error) {
		
	}
	
	func showNewsLikeError(_ error: Error) {
		
	}
}
