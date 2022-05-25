//
//  FriendsProfileContract.swift
//  VkClient-2
//
//  Created by Денис Сизов on 23.05.2022.
//

import UIKit

// MARK: View Input (View -> Presenter)
/// Входящий протокол контроллера отображения профиля друга
protocol FriendsProfileViewInputProtocol: AnyObject {
	
	/// Массив строк со ссылками на картинки пользователя
	var storedImages: [String] { get set }
	
	/// Запустить спиннер
	func startLoadAnimation()
	
	/// Останавливает спиннер
	func stopLoadAnimation()
	
	/// Показывает ошибку загрузки друзей
	/// - Parameter error: Ошибка загрузки
	func showProfileLoadingErrorText(_ text: String)
	
	/// Перезагружает коллекцию
	func reloadСollectionView()
}

// MARK: View Output (Presenter -> View)
/// Исходящий протокол контроллера отображения профиля друга
protocol FriendsProfileViewOutputProtocol: AnyObject {
	
	/// Модель друга, чей профиль открывается
	var friend: UserModel { get }
	
	/// Загружает профиль пользователя
	func loadProfile()
	
	/// Загружает изображение из сети
	/// - Parameters:
	///   - url: Строка с url картинки, которую нужно загрузить
	///   - completion: Клоужер с картинкой
	func loadImage(_ url: String, completion: @escaping (UIImage) -> Void)
	
	/// Просит роутер открыть экран подробного просмотра фото
	/// - Parameter photo: id фото в массиве моделей фотографий, который хранится в интеракторе
	func openGalleryFor(photo: Int)
}

// MARK: Interactor Input (Presenter -> Interactor)
/// Входящий протокол интерактора профиля друга
protocol FriendsProfileInteractorInputProtocol: AnyObject {
	
	/// Массив моделей картинок пользователя
	var storedModels: [ApiImage] { get }
	
	/// Загружает модели картинок пользователя
	/// - Parameters:
	///   - for: id друга, чей профиль открывается
	///   - completion: Клоужер с массивом ссылок на картинки
	func loadUserPhotos(for id: String, completion: @escaping (Result<[String], Error>) -> Void)

	/// Загружает изображение из сети
	/// - Parameters:
	///   - url: Строка с url картинки, которую нужно загрузить
	///   - completion: Клоужер с картинкой
	func loadImage(_ url: String, completion: @escaping (UIImage) -> Void)
}

// MARK: Interactor Output (Interactor -> Presenter)
/// Исходящий протокол интерактора профиля друга
protocol FriendsProfileInteractorOutputProtocol: AnyObject {
	
}

// MARK: Router Input (Presenter -> Router)
/// Входящий протокол роутера списка друзей
protocol FriendsProfileRouterInputProtocol: AnyObject {
	var viewController: UIViewController? { get set }

	/// Переход на экран подробного просмотра фото
	func openGalleryFor(photo: Int, in images: [ApiImage])
}
