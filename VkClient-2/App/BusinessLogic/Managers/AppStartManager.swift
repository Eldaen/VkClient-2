//
//  AppStartManager.swift
//  VkClient-2
//
//  Created by Денис Сизов on 26.05.2022.
//

import UIKit

// MARK: - RestartDelegate
protocol RestartDelegate: AnyObject {
	func restart()
}

// MARK: - AppStartManager
/// Сборщик первоначального запуска приложения
final class AppStartManager {
	
	// MARK: - Properties
	
	var window: UIWindow?
	
	// MARK: - Init
	init(window: UIWindow?) {
		self.window = window
	}
	
	// MARK: - Methods
	
	func start() {
		let navigationController = UINavigationController(rootViewController: VkLoginBuilder.build(restartDelegate: self))
		navigationController.isNavigationBarHidden = true
		
		self.window?.rootViewController = navigationController
		self.window?.makeKeyAndVisible()
	}
}

// MARK: - RestartDelegate
extension AppStartManager: RestartDelegate {
	func restart() {
		SessionManager.instance.clean()
		start()
	}
}
