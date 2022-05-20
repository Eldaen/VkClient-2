//
//  SearchGroupsViewController.swift
//  VkClient-2
//
//  Created by Денис Сизов on 20.05.2022.
//

import UIKit

// MARK: - SearchGroupsViewController
final class SearchGroupsViewController: UIViewController {
	
	// MARK: - Properties
	
	/// Обработчик исходящих событий
	var output: SearchGroupsViewOutputProtocol?
	
	var groups = [GroupModel]()
	var filteredGroups = [GroupModel]()
	
	/// UIView
	var searchGroupsView: SearchGroupsView {
		return self.view as! SearchGroupsView
	}
	
}

// MARK: - SearchGroupsViewInputProtocol
extension SearchGroupsViewController: SearchGroupsViewInputProtocol {
	
	func reloadTableView() {
		searchGroupsView.tableView.reloadData()
	}
	
	func showGroupsLoadingErrorText(_ text: String) {
		let alert = UIAlertController(title: "Ошибка", message: text, preferredStyle: .alert)
		let action = UIAlertAction(title: "Повторить", style: .cancel) {[weak self] _ in
			self?.output?.fetchGroups()
		}
		alert.addAction(action)
		
		present(alert, animated: true, completion: nil)
	}
	
	func showGroupJoiningErrorText(_ text: String) {
		let alert = UIAlertController(title: "Ошибка", message: text, preferredStyle: .alert)
		let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
		alert.addAction(action)
		
		present(alert, animated: true, completion: nil)
	}
}

// MARK: - UITableViewDataSource
extension SearchGroupsViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		filteredGroups.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: SearchGroupsCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
		let group = filteredGroups[indexPath.row]
		
		output?.loadImage(group.image, completion: { image in
			cell.setImage(with: image)
		})
		
		cell.configure(with: group)
		return cell
	}
}

// MARK: - UITableViewDelegate
extension SearchGroupsViewController: UITableViewDelegate {
	
}

// MARK: - Private methods
private extension SearchGroupsViewController {
	
	/// Конфигурирует ячейку
	func setupTableView() {
		searchGroupsView.tableView.register(registerClass: SearchGroupsCell.self)
		searchGroupsView.tableView.dataSource = self
		searchGroupsView.tableView.delegate = self
	}
}
