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
	
	/// Запустить спиннер
	func startLoadAnimation()
	
	/// Останавливает спиннер
	func stopLoadAnimation()
	
	/// Показывает ошибку загрузки друзей
	/// - Parameter error: Ошибка загрузки
	func showProfileLoadingErrorText(_ text: String)
}

// MARK: View Output (Presenter -> View)
/// Исходящий протокол контроллера отображения профиля друга
protocol FriendsProfileViewOutputProtocol: AnyObject {
	
	/// Загружает картинки пользователя
	func fetchImages()
	
	/// Загружает изображение из сети
	/// - Parameters:
	///   - url: Строка с url картинки, которую нужно загрузить
	///   - completion: Клоужер с картинкой
	func loadImage(_ url: String, completion: @escaping (UIImage) -> Void)
}

// MARK: Interactor Input (Presenter -> Interactor)
/// Входящий протокол интерактора профиля друга
protocol FriendsProfileInteractorInputProtocol: AnyObject {

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

	/// Переход на экран профиля друга
	func openImage(for friend: UserModel)
}
