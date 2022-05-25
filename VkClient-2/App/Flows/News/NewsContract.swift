//
//  NewsContract.swift
//  VkClient-2
//
//  Created by Денис Сизов on 25.05.2022.
//

import UIKit

// MARK: View Input (View -> Presenter)
/// Входящий протокол контроллера отображения новостей
protocol NewsViewInputProtocol: AnyObject {
	
	/// Перезагружает таблицу с новостями
	func reloadTableView()
	
	/// Запускает спиннер
	func startLoadAnimation()
	
	/// Останавливает спиннер
	func stopLoadAnimation()
	
	/// Показывает ошибку загрузки новостей
	/// - Parameter error: Ошибка загрузки
	func showNewsLoadingErrorText(_ text: String)
	
	/// Показывает ошибку выхода из группы
	/// - Parameter error: Ошибка загрузки
	func showNewsLikeErrorText(_ text: String)
}

// MARK: View Output (Presenter -> View)
/// Исходящий протокол контроллера отображения новостей
protocol NewsViewOutputProtocol: AnyObject {
	
	/// Загружает список новостей
	func fetchNews()
	
	/// Загружает изображение из сети
	/// - Parameters:
	///   - url: Строка с url картинки, которую нужно загрузить
	///   - completion: Клоужер с картинкой
	func loadImage(_ url: String, completion: @escaping (UIImage) -> Void)
}

// MARK: Interactor Input (Presenter -> Interactor)
/// Входящий протокол интерактора списка новостей
protocol NewsInteractorInputProtocol: AnyObject {
	
	/// Загружает список групп пользователя
	func fetchNews(_ completion: @escaping (Result<[GroupModel], Error>) -> Void)
	
	/// Загружает изображение из сети
	/// - Parameters:
	///   - url: Строка с url картинки, которую нужно загрузить
	///   - completion: Клоужер с картинкой
	func loadImage(_ url: String, completion: @escaping (UIImage) -> Void)
}

// MARK: Interactor Output (Interactor -> Presenter)
/// Исходящий протокол интерактора списка новостей
protocol NewsInteractorOutputProtocol: AnyObject {
	
	/// Показывает ошибку выхода из группы
	/// - Parameter error: Ошибка загрузки
	func showNewsLoadingError(_ error: Error)
	
	/// Показывает ошибку выхода из группы
	/// - Parameter error: Ошибка загрузки
	func showNewsLikeError(_ error: Error)
}
