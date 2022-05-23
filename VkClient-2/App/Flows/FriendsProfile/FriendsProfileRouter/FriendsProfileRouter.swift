//
//  FriendsProfileRouter.swift
//  VkClient-2
//
//  Created by Денис Сизов on 23.05.2022.
//

import UIKit

// MARK: - FriendsProfileRouter
final class FriendsProfileRouter {
	
	// MARK: - Properties
	
	weak var viewController: UIViewController?
}

// MARK: - FriendsProfileRouterInputProtocol
extension FriendsProfileRouter: FriendsProfileRouterInputProtocol {
	func openImage(for friend: UserModel) {
		
	}
}
