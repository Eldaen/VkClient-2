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
		let gestPan = UIPanGestureRecognizer(target: self, action: #selector(output?.onPan(_:)))
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
}
