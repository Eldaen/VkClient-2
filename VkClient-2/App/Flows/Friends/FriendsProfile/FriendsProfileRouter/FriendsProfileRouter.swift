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
	var isDemoModeOn: Bool?
}

// MARK: - FriendsProfileRouterInputProtocol
extension FriendsProfileRouter: FriendsProfileRouterInputProtocol {
	func openGalleryFor(photo: Int, in images: [ApiImage]) {
		var nextController = GalleryBuilder.build(photoId: photo, imageModels: images)
		if isDemoModeOn != nil {
			nextController = DemoGalleryBuilder.build(photoId: photo, imageModels: images)
		}
		viewController?.navigationController?.pushViewController(nextController, animated: true)
	}
}
