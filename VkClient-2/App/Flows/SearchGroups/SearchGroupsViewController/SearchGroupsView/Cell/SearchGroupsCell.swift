//
//  SearchGroupsCell.swift
//  VkClient-2
//
//  Created by Денис Сизов on 21.05.2022.
//

import UIKit

/// Ячейка группы для контроллера SearchGroupsController
final class SearchGroupsCell: UITableViewCell {
	
	//MARK: - Properties
	
	/// ID группы, которую ячейка отображает сейчас
	var id: Int?
	
	/// Является ли членом этой группы
	var isMember: Int?
	
	/// Название группы
	var name: String?
	
	/// Название группы
	private let groupName: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	/// Логотип группы
	private let groupImage: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.contentMode = .scaleAspectFit
		return image
	}()
	
	// MARK: - Methods
	
	/// Меняет картинку, используется для замены после подгрузки из сети
	func setImage(with image: UIImage) {
		groupImage.image = image
		self.groupImage.layoutIfNeeded()
	}
	
	/// Конфигурируем ячейку для отображения группы
	func configure(with group: GroupModel) {
		groupName.text = group.name
		groupImage.image = UIImage()
		self.id = group.id
		self.isMember = group.isMember
		self.name = group.name
		
		addSubviews()
		setupConstaints()
		animate()
	}
	
	/// Запуск анимацию ячейки
	func animate() {
		self.groupImage.alpha = 0
		self.groupName.alpha = 0
		
		UIView.animate(withDuration: 0.3,
					   delay: 0,
					   options: [],
					   animations: {
			self.groupImage.alpha = 1
			self.groupName.alpha = 1
		})
	}
	
}

// MARK: - Private methods
private extension SearchGroupsCell {
	func setupConstaints() {
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
	
	func addSubviews() {
		self.contentView.addSubview(groupName)
		self.contentView.addSubview(groupImage)
	}
}
