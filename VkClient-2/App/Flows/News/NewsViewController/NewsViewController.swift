//
//  NewsViewController.swift
//  VkClient-2
//
//  Created by Денис Сизов on 25.05.2022.
//

import UIKit

// MARK: - NewsCells Enum
/// Типы ячеек, из которых состоит секция новости
enum NewsViewControllerCellTypes {
	case author
	case text
	case collection
	case footer
	case link
}

// MARK: - NewsViewController
final class NewsViewController: UIViewController {
	
	// MARK: - Properties
	
	/// Обработчик исходящих событий
	var output: NewsViewOutputProtocol?
	
	var news = [NewsTableViewCellModelProtocol]()
	
	/// Количество ячеек в секции новости
	private let cellsCount: Int = 4
	
	/// Количество ячеек в секции новости, если есть ссылка
	private let cellsWithLink: Int = 5
	
	/// UIView
	var newsView: NewsView {
		return self.view as! NewsView
	}
	
	// MARK: - Life Cycle
	
	override func loadView() {
		super.loadView()
		self.view = NewsView()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupTableView()
		//setupRefreshControl()
		configureNewsViewTableView()
		//newsView.spinner.startAnimating()
		output?.fetchNews()
	}
	
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		newsView.tableView.frame = newsView.bounds
	}
}

// MARK: - NewsViewInputProtocol
extension NewsViewController: NewsViewInputProtocol {
	func setLike(post: Int, owner: Int, completion: @escaping (Int) -> Void) {
		output?.setLike(post: post, owner: owner) { likesCount in
			completion(likesCount)
		}
	}
	
	func removeLike(post: Int, owner: Int, completion: @escaping (Int) -> Void) {
		output?.removeLike(post: post, owner: owner) { likesCount in
			completion(likesCount)
		}
	}
	
	func reloadTableView() {
		newsView.tableView.reloadData()
	}
	
	func startLoadAnimation() {
		newsView.spinner.startAnimating()
	}
	
	func stopLoadAnimation() {
		newsView.spinner.stopAnimating()
	}
	
	func showNewsLoadingErrorText(_ text: String) {
		
	}
	
	func showNewsLikeErrorText(_ text: String) {
		
	}
}

// MARK: - UITableViewDataSource
extension NewsViewController: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		news.count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if checkLink(for: section) {
			return cellsWithLink
		} else {
			return cellsCount
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var cell: UITableViewCell = UITableViewCell()
		guard let type = getCellType(for: indexPath) else { return UITableViewCell () }
		
		switch type {
		case .author:
			let authorCell: NewsAuthorCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
			cell = authorCell
		case .text:
			let textCell: NewsTextCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
			cell = textCell
			textCell.indexPath = indexPath
		case .collection:
			let collectionCell: NewsCollectionCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
			cell = collectionCell
		case .footer:
			let footerCell: NewsFooterCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
			footerCell.likesResponder = self
			cell = footerCell
		case .link:
			let linkCell: NewsLinkCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
			cell = linkCell
		}
		
		output?.configureCell(cell: cell, index: indexPath.section, type: type)
		return cell
	}
}

// MARK: - UITableViewDelegate
extension NewsViewController: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.newsView.tableView.deselectRow(at: indexPath, animated: true)
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if indexPath.item == 2 {
			if let height = news[indexPath.section].newsImageModels.first?.height,
			   let width = news[indexPath.section].newsImageModels.first?.width {
				let aspectRatio = Double(height) / Double(width)
				return tableView.bounds.width * CGFloat(aspectRatio)
			} else {
				return UITableView.automaticDimension
			}
		} else {
			return UITableView.automaticDimension
		}
	}
}

// MARK: - Private methods
private extension NewsViewController {
	
	/// Конфигурируем TableView
	func setupTableView() {
		let tableView = newsView.tableView
		
		tableView.register(registerClass: NewsAuthorCell.self)
		tableView.register(registerClass: NewsTextCell.self)
		tableView.register(registerClass: NewsCollectionCell.self)
		tableView.register(registerClass: NewsFooterCell.self)
		tableView.register(registerClass: NewsLinkCell.self)
		
		tableView.dataSource = self
		tableView.delegate = self
		//tableView.prefetchDataSource = self
	}
	
	/// Проверяет наличие ссылки в новости
	func checkLink(for section: Int) -> Bool {
		return (news[section].link) != nil
	}
	
	func getCellType(for item: IndexPath) -> NewsViewControllerCellTypes? {
		switch item.item {
		case 0:
			return .author
		case 1:
			return .text
		case 2:
			return .collection
		case 3:
			if checkLink(for: item.section) {
				return .link
			} else {
				return .footer
			}
		case 4:
			return .footer
		default:
			print("Some News Table view issue")
			return nil
		}
	}
	
	func configureNewsViewTableView() {
		newsView.tableView.reloadData()
		newsView.tableView.separatorStyle = .none
	}
}
