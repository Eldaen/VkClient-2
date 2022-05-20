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
	
	/// Показывает ошибку загрузки групп
	/// - Parameter error: Ошибка загрузки
	func showGroupsLoadingError(_ error: Error)
}

// MARK: View Output (Presenter -> View)
/// Исходящий протокол контроллера отображения списка групп пользователя
protocol MyGroupsViewOutputProtocol: AnyObject {
	var router: MyGroupsRouterInputProtocol? { get set }
	var interactor: MyGroupsInteractorInputProtocol? { get set }
	var view: MyGroupsViewInputProtocol? { get set }
	
	/// Загружает список групп пользователя
	func fetchGroups()
	
	/// Загружает изображение из сети
	/// - Parameters:
	///   - url: Строка с url картинки, которую нужно загрузить
	///   - completion: Клоужер с картинкой
	func loadImage(_ url: String, completion: @escaping (UIImage) -> Void)
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
}

// MARK: Interactor Output (Interactor -> Presenter)
/// Исходящий протокол интерактора списка групп пользователя
protocol MyGroupsInteractorOutputProtocol: AnyObject {
	
}

// MARK: Router Input (Presenter -> Router)
/// Входящий протокол роутера списка групп пользователя
protocol MyGroupsRouterInputProtocol: AnyObject {
	var viewController: UIViewController? { get set }
}

// MARK: - Service Input (Interactor -> Service)
/// Входящий протокол сервиса
protocol MyGroupsServiceInput {
	
}
