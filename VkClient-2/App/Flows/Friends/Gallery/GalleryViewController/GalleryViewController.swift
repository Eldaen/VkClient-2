//
//  GalleryViewController.swift
//  VkClient-2
//
//  Created by Денис Сизов on 24.05.2022.
//

import UIKit

// MARK: - GalleryViewController
final class GalleryViewController: UIViewController {
	
	// MARK: - Properties
	
	var output: GalleryViewOutputProtocol?
	
	var storedImages = [String]()
	var photoViews = [UIImageView]()
	
	/// UIView
	var galleryView: GalleryView {
		return self.view as! GalleryView
	}
	
	/// Прогресс прокрутки галереи
	lazy private var progress = Progress(totalUnitCount: Int64(photoViews.count))
	
	// UIViewPropertyAnimator, задаём доступные нам жесты
	private var swipeToRight: UIViewPropertyAnimator!
	private var swipeToLeft: UIViewPropertyAnimator!
	
	// MARK: - Life Cycle
	
	override func loadView() {
		super.loadView()
		self.view = GalleryView()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
		output?.getStoredImages()
		output?.createImageViews()
		updateProgress()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		// регистрируем распознаватель жестов
		let gestPan = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
		galleryView.addGestureRecognizer(gestPan)
		
		configureImages()
		startAnimate()
	}
	
	// чистим вьюхи, чтобы не накладывались
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
		// проходится по всем сабвью этой вьюхи и удаляет её из родителя
		galleryView.mainView.subviews.forEach({ $0.removeFromSuperview() })
	}
}

// MARK: - GalleryViewInputProtocol
extension GalleryViewController: GalleryViewInputProtocol {
	
	func showImageLoadingErrorText(_ text: String) {
		
	}
}

// MARK: - Private methods
private extension GalleryViewController {
	
	// Конфигурируем Нав Бар
	func configureNavigation() {
		self.title = "Галерея"
	}
	
	func updateProgress() {
		let selectedPhoto = output?.selectedPhoto ?? 0
		progress.completedUnitCount = Int64(selectedPhoto + 1)
		galleryView.progressView.setProgress(Float(self.progress.fractionCompleted), animated: true)
	}
	
	func configureImages() {
		guard let output = output else { return }
		
		var indexPhotoLeft = output.selectedPhoto - 1
		let indexPhotoMid = output.selectedPhoto
		var indexPhotoRight = output.selectedPhoto + 1
		
		// делаем круговую прокрутку, чтобы если левый индекс меньше 0, то его ставит последним
		if indexPhotoLeft < 0 {
			indexPhotoLeft = storedImages.count - 1
			
		}
		if indexPhotoRight > storedImages.count - 1 {
			indexPhotoRight = 0
		}
		
		// запускаем загрузку картинок
		output.fetchPhotos(array: [indexPhotoLeft, indexPhotoMid, indexPhotoRight])
		
		// чистим вьюхи, т.к. мы постоянно добавляем новые
		galleryView.mainView.subviews.forEach({ $0.removeFromSuperview() })
		
		// Присваиваем видимым картинкам нужные вьюхи
		galleryView.leftImageView = photoViews[indexPhotoLeft]
		galleryView.middleImageView = photoViews[indexPhotoMid]
		galleryView.rightImageView = photoViews[indexPhotoRight]
		
		galleryView.setImages()
	}
	
	/// Cначала ставит нужные картинки и потом включает анимацию увеличения до оригинала
	func startAnimate(){
		configureImages()
		UIView.animate(
			withDuration: 1,
			delay: 0,
			options: [],
			animations: { [weak self] in
				self?.galleryView.middleImageView.transform = .identity
				self?.galleryView.rightImageView.transform = .identity
				self?.galleryView.leftImageView.transform = .identity
			})
	}
	
	@objc func onPan(_ recognizer: UIPanGestureRecognizer) {
		switch recognizer.state {
		case .began:
			swipeToRight = setSwipeToRight()
			swipeToLeft = setSwipeToLeft()
		case .changed:
			let translationX = recognizer.translation(in: self.view).x
			if translationX > 0 {
				swipeToRight.fractionComplete = abs(translationX)/100 // fractionComplete это про завершенность анимации от 0 до 1, можно плавно делать анимацию в зависимости от жеста
			} else {
				swipeToLeft.fractionComplete = abs(translationX)/100
			}
		case .ended:
			swipeToRight.continueAnimation(withTimingParameters: nil, durationFactor: 0)
			swipeToLeft.continueAnimation(withTimingParameters: nil, durationFactor: 0)
		default:
			return
		}
	}
	
	func moveViews(using transform: CGAffineTransform) {
		galleryView.middleImageView.transform = transform
		galleryView.rightImageView.transform = transform
		galleryView.leftImageView.transform = transform
	}
	
	func setSwipeToRight() -> UIViewPropertyAnimator {
		return UIViewPropertyAnimator(
			duration: 0.5,
			curve: .easeInOut,
			animations: {
				UIView.animate(
					withDuration: 0.01,
					animations: { [weak self] in
						guard let self = self else { return }
						let scale = CGAffineTransform(scaleX: 0.8, y: 0.8) // уменьшаем
						let translation = CGAffineTransform(translationX: self.galleryView.bounds.maxX - 10, y: 0) // направо до края экрана - 10, у нас так констрэйнты заданы
						let transform = scale.concatenating(translation)
						self.moveViews(using: transform)
					}, completion: { [weak self] _ in
						guard let self = self,
							  let output = self.output else {
							return
						}
						output.selectedPhoto -= 1
						if output.selectedPhoto < 0 {
							output.selectedPhoto = self.storedImages.count - 1
						}
						self.updateProgress()
						self.startAnimate()
					})
			})
	}
	
	func setSwipeToLeft() -> UIViewPropertyAnimator {
		return UIViewPropertyAnimator(
			duration: 0.3,
			curve: .easeInOut,
			animations: {
				UIView.animate(
					withDuration: 0.01,
					animations: { [weak self] in
						guard let self = self else { return }
						let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
						let translation = CGAffineTransform(translationX: -self.galleryView.bounds.maxX + 10, y: 0)
						let transform = scale.concatenating(translation)
						self.moveViews(using: transform)
					}, completion: { [weak self] _ in
						guard let self = self,
							  let output = self.output else {
							return
						}
						output.selectedPhoto += 1
						if output.selectedPhoto > self.storedImages.count - 1 {
							output.selectedPhoto = 0
						}
						self.updateProgress()
						self.startAnimate()
					})
			})
	}
}
