//
//  FriendsListInteractor.swift
//  VkClient-2
//
//  Created by Денис Сизов on 23.05.2022.
//

import Foundation

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
	
}
