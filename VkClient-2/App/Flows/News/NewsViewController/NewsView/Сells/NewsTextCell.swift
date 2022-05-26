//
//  NewsTextCell.swift
//  VkClient-2
//
//  Created by Денис Сизов on 25.05.2022.
//

import UIKit

// MARK: - NewsTextCellProtocol
/// Протокол типа ячейки с текстом для NewsController
protocol NewsTextCellProtocol {
	
	/// Конфигурирует ячейку NewsTableViewCell
	/// - Parameters:
	///   - model: Модель новости, которую нужно отобразить
	func configure (with model: NewsTableViewCellModelProtocol)
}

// MARK: - NewsTextCell
/// Ячейка для отображения новостей пользователя в контроллере NewsController
final class NewsTextCell: UITableViewCell, NewsTextCellProtocol {
	
	// MARK: - Subviews
	
	private let postText: UILabel = {
		let text = UILabel()
		text.translatesAutoresizingMaskIntoConstraints = false
		text.lineBreakMode = .byWordWrapping
		text.numberOfLines = 0
		text.font = UIFont.fourteen
		text.textColor = .black
		return text
	}()
	
	private let button: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("показать полностью", for: .normal)
		button.setTitleColor(.blue, for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	// MARK: - Properties
	
	/// Полный текст поста
	private var fullText: String?
	
	/// Укороченная версия текста поста
	private var shortText: String?
	
	/// Флаг состояния текста, укорочен или нет
	private var isTextShort: Bool = false
	
	/// Делегат для обновления высоты ячейки текста
	var delegate: ShowMoreNewsTextDelegate?
	
	/// IndexPath ячейки в таблице
	var indexPath: IndexPath = IndexPath()
	
	// MARK: - Methods
	
	func configure (with model: NewsTableViewCellModelProtocol) {
		setupCell()
		setupConstraints()
		updateCellData(with: model)
		
		selectionStyle = .none
	}
	
	override func prepareForReuse() {
		shortText = nil
		fullText = nil
		isTextShort = false
		button.removeFromSuperview()
	}
}

// MARK: - Private methods
private extension NewsTextCell {
	
	func setupConstraints() {
		let bottomAnchor = postText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
		bottomAnchor.priority = .init(rawValue: 999)
		
		NSLayoutConstraint.activate([
			postText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
			postText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
			postText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
			bottomAnchor,
		])
	}
	
	func setupCell() {
		contentView.addSubview(postText)
	}
	
	/// обновляет данные ячейки
	func updateCellData(with model: NewsTableViewCellModelProtocol) {
		fullText = model.postText
		
		if let shortText = model.shortText {
			self.shortText = shortText
			
			showShortText()
			addShowMore()
			return
		}
		showFullText()
	}
	
	/// Добавляет кнопку ReadMore после текстового поля
	func addShowMore() {
		contentView.addSubview(button)
		button.addTarget(self, action: #selector(toggleText), for: .touchUpInside)
		
		NSLayoutConstraint.activate([
			button.topAnchor.constraint(equalTo: postText.bottomAnchor, constant: 10),
			button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
			button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
			button.heightAnchor.constraint(equalToConstant: 14),
		])
	}
	
	/// Переключает режим отображения текста поста
	@objc func toggleText() {
		if isTextShort == true {
			showFullText()
			button.setTitle("показать меньше", for: .normal)
		} else {
			showShortText()
			button.setTitle("показать полностью", for: .normal)
		}
		delegate?.updateTextHeight(indexPath: indexPath)
	}
	
	/// Отображает весь текст поста
	func showFullText() {
		postText.text = fullText
		isTextShort = false
	}
	
	/// Отображает укороченный текст поста
	func showShortText() {
		postText.text = shortText
		isTextShort = true
	}
}
