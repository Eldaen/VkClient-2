//
//  FriendsListRouter.swift
//  VkClient-2
//
//  Created by Денис Сизов on 23.05.2022.
//
import UIKit

// MARK: - FriendsListRouter
final class FriendsListRouter {
	
	// MARK: - Properties
	
	weak var viewController: UIViewController?
}

// MARK: - VkLoginRouterInputProtocol
extension FriendsListRouter: FriendsListRouterInputProtocol {
	func openProfile(for friend: UserModel) {
		viewController?.navigationController?.pushViewController(
			FriendsProfileBuilder.build(userModel: friend)
			, animated: true
		)
	}
}
