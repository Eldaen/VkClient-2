//
//  MyGroupsContract.swift
//  VkClient-2
//
//  Created by Денис Сизов on 05.05.2022.
//

import UIKit

// MARK: View Input (View -> Presenter)
/// Входящий протокол контроллера отображения списка групп пользователя
protocol MyGroupsViewInputProtocol: AnyObject {
	
	/// Массив групп пользователя
	var groups: [GroupModel] { get set }
	
	/// Массив групп пользователей после поиска
	var filteredGroups: [GroupModel] { get set }
	
	/// Перезагружает таблицу с группами
	func reloadTableView()
	
	/// Обновляет список групп
	func reloadViewData()
	
	/// Показывает ошибку загрузки групп
	/// - Parameter error: Ошибка загрузки
	func showGroupsLoadingErrorText(_ text: String)
	
	/// Показывает ошибку выхода из группы
	/// - Parameter error: Ошибка загрузки
	func showGroupsLeavingErrorText(_ text: String)
	
	/// Удаляет из таблицы ячейку группы, из которой вышли
	/// - Parameter indexPath: idexPath ячейки, которую нужно удалить
	func deleteGroupFromView(at indexPath: IndexPath)
}

// MARK: View Output (Presenter -> View)
/// Исходящий протокол контроллера отображения списка групп пользователя
protocol MyGroupsViewOutputProtocol: AnyObject {
	
	/// Загружает список групп пользователя
	func fetchGroups()
	
	/// Выходит из выбранной группы
	/// - Parameters:
	///   - id: id группы
	///   - index: idexPath группы в таблице
	func leaveGroup(id: Int, index: IndexPath)
	
	/// Загружает изображение из сети
	/// - Parameters:
	///   - url: Строка с url картинки, которую нужно загрузить
	///   - completion: Клоужер с картинкой
	func loadImage(_ url: String, completion: @escaping (UIImage) -> Void)
	
	/// Переход на экран поиска групп
	func navigateToSearchGroups()
	
	/// Фильтрует группы по указанному запросу
	/// - Parameter query: Текс запроса
	func search(_ query: String)
	
	/// Отменяет поиск
	func cancelSearch()
}

// MARK: Interactor Input (Presenter -> Interactor)
/// Входящий протокол интерактора списка групп пользователя
protocol MyGroupsInteractorInputProtocol: AnyObject {
	
	/// Загружает список групп пользователя
	func fetchGroups(_ completion: @escaping (Result<[GroupModel], Error>) -> Void)
	
	/// Загружает изображение из сети
	/// - Parameters:
	///   - url: Строка с url картинки, которую нужно загрузить
	///   - completion: Клоужер с картинкой
	func loadImage(_ url: String, completion: @escaping (UIImage) -> Void)
	
	/// Выходит из выбранной группы
	/// - Parameters:
	///   - id: id группы
	///   - index: idexPath группы в таблице
	func leaveGroup(id: Int, index: IndexPath)
	
	/// Фильтрует группы по указанному запросу
	/// - Parameter query: Текс запроса
	func search(for query: String, in groups: [GroupModel], completion: @escaping ([GroupModel]) -> Void)
}

// MARK: Interactor Output (Interactor -> Presenter)
/// Исходящий протокол интерактора списка групп пользователя
protocol MyGroupsInteractorOutputProtocol: AnyObject {
	
	/// Заканчивает выход из группы и вызывает удаление ячейки из таблицы
	/// - Parameter at: indexPatch ячейки группы, которую покинули
	func removeGroup(at indexPath: IndexPath)
	
	/// Показывает ошибку выхода из группы
	/// - Parameter error: Ошибка загрузки
	func showGroupLeavingError(_ error: Error)
}

// MARK: Router Input (Presenter -> Router)
/// Входящий протокол роутера списка групп пользователя
protocol MyGroupsRouterInputProtocol: AnyObject {
	var viewController: UIViewController? { get set }

	/// Переход на экран поиска групп
	func navigateToSearchGroups()
}
