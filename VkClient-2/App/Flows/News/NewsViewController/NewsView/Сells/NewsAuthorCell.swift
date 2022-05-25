//
//  NewsAuthorCell.swift
//  VkClient-2
//
//  Created by Денис Сизов on 25.05.2022.
//

import UIKit

// MARK: - NewsAuthorCellProtocol
/// Протокол ячейки автора новости для NewsViewController
protocol NewsAuthorCellProtocol {
	
	/// Конфигурирует ячейку
	/// - Parameters:
	///   - model: Модель новости, которую нужно отобразить
	func configure (with model: NewsTableViewCellModelProtocol)
	
	/// Устанавливает картинку профиля, после того как она загрузится
	/// - Parameter image: Аватарка автора
	func updateProfileImage(with image: UIImage)
}

// MARK: - NewsAuthorCell
/// Ячейка для отображения новостей пользователя в контроллере NewsViewController
final class NewsAuthorCell: UITableViewCell, NewsAuthorCellProtocol {
	
	// MARK: - Subviews

	private let userImage: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		return image
	}()
	
	private let userName: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.seventeen
		label.textColor = .black
		return label
	}()
	
	private let postDate: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.fourteen
		label.textColor = .black
		return label
	}()
	
	// MARK: - Methods

	func configure (with model: NewsTableViewCellModelProtocol) {
		setupCell()
		setupConstraints()
		updateCellData(with: model)
		
		selectionStyle = .none
	}
	
	func updateProfileImage(with image: UIImage) {
		userImage.image = image
		userImage.layoutIfNeeded()
		userImage.layer.cornerRadius = userImage.frame.size.width / 2
		userImage.layer.masksToBounds = true
	}
}

// MARK: - Private methods
private extension NewsAuthorCell {
	
	func setupConstraints() {
		
		NSLayoutConstraint.activate([
			userImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
			userImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
			userImage.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),
			userImage.widthAnchor.constraint(equalToConstant: 60),
			
			userName.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 10),
			userName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
			userName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
			
			postDate.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 10),
			postDate.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 10),
		])
		
		let avatarHeight = userImage.heightAnchor.constraint(equalToConstant: 60)
		avatarHeight.priority = .init(rawValue: 999)
		avatarHeight.isActive = true
	}
	
	func setupCell() {
		contentView.addSubview(userImage)
		contentView.addSubview(userName)
		contentView.addSubview(postDate)
	}
	
	func updateCellData(with model: NewsTableViewCellModelProtocol) {
		userImage.image = UIImage(named: model.source.image)
		userName.text = model.source.name
		postDate.text = model.postDate
	}
}
