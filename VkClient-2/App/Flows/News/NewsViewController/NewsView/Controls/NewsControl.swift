//
//  NewsControl.swift
//  VkClient-2
//
//  Created by Денис Сизов on 25.05.2022.
//

import UIKit

/// Контрол для отображения вьюшки с лайками и возможность лайкнуть
class NewsControl: UIControl {
	
	// MARK: - Properties
	
	override var intrinsicContentSize: CGSize {
		return CGSize(width: 50, height: 30)
	}
	
	internal var count: Int = 0
	
	lazy var tapGestureRecognizer: UITapGestureRecognizer = {
		let recognizer = UITapGestureRecognizer(target: self,
												action: #selector(onClick))
		recognizer.numberOfTapsRequired = 1
		recognizer.numberOfTouchesRequired = 1
		return recognizer
	}()
	
	private var controlImage: UIImageView = UIImageView()
	private var label: UILabel = UILabel()
	private var bgView: UIView = UIView()
	
	// MARK: - Methods
	
	internal func setupView() {
		
		// Чтобы вьюха была без фона и не мешала
		self.backgroundColor = .clear
		
		controlImage.frame = CGRect(x: 5, y: 5, width: 24, height: 21)
		controlImage.tintColor = .black
		
		//Настраиваем Label
		label.frame = CGRect(x: 30, y: 8, width: 50, height: 12)
		label.text = String(count)
		label.textAlignment = .left
		label.font = UIFont.sixteen
		
		// нужно создать пустую вью подложку, чтобы на ней анимировались лайки, на сам лайк контрол нельзя
		bgView.frame = bounds
		bgView.addSubview(controlImage)
		bgView.addSubview(label)
		
		self.addSubview(bgView)
	}
	
	/// Обновляет счётчик контрола
	func setCount(with value: Int) {
		count = value
		label.text = "\(value)"
		label.layoutIfNeeded()
	}
	
	/// Задаёт контролу системную картинку
	func setImage(with name: String) {
		if let image = UIImage(systemName: name) {
			controlImage.image = image
		}
	}
	
	/// Меняет вью с одной картинкой на вью с другой
	@objc func onClick() {
		
	}
	
	override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
		let frame = self.bounds.insetBy(dx: -20, dy: -20)
		return frame.contains(point) ? self : nil
	}
	
  // MARK: - Init
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.setupView()
		addGestureRecognizer(tapGestureRecognizer)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.setupView()
		addGestureRecognizer(tapGestureRecognizer)
	}
}
