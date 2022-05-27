//
//  FriendsListView.swift
//  VkClient-2
//
//  Created by Денис Сизов on 23.05.2022.
//

import UIKit

/// Вью для FriendsListController
final class FriendsListView: UIView {
	
	// MARK: - Subviews
	
	/// Строка поиска
	public let searchBar: UISearchBar = {
		let searchBar = UISearchBar()
		searchBar.frame = .zero
		searchBar.searchBarStyle = UISearchBar.Style.default
		searchBar.isTranslucent = false
		searchBar.placeholder = "Искать"
		searchBar.sizeToFit()
		return searchBar
	}()
	
	/// Таблица для отображения друзей
	public let tableView: UITableView = {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.backgroundColor = .white
		return tableView
	}()
	
	/// Инликатор загрузки
	public let spinner: UIActivityIndicatorView = {
		let spinner = UIActivityIndicatorView(style: .medium)
		spinner.color = .black
		return spinner
	}()
	
	// MARK: - Init
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.configureUI()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.configureUI()
	}
	
	// MARK: - Methods
	
	/// Конфигурирует спиннер загрузки
	func setupSpinner() {
		spinner.center = self.center
	}
}

// MARK: - Private methods
private extension FriendsListView {
	func configureUI() {
		addSubviews()
		setupTableView()
		setupSpinner()
		setupConstraints()
	}
	
	func setupTableView() {
		tableView.rowHeight = 70
		tableView.showsVerticalScrollIndicator = false
		tableView.sectionHeaderTopPadding = 0
		tableView.sectionIndexColor = .black
	}
	
	func addSubviews() {
		self.addSubview(tableView)
		self.addSubview(spinner)
		tableView.tableHeaderView = searchBar
	}
	
	func setupConstraints() {
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: self.topAnchor),
			tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
			tableView.leftAnchor.constraint(equalTo: self.leftAnchor),
			tableView.rightAnchor.constraint(equalTo: self.rightAnchor)
		])
	}
}
