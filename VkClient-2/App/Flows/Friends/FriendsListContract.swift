//
//  FriendsListContract.swift
//  VkClient-2
//
//  Created by Денис Сизов on 23.05.2022.
//

import UIKit

// MARK: View Input (View -> Presenter)
/// Входящий протокол контроллера отображения списка друзей
protocol FriendsListViewInputProtocol: AnyObject {
	
	/// Массив друзей пользователя
	var friends: [UserModel] { get set }
	
	/// Массив друзей после поиска
	var filteredFriends: [UserModel] { get set}
	
	/// Запустить спиннер
	func startLoadAnimation()
	
	/// Останавливает спиннер
	func stopLoadAnimation()
}

// MARK: View Output (Presenter -> View)
/// Исходящий протокол контроллера отображения списка друзей
protocol FriendsListViewOutputProtocol: AnyObject {
	
	/// Загружает пользователей
	func fetchFriends()
	
	/// Загружает изображение из сети
	/// - Parameters:
	///   - url: Строка с url картинки, которую нужно загрузить
	///   - completion: Клоужер с картинкой
	func loadImage(_ url: String, completion: @escaping (UIImage) -> Void)
	
	/// Фильтрует друзей по указанному запросу
	/// - Parameter query: Текс запроса
	func search(_ query: String)
	
	/// Отменяет поиск
	func cancelSearch()
}

// MARK: Interactor Input (Presenter -> Interactor)
/// Входящий протокол интерактора списка друзей
protocol FriendsListInteractorInputProtocol: AnyObject {

	/// Загружает изображение из сети
	/// - Parameters:
	///   - url: Строка с url картинки, которую нужно загрузить
	///   - completion: Клоужер с картинкой
	func loadImage(_ url: String, completion: @escaping (UIImage) -> Void)
	
	/// Фильтрует группы по указанному запросу
	/// - Parameter query: Текс запроса
	func search(for query: String, in groups: [UserModel], completion: @escaping ([UserModel]) -> Void)
}

// MARK: Interactor Output (Interactor -> Presenter)
/// Исходящий протокол интерактора списка друзей
protocol FriendsListnteractorOutputProtocol: AnyObject {
	
}

// MARK: Router Input (Presenter -> Router)
/// Входящий протокол роутера списка друзей
protocol FriendsListRouterInputProtocol: AnyObject {
	var viewController: UIViewController? { get set }

	/// Переход на экран профиля друга
	func navigateToFriendProfile()
}
