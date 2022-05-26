//
//  NewsView.swift
//  VkClient-2
//
//  Created by Денис Сизов on 25.05.2022.
//

import UIKit

/// Вью для News Controller
final class NewsView: UIView {
	
	// MARK: Subviews
	
	public let tableView: UITableView = {
		let tableView = UITableView()
		tableView.backgroundColor = .white
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.showsVerticalScrollIndicator = false
		return tableView
	}()
	
	public let spinner: UIActivityIndicatorView = {
		let spinner = UIActivityIndicatorView(style: .medium)
		spinner.color = .black
		return spinner
	}()
	
	// MARK: - Properties
	
	/// Обработчик pull to refresh
	var refreshResponder: NewsRefreshDelegateProtocol?
	
	// MARK: - Init
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.configureUI()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.configureUI()
	}
	
}

// MARK: - Private methods
private extension NewsView {
	
	/// Конфигурирует вью
	private func configureUI() {
		addSubviews()
	}
	
	/// Добавляет сабвью
	private func addSubviews() {
		self.addSubview(tableView)
		self.addSubview(spinner)
	}
	
	/// Запрашивает обновление новостей, инициируется RefreshControl-ом
	@objc func refreshNews() {
		refreshResponder?.refreshNews()
	}
}
