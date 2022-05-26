//
//  DemoModeDelegate.swift
//  VkClient-2
//
//  Created by Денис Сизов on 26.05.2022.
//

import Foundation

/// Протокол обработчика нажатия на кнопку DemoMode
protocol DemoModeDelegate: AnyObject {
	
	/// Запускает демо режим
	func demoOn()
}
