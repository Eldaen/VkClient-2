//
//  NewsFooterCell.swift
//  VkClient-2
//
//  Created by Денис Сизов on 25.05.2022.
//

import UIKit

// MARK: - NewsFooterCellProtocol
/// Протокол ячейки футера новости для NewsController
protocol NewsFooterCellProtocol {
	
	/// Конфигурирует ячейку данными для отображения
	func configure (with model: NewsTableViewCellModelProtocol)
	
	/// Обработчик лайков
	var likesResponder: NewsViewInputProtocol? { get set }
}

// MARK: - NewsFooterCell
/// Ячейка для отображения новостей пользователя в контроллере NewsController
final class NewsFooterCell: UITableViewCell, NewsFooterCellProtocol {
	
	// MARK: - Subviews

	private let footerView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	private let footerHorizontalStack: UIStackView = {
		let stack = UIStackView()
		stack.axis = .horizontal
		stack.distribution = .fillEqually
		stack.contentMode = .center
		stack.spacing = 20
		stack.translatesAutoresizingMaskIntoConstraints = false
		return stack
	}()
	
	private let likesControl: LikeControl = {
		let likeControl = LikeControl(frame: .zero)
		likeControl.tintColor = .red
		return likeControl
	}()
	
	private let commentsControl: CommentsControl = {
		let comments = CommentsControl(frame: .zero)
		return comments
	}()
	
	private let repostsControl: RepostsControl = {
		let reposts = RepostsControl(frame: .zero)
		return reposts
	}()
	
	private let viewsLabel: UILabel = {
		let views = UILabel(frame: .zero)
		views.font = UIFont.fourteen
		views.translatesAutoresizingMaskIntoConstraints = false
		return views
	}()
	
	private let graySpacer: UIView = {
		let view = UIView()
		view.backgroundColor = .gray
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	// MARK: - Properties
	
	/// Обработчик лайков
	var likesResponder: NewsViewInputProtocol?
	
	private var postId: Int = 0
	private var sourceId: Int = 0
	
	/// Высота разделителя
	let spacerHeight: CGFloat = 5
	
	// MARK: - Methods
	
	/// Конфигурирует ячейку NewsTableViewCell
	/// - Parameters:
	///   - model: Модель новости, которую нужно отобразить
	func configure (with model: NewsTableViewCellModelProtocol) {
		likesControl.setLikesResponder(responder: self)
		likesControl.hasMyLike = model.likesModel?.userLikes == 1 ? true : false
		
		setupCell()
		setupFooter()
		setupConstraints()
		
		postId = model.postID
		sourceId = model.source.id
		updateCellData(with: model)
		
		selectionStyle = .none
	}
}

// MARK: - Private methods
private extension NewsFooterCell {
	
	func setupConstraints() {
		
		NSLayoutConstraint.activate([
			footerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
			footerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
			footerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			footerView.heightAnchor.constraint(equalToConstant: 30),
			
			footerHorizontalStack.leadingAnchor.constraint(equalTo: footerView.leadingAnchor),
			footerHorizontalStack.trailingAnchor.constraint(lessThanOrEqualTo: viewsLabel.leadingAnchor, constant: -10),
			footerHorizontalStack.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
			
			viewsLabel.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -10),
			viewsLabel.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
			
			graySpacer.topAnchor.constraint(equalTo: footerView.bottomAnchor),
			graySpacer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			graySpacer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			graySpacer.heightAnchor.constraint(equalToConstant: spacerHeight),
		])
		
		let footerTop = footerView.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 20)
		footerTop.priority = .init(rawValue: 999)
		footerTop.isActive = true
	}
	
	func setupCell() {
		contentView.addSubview(footerView)
		contentView.addSubview(graySpacer)
	}
	
	/// Конфигурируем футер
	func setupFooter() {
		footerHorizontalStack.addArrangedSubview(likesControl)
		footerHorizontalStack.addArrangedSubview(commentsControl)
		footerHorizontalStack.addArrangedSubview(repostsControl)
		footerView.addSubview(viewsLabel)
		footerView.addSubview(footerHorizontalStack)
	}
	
	/// обновляет данные ячейки
	func updateCellData(with model: NewsTableViewCellModelProtocol) {
		likesControl.setCount(with: model.likesModel?.count ?? 0)
		commentsControl.setCount(with: model.comments?.count ?? 0)
		commentsControl.setImage(with: "bubble.left")
		repostsControl.setCount(with: model.reposts?.count ?? 0)
		repostsControl.setImage(with: "arrowshape.turn.up.right")
		viewsLabel.text = "🔍 \(model.views?.count ?? 0)"
	}
}

// MARK: - CanLike protocol extension
extension NewsFooterCell: CanLikeProtocol {
	
	///  Отправляет запрос на лайк поста
	func setLike() {
		likesResponder?.setLike(post: postId, owner: sourceId) { [weak self] result in
			self?.likesControl.setCount(with: result)
		}
	}
	
	/// Отправляет запрос на отмену лайка
	func removeLike() {
		likesResponder?.removeLike(post: postId, owner: sourceId) { [weak self] result in
			self?.likesControl.setCount(with: result)
		}
	}
}
