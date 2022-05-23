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

	var groups = [GroupModel]()
	var filteredGroups = [GroupModel]()
	
	// MARK: - LifeCycle
	
	override func loadView() {
		super.loadView()
		self.view = MyGroupsView()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureNavigation()
		configureSearchbar()
		setupTableView()
		startLoadAnimation()
		output?.fetchGroups()
	}
	
	override func viewDidLayoutSubviews() {
		myGroupsView.spinner.center = myGroupsView.center
	}
}

// MARK: - UITableViewDataSource
extension MyGroupsViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		filteredGroups.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: MyGroupsCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
		let group = filteredGroups[indexPath.row]
		
		output?.loadImage(group.image) { image in
			cell.setImage(with: image)
		}
		cell.configure(with: group)
		return cell
	}
}

// MARK: - UITableViewDelegate
extension MyGroupsViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			guard let cell = tableView.cellForRow(at: indexPath) as? MyGroupsCell,
				  let id = cell.id else {
				return
			}
			output?.leaveGroup(id: id, index: indexPath)
		}
	}
	
	func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
		return "Покинуть"
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		myGroupsView.tableView.deselectRow(at: indexPath, animated: true)
	}
}

// MARK: - UISearchBarDelegate
extension MyGroupsViewController: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		searchBar.showsCancelButton = true
		output?.search(searchText)
	}
	
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		searchBar.showsCancelButton = false
		searchBar.text = nil
		searchBar.resignFirstResponder()
		
		output?.cancelSearch()
		reloadTableView()
	}
}

// MARK: - MyGroupsViewInputProtocol
extension MyGroupsViewController: MyGroupsViewInputProtocol {
	func reloadTableView() {
		myGroupsView.tableView.reloadData()
	}
	
	func reloadViewData() {
		startLoadAnimation()
		output?.fetchGroups()
	}
	
	func stopLoadAnimation() {
		myGroupsView.spinner.stopAnimating()
	}
	
	func startLoadAnimation() {
		myGroupsView.spinner.startAnimating()
	}
	
	func showGroupsLoadingErrorText(_ text: String) {
		let alert = UIAlertController(title: "Ошибка", message: text, preferredStyle: .alert)
		let action = UIAlertAction(title: "Повторить", style: .cancel) {[weak self] _ in
			self?.output?.fetchGroups()
		}
		alert.addAction(action)
		
		present(alert, animated: true, completion: nil)
	}
	
	func showGroupsLeavingErrorText(_ text: String) {
		let alert = UIAlertController(title: "Ошибка", message: text, preferredStyle: .alert)
		let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
		alert.addAction(action)
		
		present(alert, animated: true, completion: nil)
	}
	
	func deleteGroupFromView(at indexPath: IndexPath) {
		myGroupsView.tableView.deleteRows(at: [indexPath], with: .fade)
	}
}

// MARK: - Private methods
private extension MyGroupsViewController {
	
	// Конфигурируем Нав Бар
	func configureNavigation() {
		self.title = "Мои группы"
		
		let add = UIBarButtonItem(
			barButtonSystemItem: .add,
			target: self,
			action: #selector(addGroup)
		)
		add.tintColor = .black
		navigationItem.rightBarButtonItem = add
	}
	
	// Конфигурируем ячейку
	func setupTableView() {
		myGroupsView.tableView.register(registerClass: MyGroupsCell.self)
		myGroupsView.tableView.dataSource = self
		myGroupsView.tableView.delegate = self
	}
	
	func configureSearchbar() {
		myGroupsView.searchBar.delegate = self
	}
	
	/// Запускает переход на экран со всеми группами
	@objc func addGroup() {
		output?.navigateToSearchGroups()
	}
}
