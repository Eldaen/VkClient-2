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
	
	/// Cсылка на презентер
	weak var output: NewsInteractorOutputProtocol?
	
	/// Cервис по работе с группами
	private var newsLoader: NewsLoader
	
	// MARK: - Init
	
	init(newsService: NewsLoader) {
		self.newsLoader = newsService
	}
}

extension NewsInteractor: NewsInteractorInputProtocol {
	func fetchNews(_ completion: @escaping (Result<NewsFetchingResponse, Error>) -> Void) {
		newsLoader.loadNews(startTime: nil, startFrom: nil) { result in
			switch result {
			case .success(let response):
				completion(.success(response))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
	
	func loadImages(array: [ImageSizes], completion: @escaping ([UIImage]) -> Void) {
		var images = [UIImage]()
		let imageGroup = DispatchGroup()
		
		// Создаём группу по загрузке всех картинок новости
		DispatchQueue.global().async(group: imageGroup) { [weak self] in
			for imageName in array {
				imageGroup.enter()
				self?.newsLoader.loadImage(url: imageName.url) { image in
					images.append(image)
					imageGroup.leave()
				}
			}
		}
		
		imageGroup.notify(queue: DispatchQueue.main) {
			completion(images)
		}
	}
	
	func loadImage(_ url: String, completion: @escaping (UIImage) -> Void) {
		newsLoader.loadImage(url: url) { image in
			completion(image)
		}
	}
}
