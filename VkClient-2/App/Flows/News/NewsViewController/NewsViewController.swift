//
//  NewsViewController.swift
//  VkClient-2
//
//  Created by Денис Сизов on 25.05.2022.
//

import UIKit

// MARK: - NewsViewController
final class NewsViewController: UIViewController {
	
	// MARK: - Properties
}

// MARK: - NewsViewInputProtocol
extension NewsViewController: NewsViewInputProtocol {
	func reloadTableView() {
		
	}
	
	func startLoadAnimation() {
		
	}
	
	func stopLoadAnimation() {
		
	}
	
	func showNewsLoadingErrorText(_ text: String) {
		
	}
	
	func showNewsLikeErrorText(_ text: String) {
		
	}
}

// MARK: - UITableViewDataSource
extension NewsViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
	}
}

// MARK: - Private methods
private extension NewsViewController {
	
}
