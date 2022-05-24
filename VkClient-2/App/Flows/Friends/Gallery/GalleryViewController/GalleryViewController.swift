//
//  GalleryViewController.swift
//  VkClient-2
//
//  Created by Денис Сизов on 24.05.2022.
//

import UIKit

// MARK: - GalleryViewController
final class GalleryViewController: UIViewController {
	
	// MARK: - Properties
	
	var storedImages = [String]()
	var photoViews = [UIImageView]()
}

// MARK: - GalleryViewInputProtocol
extension GalleryViewController: GalleryViewInputProtocol {
	
	func showImageLoadingErrorText(_ text: String) {
		
	}
}
