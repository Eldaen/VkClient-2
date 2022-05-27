//
//  NewsCollectionViewCell.swift
//  VkClient-2
//
//  Created by Денис Сизов on 25.05.2022.
//

import UIKit

/// Класс ячейки фотографии для новости
final class NewsCollectionViewCell: UICollectionViewCell {
	
	// MARK: - Subviews
	
	/// Основная вью с картинкой
	private let newsImage: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.clipsToBounds = true
		image.contentMode = .scaleAspectFit
		return image
	}()
	
	// MARK: - Methods
	
	/// Конфигурирует ячейку
	/// - Parameter image: Картинка, которая устанавливает в ячейку
	func configure(with image: UIImage) {
		contentView.addSubview(newsImage)
		newsImage.image = image
		setupConstraints()
	}
	
	override func prepareForReuse() {
		newsImage.image = nil
	}
}

// MARK: - Private methods
private extension NewsCollectionViewCell {
	private func setupConstraints() {
		NSLayoutConstraint.activate([
			newsImage.topAnchor.constraint(equalTo: contentView.topAnchor),
			newsImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			newsImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			newsImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
		])
	}
}
