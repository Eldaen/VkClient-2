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
	
	var friends = [FriendsSection]()
	var filteredFriends = [FriendsSection]()
	
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
		guard let friend = output?.getFriendFromSection(at: indexPath) else {
			return UITableViewCell()
		}
		
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
	func showFriendsLoadingErrorText(_ text: String) {
		let alert = UIAlertController(title: "Ошибка", message: text, preferredStyle: .alert)
		let action = UIAlertAction(title: "Повторить", style: .cancel) {[weak self] _ in
			self?.output?.fetchFriends()
		}
		alert.addAction(action)
		
		present(alert, animated: true, completion: nil)
	}
	
	func reloadTableView() {
		friendsListView.tableView.reloadData()
	}
	
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
