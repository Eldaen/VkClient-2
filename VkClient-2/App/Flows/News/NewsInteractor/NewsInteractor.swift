//
//  NewsInteractor.swift
//  VkClient-2
//
//  Created by Денис Сизов on 25.05.2022.
//

import UIKit.UIImage

// MARK: - NewsInteractor
final class NewsInteractor {
	
	// MARK: - Properties
}

extension NewsInteractor: NewsInteractorInputProtocol {
	func fetchNews(_ completion: @escaping (Result<[GroupModel], Error>) -> Void) {
		
	}
	
	func loadImage(_ url: String, completion: @escaping (UIImage) -> Void) {
		
	}
}
