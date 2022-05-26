//
//  VkLoginContract.swift
//  VkClient-2
//
//  Created by Денис Сизов on 26.04.2022.
//

import UIKit

// MARK: View Input (View -> Presenter)
/// Входящий протокол контроллера авторизации
protocol VkLoginViewInputProtocol: AnyObject {
	
}

// MARK: View Output (Presenter -> View)
/// Исходящий протокол контроллера авторизации
protocol VkLoginViewOutputProtocol: AnyObject {
	var router: VkLoginRouterInputProtocol? { get set }
	var interactor: VkLoginInteractorInputProtocol? { get set }
	var view: VkLoginViewInputProtocol? { get set }
	
	/// Настраивает экран авторизации
	/// - Parameter view: UIView авторизации
	func setupWKView(with view: VkLoginView)
	
	/// Перейти на основной Таб бар контроллер приложения
	func authorize()
	
	/// Запускает демо режим приложения
	func enableDemoMode()
}

// MARK: Interactor Input (Presenter -> Interactor)
/// Входящий протокол интерактора авторизации
protocol VkLoginInteractorInputProtocol: AnyObject {
	var service: VkLoginService? { get set }
	
	/// Загружает экран авторизации
	/// - Parameter view: UIView авторизации
	func loadScreen(with view: VkLoginView)
}

// MARK: Interactor Output (Interactor -> Presenter)
/// Исходящий протокол интерактора авторизации
protocol VkLoginInteractorOutputProtocol: AnyObject {
	
}

// MARK: Router Input (Presenter -> Router)
/// Входящий протокол роутера авторизации
protocol VkLoginRouterInputProtocol: AnyObject {
	var viewController: UIViewController? { get set }
	
	/// Перейти к основной версии программы
	func pushRealApp()
	
	/// Перейти к демо версии программы
	func pushDemoApp()
}

// MARK: - Service Input (Interactor -> Service)
/// Входящий протокол сервиса
protocol VkLoginServiceInput {
	
	/// Загрузить данные webView
	///  - Parameter completion: Блок, обрабатывающий выполнение запроса
	func loadView(_ completion: @escaping (URLRequest) -> Void)
}
