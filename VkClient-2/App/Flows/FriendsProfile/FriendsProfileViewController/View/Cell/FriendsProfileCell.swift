//
//  FriendsProfileCell.swift
//  VkClient-2
//
//  Created by Денис Сизов on 23.05.2022.
//

import UIKit

/// Ячейка для коллекции профиля пользователя
final class FriendsProfileCell: UICollectionViewCell {
	
	// MARK: - Subviews
	
	/// Основная вью с картинкой
	private let photoView: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.contentMode = .scaleAspectFit
		return image
	}()
	
	// MARK: - Methods
	
	/// Конфигурирует ячейку
	/// - Parameter image: картинка для ячейки
	func configure(with image: UIImage) {
		contentView.addSubview(photoView)
		photoView.image = image
		setupConstraints()
	}
}

// MARK: - Private methods
private extension FriendsProfileCell {
	private func setupConstraints() {
		NSLayoutConstraint.activate([
			photoView.topAnchor.constraint(equalTo: contentView.topAnchor),
			photoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			photoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			photoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
		])
	}
}
