//
//  FriendsListPresenter.swift
//  VkClient-2
//
//  Created by Денис Сизов on 23.05.2022.
//

import UIKit.UIImage

// MARK: - FriendsListPresenter
final class FriendsListPresenter {
	
}

// MARK: - FriendsListViewOutputProtocol
extension FriendsListPresenter: FriendsListViewOutputProtocol {
	
	func fetchFriends() {
		
	}
	
	func loadImage(_ url: String, completion: @escaping (UIImage) -> Void) {
		
	}
	
	func search(_ query: String) {
		
	}
	
	func cancelSearch() {
		
	}
}

// MARK: - FriendsListnteractorOutputProtocol
extension FriendsListPresenter: FriendsListnteractorOutputProtocol {
	
}
