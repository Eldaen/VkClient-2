//
//  GalleryView.swift
//  VkClient-2
//
//  Created by Денис Сизов on 24.05.2022.
//

import UIKit

/// Вью для контроллера отображения галереи фотографий пользователя
final class GalleryView: UIView {
	
	// MARK: - Subviews
	
	public let mainView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	public let progressView: UIProgressView = {
		let progressView = UIProgressView()
		progressView.translatesAutoresizingMaskIntoConstraints = false
		progressView.tintColor = .black
		return progressView
	}()
	
	// MARK: - Properties
	
	// Создаём три переменные, которые будут отвечать за то, что мы видим на экране и с чем взаимодействуем
	public var leftImageView: UIImageView!
	public var middleImageView: UIImageView!
	public var rightImageView: UIImageView!
	
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
	
	func setImages() {
		addImageSubviews()
		configureImageSubviews()
		setupImageSubviewsConstraints()
	}
}

// MARK: - Private methods
private extension GalleryView {
	
	/// Конфигурирует вью
	func configureUI() {
		self.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
		setupViews()
		addSubviews()
		setupConstraints()
	}
	
	func addSubviews() {
		self.addSubview(mainView)
		self.addSubview(progressView)
	}
	
	func setupConstraints() {
		NSLayoutConstraint.activate([
			mainView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
			mainView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
			mainView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
			mainView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor, constant: 40),
			
			progressView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
			progressView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
			progressView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
		])
	}
	
	func setupViews() {
		leftImageView = UIImageView()
		middleImageView = UIImageView()
		rightImageView = UIImageView()
	}
	
	func addImageSubviews() {
		mainView.addSubview(leftImageView)
		mainView.addSubview(middleImageView)
		mainView.addSubview(rightImageView)
	}
	
	func configureImageSubviews() {
		leftImageView.translatesAutoresizingMaskIntoConstraints = false
		middleImageView.translatesAutoresizingMaskIntoConstraints = false
		rightImageView.translatesAutoresizingMaskIntoConstraints = false
		
		leftImageView.layer.cornerRadius = 8
		middleImageView.layer.cornerRadius = 8
		rightImageView.layer.cornerRadius = 8
		
		leftImageView.clipsToBounds = true
		middleImageView.clipsToBounds = true
		rightImageView.clipsToBounds = true
		
		// изначально уменьшаем картинки, чтобы их потом можно было увеличить, СGAffineTransform имеет св-во .identity и можно вернуть к оригиналу
		let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
		
		self.middleImageView.transform = scale
		self.rightImageView.transform = scale
		self.leftImageView.transform = scale
	}
	
	func setupImageSubviewsConstraints() {
		NSLayoutConstraint.activate([
			middleImageView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 30),
			middleImageView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -30),
			middleImageView.heightAnchor.constraint(equalTo: middleImageView.widthAnchor, multiplier: 1),
			middleImageView.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
			
			// выступает на 10 из-за левого края экрана
			leftImageView.trailingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10),
			leftImageView.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
			leftImageView.heightAnchor.constraint(equalTo: middleImageView.heightAnchor),
			leftImageView.widthAnchor.constraint(equalTo: middleImageView.widthAnchor),
			
			// выступает на 10 из-за правого края экрана
			rightImageView.leadingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10),
			rightImageView.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
			rightImageView.heightAnchor.constraint(equalTo: middleImageView.heightAnchor),
			rightImageView.widthAnchor.constraint(equalTo: middleImageView.widthAnchor),
		])
	}
}
