//
//  FriendsListViewController.swift
//  VkClient-2
//
//  Created by Денис Сизов on 23.05.2022.
//

import UIKit

//MARK: - FriendsListViewController
final class FriendsListViewController: UIViewController {
	
	// MARK: - Properties
	
	/// Обработчик исходящих событый
	var output: FriendsListViewOutputProtocol?
	
	/// UIView
	var friendsListView: FriendsListView {
		return self.view as! FriendsListView
	}
	
	var friends = [UserModel]()
	var filteredFriends = [UserModel]()
	
	// MARK: - Life Cycle
	
	override func loadView() {
		super.loadView()
		self.view = FriendsListView()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureNavigation()
		configureSearchbar()
		setupTableView()
		startLoadAnimation()
		output?.fetchFriends()
	}
	
	override func viewDidLayoutSubviews() {
		friendsListView.spinner.center = friendsListView.center
	}
}

// MARK: - UITableViewDataSource
extension FriendsListViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		filteredFriends.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: FriendsListCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
		let friend = filteredFriends[indexPath.row]
		
		output?.loadImage(friend.image) { image in
			cell.setImage(with: image)
		}
		cell.configure(with: friend)
		return cell
	}
}

// MARK: - UITableViewDelegate
extension FriendsListViewController: UITableViewDelegate {
	
}

// MARK: - UISearchBarDelegate
extension FriendsListViewController: UISearchBarDelegate {
	
}

// MARK: - FriendsListViewInputProtocol
extension FriendsListViewController: FriendsListViewInputProtocol {
	func startLoadAnimation() {
		friendsListView.spinner.startAnimating()
	}
	
	func stopLoadAnimation() {
		friendsListView.spinner.stopAnimating()
	}
}

// MARK: - Private methods
private extension FriendsListViewController {
	
	// Конфигурируем Нав Бар
	func configureNavigation() {
		self.title = "Мои Друзья"
	}
	
	// Конфигурируем ячейку
	func setupTableView() {
		friendsListView.tableView.register(registerClass: FriendsListCell.self)
		friendsListView.tableView.dataSource = self
		friendsListView.tableView.delegate = self
	}
	
	func configureSearchbar() {
		friendsListView.searchBar.delegate = self
	}
}
