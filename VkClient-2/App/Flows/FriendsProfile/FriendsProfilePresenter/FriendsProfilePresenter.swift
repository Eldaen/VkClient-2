//
//  FriendsProfilePresenter.swift
//  VkClient-2
//
//  Created by Денис Сизов on 23.05.2022.
//

import UIKit.UIImage

// MARK: - FriendsProfilePresenter
final class FriendsProfilePresenter {
	
	// MARK: - Properties
}

// MARK: - FriendsProfileViewOutputProtocol
extension FriendsProfilePresenter: FriendsProfileViewOutputProtocol {
	func fetchImages() {
		
	}
	
	func loadImage(_ url: String, completion: @escaping (UIImage) -> Void) {
		
	}
}

// MARK: - FriendsProfileInteractorOutputProtocol
extension FriendsProfilePresenter: FriendsProfileInteractorOutputProtocol {
	
}

// MARK: - Private methods
private extension FriendsProfilePresenter {
	
}
