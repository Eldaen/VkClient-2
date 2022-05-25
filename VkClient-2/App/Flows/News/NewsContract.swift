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
	
	/// Массив моделей новостей
	var news: [NewsTableViewCellModelProtocol] { get set }
	
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
	
	/// Просит презентер поставить лайк
	/// - Parameters:
	///   - post: ID новости
	///   - owner: ID источника новости
	///   - completion: Обновлённое кол-во лайков
	func setLike(post: Int, owner: Int, completion: @escaping (Int) -> Void)
	
	/// Просит презентер убрать лайк
	/// - Parameters:
	///   - post: ID новости
	///   - owner: ID источника новости
	///   - completion: Обновлённое кол-во лайков
	func removeLike(post: Int, owner: Int, completion: @escaping (Int) -> Void)
}

// MARK: View Output (Presenter -> View)
/// Исходящий протокол контроллера отображения новостей
protocol NewsViewOutputProtocol: AnyObject {
	
	/// Конфигурирует ячейку для секции новостей
	/// - Parameters:
	///   - cell: Сама ячейка
	///   - index: Номер ячейки внутри секции новости
	///   - type: Тип ячейки
	func configureCell(cell: UITableViewCell, index: Int, type: NewsViewControllerCellTypes)
	
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
	func fetchNews(_ completion: @escaping (Result<NewsFetchingResponse, Error>) -> Void)
	
	/// Загружает изображение из сети
	/// - Parameters:
	///   - url: Строка с url картинки, которую нужно загрузить
	///   - completion: Клоужер с картинкой
	func loadImage(_ url: String, completion: @escaping (UIImage) -> Void)
	
	/// Загружает массив картинок, ждёт окончания загрузки всех
	/// - Parameters:
	///   - array: Массив моделей картинок, со всеми размерам
	///   - completion: Клоужер с массивом картинок
	func loadImages(array: [ImageSizes], completion: @escaping ([UIImage]) -> Void)
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
