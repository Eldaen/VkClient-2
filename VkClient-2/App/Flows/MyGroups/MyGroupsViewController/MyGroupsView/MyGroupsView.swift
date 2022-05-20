//
//  MyGroupsView.swift
//  VkClient-2
//
//  Created by Денис Сизов on 05.05.2022.
//

import UIKit

/// Вью для MyGroupsViewController
final class MyGroupsView: UIView {
	
	// MARK: - Subviews
	
	/// Таблица с ячейками групп, в которых состоит пользователь
	public let tableView: UITableView = {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.backgroundColor = .white
		return tableView
	}()
	
	/// Вью поиска
	public let searchBar: UISearchBar = {
		let searchBar = UISearchBar()
		searchBar.frame = .zero
		searchBar.searchBarStyle = UISearchBar.Style.default
		searchBar.isTranslucent = false
		searchBar.sizeToFit()
		return searchBar
	}()
	
	/// Индикатор загрузки
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
}

// MARK: - Private methods
private extension MyGroupsView {
	
	/// Конфигурирует вью
	func configureUI() {
		addSubviews()
		setupTableView()
		setupSpinner()
		setupConstraints()
	}
	
	/// Конфигурирует таблицу
	func setupTableView() {
		tableView.rowHeight = 80
	}
	
	/// Конфигурирует спиннер загрузки
	func setupSpinner() {
		spinner.center = self.center
	}
	
	/// Добавляет сабвью на основную вью
	func addSubviews() {
		self.addSubview(tableView)
		self.addSubview(spinner)
		tableView.tableHeaderView = searchBar
	}
	
	/// Задаёт констрейнты таблице
	func setupConstraints() {
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: self.topAnchor),
			tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
			tableView.leftAnchor.constraint(equalTo: self.leftAnchor),
			tableView.rightAnchor.constraint(equalTo: self.rightAnchor)
		])
	}
}
