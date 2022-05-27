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
}

// MARK: View Output (Presenter -> View)
/// Исходящий протокол контроллера подробного просмотра фото
protocol GalleryViewOutputProtocol: AnyObject {
	
	/// Текущее главное фото в карусели
	var selectedPhoto: Int { get set }
	
	/// Загружает активные картинки
	func fetchPhotos(array: [Int])
	
	/// Сортирует из моделей нужные ссылки на картинки в storedImages
	func getStoredImages()
	
	/// Создаёт массив UIImageView для отображения галереи
	func createImageViews()
}

// MARK: Interactor Input (Presenter -> Interactor)
/// Входящий протокол интерактора подробного просмотра фото
protocol GalleryInteractorInputProtocol: AnyObject {
	
	/// Загружает изображение из сети
	/// - Parameters:
	///   - url: Строка с url картинки, которую нужно загрузить
	///   - completion: Клоужер с картинкой
	func loadImage(_ url: String, completion: @escaping (UIImage) -> Void)
	
	/// Сортирует картинки нужного размера из моделей
	/// - Parameter completion: Массив строк со ссылками на картинки нужного размера
	func getStoredImages(completion: @escaping ([String]) -> Void)
}

// MARK: Interactor Output (Interactor -> Presenter)
/// Исходящий протокол интерактора подробного просмотра фото
protocol GalleryInteractorOutputProtocol: AnyObject {
	
}
