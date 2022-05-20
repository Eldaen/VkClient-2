//
//  MyGroupsCell.swift
//  VkClient-2
//
//  Created by Денис Сизов on 05.05.2022.
//

import UIKit

/// Ячейка группы для контроллера MyGroupsViewController
final class MyGroupsCell: UITableViewCell {
	
	// MARK: - Properties
	
	/// ID группы, которую сейчас отображает ячейка
	var id: Int?
	
	/// Название группы
	let groupName: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	/// Логотип группы
	let groupImage: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.contentMode = .scaleAspectFit
		return image
	}()
	
	// MARK: - Methods
	
	/// Меняет картинку, используется для замены после подгрузки из сети
	func setImage(with image: UIImage) {
		groupImage.image = image
		self.layoutIfNeeded()
	}
	
	/// Конфигурируем ячейку для отображения группы
	func configure(with group: GroupModel) {
		groupName.text = group.name
		self.id = group.id
		
		addSubviews()
		setupConstaints()
		animate()
	}
	
	/// Запуск анимацию ячейки
	func animate() {
		self.groupImage.alpha = 0
		self.groupName.alpha = 0
		
		UIView.animate(
			withDuration: 0.3,
			delay: 0,
			options: [],
			animations: {
				self.groupImage.alpha = 1
				self.groupName.alpha = 1
			}
		)
	}
}

// MARK: - Private methods
private extension MyGroupsCell {
	private func setupConstaints() {
		NSLayoutConstraint.activate([
			groupName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
			groupName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			
			groupImage.leadingAnchor.constraint(equalTo: groupName.trailingAnchor, constant: 20),
			groupImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
			groupImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			groupImage.widthAnchor.constraint(equalToConstant: 58),
			groupImage.heightAnchor.constraint(equalTo: groupImage.widthAnchor, multiplier: 1.0),
		])
	}
	
	private func addSubviews() {
		contentView.addSubview(groupName)
		contentView.addSubview(groupImage)
	}
}
