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
	var isDemoModeOn: Bool?
}

// MARK: - VkLoginRouterInputProtocol
extension FriendsListRouter: FriendsListRouterInputProtocol {
	func openProfile(for friend: UserModel) {
		var nextController = FriendsProfileBuilder.build(userModel: friend)
		if isDemoModeOn != nil {
			nextController = DemoFriendsProfileBuilder.build()
		}
		viewController?.navigationController?.pushViewController(nextController, animated: true)
	}
}
