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
	
}

// MARK: Interactor Input (Presenter -> Interactor)
/// Входящий протокол интерактора авторизации
protocol VkLoginInteractorInputProtocol: AnyObject {
	
}

// MARK: Interactor Output (Interactor -> Presenter)
/// Исходящий протокол интерактора авторизации
protocol VkLoginInteractorOutputProtocol: AnyObject {
	
}

// MARK: Router Input (Presenter -> Router)
/// Входящий протокол роутера авторизации
protocol VkLoginRouterInputProtocol: AnyObject {
	
}
