//
//  NewsLinkCell.swift
//  VkClient-2
//
//  Created by Денис Сизов on 25.05.2022.
//

import UIKit

// MARK: - NewsLinkCellProtocol
/// Протокол ячейки со ссылкой для NewsController
protocol NewsLinkCellProtocol {
	
	/// Конфигурирует ячейку
	/// - Parameters:
	///   - model: Модель новости, которую нужно отобразить
	func configure (with model: NewsTableViewCellModelProtocol)
}

// MARK: - NewsLinkCell
/// Ячейка для отображения ссылки в новости в NewsController
final class NewsLinkCell: UITableViewCell, NewsLinkCellProtocol {
	
	// MARK: - Subviews
	
	private let linkTitle: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.fourteen
		label.textColor = .black
		return label
	}()
	
	private let linkCaption: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.twelve
		label.textColor = .gray
		return label
	}()
	
	private let linkHorizontalStack: UIStackView = {
		let stack = UIStackView()
		stack.axis = .vertical
		stack.distribution = .fillEqually
		stack.contentMode = .left
		stack.translatesAutoresizingMaskIntoConstraints = false
		return stack
	}()
	
	private let linkImage: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.image = UIImage(systemName: "link")
		image.tintColor = .black
		return image
	}()
	
	// MARK: - Properties
	
	lazy var tapGestureRecognizer: UITapGestureRecognizer = {
		let recognizer = UITapGestureRecognizer(target: self,
												action: #selector(onClick))
		recognizer.numberOfTapsRequired = 1
		recognizer.numberOfTouchesRequired = 1
		return recognizer
	}()
	
	/// URL ссылки новости
	private var url: URL?
	
	// MARK: - Methods
	
	func configure (with model: NewsTableViewCellModelProtocol) {
		setupCell(with: model)
		setupConstraints()
		updateCellData(with: model)
		addGestureRecognizer(tapGestureRecognizer)
		selectionStyle = .none
	}
}

// MARK: - Private methods
private extension NewsLinkCell {
	func setupConstraints() {
		NSLayoutConstraint.activate([
			linkImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			linkImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
			linkImage.heightAnchor.constraint(equalToConstant: 20),
			linkImage.widthAnchor.constraint(equalTo: linkImage.heightAnchor, multiplier: 1.0),
			
			linkHorizontalStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			linkHorizontalStack.leadingAnchor.constraint(equalTo: linkImage.trailingAnchor, constant: 8),
			linkHorizontalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
		])
	}
	
	func setupCell(with model: NewsTableViewCellModelProtocol) {
		contentView.addSubview(linkImage)
		
		if (model.link?.title) != nil {
			linkHorizontalStack.addArrangedSubview(linkTitle)
		}
		linkHorizontalStack.addArrangedSubview(linkCaption)
		contentView.addSubview(linkHorizontalStack)
	}
	
	/// Обновляет данные ячейки
	func updateCellData(with model: NewsTableViewCellModelProtocol) {
		linkTitle.text = model.link?.title
		
		if let caption = model.link?.caption {
			linkCaption.text = caption
		} else {
			linkCaption.text = model.link?.url
		}
		
		url = URL(string: model.link?.url ?? "")
	}
	
	@objc func onClick() {
		if let url = url {
			UIApplication.shared.open(url)
		}
	}
}
