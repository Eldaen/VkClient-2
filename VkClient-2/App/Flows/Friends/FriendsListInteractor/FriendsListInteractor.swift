//
//  FriendsListInteractor.swift
//  VkClient-2
//
//  Created by Денис Сизов on 23.05.2022.
//

import UIKit.UIImage

// MARK: - FriendsListInteractor
final class FriendsListInteractor {
	
	// MARK: - Properties
	
	/// Cсылка на презентер
	weak var output: MyGroupsInteractorOutputProtocol?
	
	/// Cервис по работе с группами
	private var friendsLoader: UserLoader
	
	// MARK: - Init
	
	init(friendsService: UserLoader) {
		self.friendsLoader = friendsService
	}
}

// MARK: - FriendsListInteractorInputProtocol
extension FriendsListInteractor: FriendsListInteractorInputProtocol {
	func fetchFriends(_ completion: @escaping (Result<[FriendsSection], Error>) -> Void) {
		friendsLoader.loadFriends { result in
			switch result {
			case .success(let friends):
				completion(.success(friends))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
	
	func loadImage(_ url: String, completion: @escaping (UIImage) -> Void) {
		
	}
	
	func search(for query: String, in groups: [UserModel], completion: @escaping ([UserModel]) -> Void) {
		
	}
}
