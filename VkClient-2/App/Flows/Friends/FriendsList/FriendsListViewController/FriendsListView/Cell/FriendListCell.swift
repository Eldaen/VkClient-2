//
//  FriendListCell.swift
//  VkClient-2
//
//  Created by Денис Сизов on 23.05.2022.
//

import UIKit

/// Ячейка друга для контроллера FriendsListViewController
final class FriendsListCell: UITableViewCell {
	
	// MARK: - Subviews
	
	/// Имя друга
	private let friendName: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.seventeen
		label.textColor = .black
		return label
	}()
	
	/// Вью для аватарки пользователя
	private let friendImage: AvatarView = {
		let avatar = AvatarView()
		avatar.translatesAutoresizingMaskIntoConstraints = false
		return avatar
	}()
	
	// MARK: - Methods
	
	/// Функция конфигурации ячейки перед использованием
	func configure(with user: UserModel) {
		friendName.text = user.name
		
		addSubviews()
		setupConstaints()
		animate()
	}
	
	/// Установить картинку на аватар пользователя
	/// - Parameter image: Картинка для автарки
	func setImage(with image: UIImage) {
		friendImage.image = image
	}
	
	/// Возвращает аватарку профиля
	func getImage() -> UIImage {
		return self.friendImage.image
	}
	
	/// Возвращает имя друга
	func getFriendName() -> String {
		return friendName.text ?? ""
	}
	
	/// Меняет картинку, используется для замены после подгрузки из сети
	func updateImage(with image: UIImage) {
		friendImage.image = image
		self.layoutIfNeeded()
	}
	
	/// Запуск анимации ячейки
	func animate() {
		self.friendImage.alpha = 0
		self.frame.origin.x += 50
		
		UIView.animate(withDuration: 0.3,
					   delay: 0.15,
					   options: [],
					   animations: {
			self.friendImage.alpha = 1
		})
		
		UIView.animate(withDuration: 0.2,
					   delay: 0.1,
					   usingSpringWithDamping: 0.4,
					   initialSpringVelocity: 0,
					   options: [],
					   animations: {
			self.frame.origin.x = 0
		})
	}
}

// MARK: - Private methods
private extension FriendsListCell {
	func setupConstaints() {
		NSLayoutConstraint.activate([
			friendName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
			friendName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			
			friendImage.leadingAnchor.constraint(equalTo: friendName.trailingAnchor, constant: 20),
			friendImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
			friendImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			friendImage.widthAnchor.constraint(equalToConstant: 60),
			friendImage.heightAnchor.constraint(equalTo: friendImage.widthAnchor, multiplier: 1.0),
		])
	}
	
	func addSubviews() {
		contentView.addSubview(friendName)
		contentView.addSubview(friendImage)
	}
}
