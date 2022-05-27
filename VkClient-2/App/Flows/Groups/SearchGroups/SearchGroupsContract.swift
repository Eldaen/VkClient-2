//
//  SearchGroupsContract.swift
//  VkClient-2
//
//  Created by Денис Сизов on 20.05.2022.
//

import UIKit

// MARK: View Input (View -> Presenter)
/// Входящий протокол контроллера отображения списка найденных групп
protocol SearchGroupsViewInputProtocol: AnyObject {
	
	/// Массив найденных
	var groups: [GroupModel] { get set }
	
	/// Массив групп пользователей после поиска
	var filteredGroups: [GroupModel] { get set }
	
	/// Перезагружает таблицу с группами
	func reloadTableView()
	
	/// Запустить спиннер
	func startLoadAnimation()
	
	/// Останавливает спиннер
	func stopLoadAnimation()
	
	/// Показывает ошибку загрузки групп
	/// - Parameter error: Ошибка загрузки
	func showGroupsLoadingErrorText(_ text: String)
	
	/// Показывает ошибку вступления в группу
	/// - Parameter error: Ошибка загрузки
	func showGroupJoiningErrorText(_ text: String)
}

// MARK: View Output (Presenter -> View)
/// Исходящий протокол контроллера отображения найденных групп
protocol SearchGroupsViewOutputProtocol: AnyObject {
	
	/// Загружает список найденных
	func fetchGroups()
	
	/// Вступает в выбранную группу
	/// - Parameters:
	///   - id: id группы
	func joinGroup(id: Int)
	
	/// Загружает изображение из сети
	/// - Parameters:
	///   - url: Строка с url картинки, которую нужно загрузить
	///   - completion: Клоужер с картинкой
	func loadImage(_ url: String, completion: @escaping (UIImage) -> Void)
	
	/// Фильтрует группы по указанному запросу
	/// - Parameter query: Текс запроса
	func search(_ query: String)
	
	/// Отменяет поиск
	func cancelSearch()
}

// MARK: Interactor Input (Presenter -> Interactor)
/// Входящий протокол интерактора списка найденных групп
protocol SearchGroupsInteractorInputProtocol: AnyObject {
	
	/// Загружает найденные группы
	/// - Parameter completion: Клоужер с массивом моделей групп или ошибка
	func fetchGroups(_ completion: @escaping (Result<[GroupModel], Error>) -> Void)
	
	/// Вступает в выбранную группу
	/// - Parameters:
	///   - id: id группы
	///   - completion: Клоужер с результатом вступления
	func joinGroup(id: Int, completion: @escaping (Result<Bool, Error>) -> Void)
	
	/// Загружает изображение из сети
	/// - Parameters:
	///   - url: Строка с url картинки, которую нужно загрузить
	///   - completion: Клоужер с картинкой
	func loadImage(_ url: String, completion: @escaping (UIImage) -> Void)
	
	/// Фильтрует группы по указанному запросу
	/// - Parameter query: Текс запроса
	func search(for query: String, completion: @escaping (Result<[GroupModel], Error>) -> Void)
}

// MARK: Interactor Output (Interactor -> Presenter)
/// Исходящий протокол интерактора списка найденных групп
protocol SearchGroupsInteractorOutputProtocol: AnyObject {
	
	/// Показывает ошибку выхода из группы
	/// - Parameter error: Ошибка загрузки
	func showGroupJoiningError(_ error: Error)
}

// MARK: Router Input (Presenter -> Router)
/// Входящий протокол роутера списка найденных групп
protocol SearchGroupsRouterInputProtocol: AnyObject {
	var viewController: UIViewController? { get set }
	
	/// Переход на экран поиска групп
	func navigateToMyGroups()
}
