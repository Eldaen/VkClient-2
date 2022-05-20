//
//  MyGroupsViewController.swift
//  VkClient-2
//
//  Created by Денис Сизов on 05.05.2022.
//

import UIKit

// MARK: - VkLoginViewController
final class MyGroupsViewController: UIViewController {
	
	// MARK: - Properties
	
	/// Обработчик исходящих событий
	var output: MyGroupsViewOutputProtocol?
	
	/// UIView
	var myGroupsView: MyGroupsView {
		return self.view as! MyGroupsView
	}
	
	/// Массив групп пользователя
	var groups = [GroupModel]() {
		didSet {
			myGroupsView.tableView.reloadData()
		}
	}
	
	// MARK: - LifeCycle
	
	override func loadView() {
		super.loadView()
		self.view = MyGroupsView()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		startLoadAnimation()
		configureNavigation()
		configureSearchbar()
		setupTableView()
		output?.fetchGroups()
	}
}

// MARK: - UITableViewDataSource
extension MyGroupsViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		groups.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: MyGroupsCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
		let group = groups[indexPath.row]
		
		output?.loadImage(group.image) { image in
			cell.setImage(with: image)
		}
		cell.configure(with: group)
		return cell
	}
}

// MARK: - UITableViewDelegate
extension MyGroupsViewController: UITableViewDelegate {
	
}

extension MyGroupsViewController: UISearchBarDelegate {
	
}

// MARK: - MyGroupsViewInputProtocol
extension MyGroupsViewController: MyGroupsViewInputProtocol {
	func showGroupsLoadingError(_ error: Error) {
		//TODO: Сделать отображение ошибки
	}
}

// MARK: - Private methods
private extension MyGroupsViewController {
	
	// Конфигурируем Нав Бар
	func configureNavigation() {
		self.title = "Мои группы"
		
//		let add = UIBarButtonItem(
//			barButtonSystemItem: .add,
//			target: self,
//			action: #selector(addGroup)
//		)
		//add.tintColor = .black
		//navigationItem.rightBarButtonItem = add
	}
	
	// Конфигурируем ячейку
	func setupTableView() {
		myGroupsView.tableView.register(registerClass: MyGroupsCell.self)
		myGroupsView.tableView.dataSource = self
		myGroupsView.tableView.delegate = self
	}
	
	func startLoadAnimation() {
		myGroupsView.spinner.startAnimating()
	}
	
	func configureSearchbar() {
		myGroupsView.searchBar.delegate = self
	}
}
