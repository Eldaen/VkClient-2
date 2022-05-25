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
	var friends: [FriendsSection] { get set }
	
	/// Массив друзей после поиска
	var filteredFriends: [FriendsSection] { get set }
	
	/// Список букв для заголовков секций
	var lettersOfNames: [String] { get set }
	
	/// Перезагружает таблицу с друзьями
	func reloadTableView()
	
	/// Запустить спиннер
	func startLoadAnimation()
	
	/// Останавливает спиннер
	func stopLoadAnimation()
	
	/// Показывает ошибку загрузки друзей
	/// - Parameter error: Ошибка загрузки
	func showFriendsLoadingErrorText(_ text: String)
}

// MARK: View Output (Presenter -> View)
/// Исходящий протокол контроллера отображения списка друзей
protocol FriendsListViewOutputProtocol: AnyObject {
	
	/// Возвращает нужного пользователя из секции по indexPath
	/// - Parameter indexPath: IndexPath ячейки, из которой запрашивают пользователя
	func getFriendFromSection(at indexPath: IndexPath) -> UserModel?
	
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
	
	/// Передаёт роутеру запрос на переход в профиль польхзователя
	/// - Parameters:
	///   - friend: Модель пользователя, чей профиль открывать
	func openProfile(for friend: UserModel)
}

// MARK: Interactor Input (Presenter -> Interactor)
/// Входящий протокол интерактора списка друзей
protocol FriendsListInteractorInputProtocol: AnyObject {
	
	/// Загружает список друзей пользователя
	func fetchFriends(_ completion: @escaping (Result<[FriendsSection], Error>) -> Void)

	/// Загружает изображение из сети
	/// - Parameters:
	///   - url: Строка с url картинки, которую нужно загрузить
	///   - completion: Клоужер с картинкой
	func loadImage(_ url: String, completion: @escaping (UIImage) -> Void)
	
	/// Фильтрует друзей по указанному запросу
	/// - Parameter query: Текс запроса
	func search(for query: String, in groups: [FriendsSection], completion: @escaping ([FriendsSection]) -> Void)
}

// MARK: Interactor Output (Interactor -> Presenter)
/// Исходящий протокол интерактора списка друзей
protocol FriendsListInteractorOutputProtocol: AnyObject {
	
}

// MARK: Router Input (Presenter -> Router)
/// Входящий протокол роутера списка друзей
protocol FriendsListRouterInputProtocol: AnyObject {
	var viewController: UIViewController? { get set }

	/// Переход на экран профиля друга
	func openProfile(for friend: UserModel)
}
