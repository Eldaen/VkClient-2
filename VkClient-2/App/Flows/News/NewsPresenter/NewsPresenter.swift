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
	func removeLike(post: Int, owner: Int, completion: @escaping (Int) -> Void) {
		interactor.removeLike(post: post, owner: owner) { likesCount in
			completion(likesCount)
		}
	}
	
	func setLike(post: Int, owner: Int, completion: @escaping (Int) -> Void) {
		interactor.setLike(post: post, owner: owner) { likesCount in
			completion(likesCount)
		}
	}
	
	func configureCell(cell: UITableViewCell, index: Int, type: NewsViewControllerCellTypes) {
		guard let news = view?.news else { return }
		
		switch type {
		case .author:
			guard let authorCell = cell as? NewsAuthorCellProtocol else { return }
			authorCell.configure(with: news[index])
			
			loadPorfileImage(profile: news[index].source) { image in
				authorCell.updateProfileImage(with: image)
			}
		case .text:
			guard let textCell = cell as? NewsTextCellProtocol else { return }
			textCell.configure(with: news[index])
		case .collection:
			guard let collectionCell = cell as? NewCollectionCellProtocol else { return }
			collectionCell.configure(with: news[index])
			
			interactor.loadImages(array: news[index].newsImageModels) { images in
				collectionCell.updateCollection(with: images)
			}
		case .footer:
			guard let footerCell = cell as? NewsFooterCellProtocol else { return }
			footerCell.configure(with: news[index])
		case .link:
			guard let linkCell = cell as? NewsLinkCellProtocol else { return }
			linkCell.configure(with: news[index])
		}
	}
	
	func fetchNews() {
		interactor.fetchNews({ [weak self] result in
			switch result {
			case .success(let news):
				self?.view?.news = news.news
				self?.view?.reloadTableView()
			case .failure:
				self?.view?.showNewsLoadingErrorText("Не удалось загрузить новости")
			}
		})
	}
	
	func loadImage(_ url: String, completion: @escaping (UIImage) -> Void) {
		interactor.loadImage(url) { image in
			completion(image)
		}
	}
}

// MARK: - NewsInteractorOutputProtocol
extension NewsPresenter: NewsInteractorOutputProtocol {
	func showNewsLoadingError(_ error: Error) {
		
	}
	
	func showNewsLikeError(_ error: Error) {
		
	}
}

// MARK: - Private methods
private extension NewsPresenter {
	
	/// Загружает картинку профиля создателя новости
	func loadPorfileImage(profile: NewsSourceProtocol, completion: @escaping (UIImage) -> Void) {
		let url = profile.image
		
		interactor.loadImage(url) { image in
			completion(image)
		}
	}
}
