//
//  FriendsProfileView.swift
//  VkClient-2
//
//  Created by Денис Сизов on 23.05.2022.
//

import UIKit

/// Вью для FriendsProfileViewController
final class FriendsProfileView: UIView {
	
	// MARK: - Subviews
	
	public let userAvatar: UIImageView = {
		let avatar = UIImageView()
		avatar.translatesAutoresizingMaskIntoConstraints = false
		return avatar
	}()
	
	public let friendName: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.seventeen
		label.textColor = .black
		return label
	}()
	
	public let friendsCount: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.fithteen
		label.textColor = .black
		label.text = "300"
		return label
	}()
	
	public let friendsText: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.fithteen
		label.textColor = .black
		label.text = "Друзья"
		return label
	}()
	
	public let photosText: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.fithteen
		label.textColor = .black
		label.text = "Фото"
		return label
	}()
	
	public let photosCount: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.fithteen
		label.textColor = .black
		return label
	}()
	
	public let leftStack: UIStackView = {
		let stack = UIStackView()
		stack.axis = .vertical
		stack.distribution = .fillEqually
		stack.alignment = .center
		stack.spacing = 4
		stack.contentMode = .scaleToFill
		stack.translatesAutoresizingMaskIntoConstraints = false
		return stack
	}()
	
	public let rightStack: UIStackView = {
		let stack = UIStackView()
		stack.axis = .vertical
		stack.distribution = .fillEqually
		stack.alignment = .center
		stack.spacing = 4
		stack.contentMode = .scaleToFill
		stack.translatesAutoresizingMaskIntoConstraints = false
		return stack
	}()
	
	public let horizontalStack: UIStackView = {
		let stack = UIStackView()
		stack.axis = .horizontal
		stack.distribution = .fillEqually
		stack.alignment = .fill
		stack.spacing = 50
		stack.contentMode = .scaleToFill
		stack.translatesAutoresizingMaskIntoConstraints = false
		return stack
	}()
	
	public let collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
		let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collection.translatesAutoresizingMaskIntoConstraints = false
		
		return collection
	}()
	
	public let spinner: UIActivityIndicatorView = {
		let spinner = UIActivityIndicatorView(style: .medium)
		spinner.color = .black
		return spinner
	}()
	
	// MARK: - Init
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.configureUI()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.configureUI()
	}
	
	// MARK: - Methods
	
	/// Конфигурирует спиннер загрузки
	func setupSpinner() {
		
		/// Смещение вниз индикатора загрузки от центра
		let spinnerYoffset = 1.3
		
		self.addSubview(spinner)
		spinner.center.x = self.center.x
		spinner.center.y = self.center.y * spinnerYoffset
	}
}

// MARK: - Private methods
private extension FriendsProfileView {
	
	/// Конфигурирует вью
	func configureUI() {
		addSubviews()
		setupCollectionView()
		setupConstraints()
	}
	
	/// Конфигурирует таблицу
	func setupCollectionView() {
		collectionView.backgroundColor = .white
		self.addSubview(collectionView)
	}
	
	/// Добавляет сабвью на основную вью
	func addSubviews() {
		self.backgroundColor = .white
		self.addSubview(userAvatar)
		self.addSubview(friendName)
		
		leftStack.addArrangedSubview(friendsCount)
		leftStack.addArrangedSubview(friendsText)
		
		rightStack.addArrangedSubview(photosCount)
		rightStack.addArrangedSubview(photosText)
		
		horizontalStack.addArrangedSubview(leftStack)
		horizontalStack.addArrangedSubview(rightStack)
		
		self.addSubview(horizontalStack)
		self.addSubview(collectionView)
	}
	
	/// Задаёт констрейнты
	func setupConstraints() {
		NSLayoutConstraint.activate([
			userAvatar.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 15),
			userAvatar.widthAnchor.constraint(equalToConstant: 100),
			userAvatar.heightAnchor.constraint(equalTo: userAvatar.widthAnchor, multiplier: 1.0),
			userAvatar.centerXAnchor.constraint(equalTo: self.centerXAnchor),

			friendName.topAnchor.constraint(equalTo: userAvatar.bottomAnchor, constant: 20),
			friendName.centerXAnchor.constraint(equalTo: userAvatar.centerXAnchor),
			
			leftStack.heightAnchor.constraint(equalToConstant: 50),
			rightStack.heightAnchor.constraint(equalToConstant: 50),

			horizontalStack.topAnchor.constraint(equalTo: friendName.bottomAnchor, constant: 20),
			horizontalStack.heightAnchor.constraint(equalToConstant: 50),
			horizontalStack.widthAnchor.constraint(equalToConstant: 160),
			horizontalStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),

			collectionView.topAnchor.constraint(equalTo: horizontalStack.bottomAnchor, constant: 16),
			collectionView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor, constant: -16),
			collectionView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
		])
	}
}
