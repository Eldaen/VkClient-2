//
//  GalleryContract.swift
//  VkClient-2
//
//  Created by Денис Сизов on 24.05.2022.
//

import UIKit

// MARK: View Input (View -> Presenter)
/// Входящий протокол контроллера подробного просмотра фото
protocol GalleryViewInputProtocol: AnyObject {
	
	/// Массив строк со ссылками на картинки пользователя
	var storedImages: [String] { get set }
	
	/// Массив UIImageView с фотографиями
	var photoViews: [UIImageView] { get set }
	
	/// Показывает ошибку загрузки картинок
	/// - Parameter error: Ошибка загрузки
	func showImageLoadingErrorText(_ text: String)
}

// MARK: View Output (Presenter -> View)
/// Исходящий протокол контроллера подробного просмотра фото
protocol GalleryViewOutputProtocol: AnyObject {
	
	/// Загружает активные картинки
	func fetchPhotos(array: [Int])
	
	/// Загружает изображение из сети
	/// - Parameters:
	///   - url: Строка с url картинки, которую нужно загрузить
	///   - completion: Клоужер с картинкой
	func loadImage(_ url: String, completion: @escaping (UIImage) -> Void)
	
	/// Сортирует из моделей нужные ссылки на картинки в storedImages
	func getStoredImages()
}

// MARK: Interactor Input (Presenter -> Interactor)
/// Входящий протокол интерактора подробного просмотра фото
protocol GalleryInteractorInputProtocol: AnyObject {
	
	/// Загружает изображение из сети
	/// - Parameters:
	///   - url: Строка с url картинки, которую нужно загрузить
	///   - completion: Клоужер с картинкой
	func loadImage(_ url: String, completion: @escaping (UIImage) -> Void)
}

// MARK: Interactor Output (Interactor -> Presenter)
/// Исходящий протокол интерактора подробного просмотра фото
protocol GalleryInteractorOutputProtocol: AnyObject {
	
}
