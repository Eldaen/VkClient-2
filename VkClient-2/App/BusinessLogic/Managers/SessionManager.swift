//
//  SessionManager.swift
//  VkClient-2
//
//  Created by Денис Сизов on 05.05.2022.
//

import Foundation
import WebKit

/// Класс для хранения данных авторизации, Singleton
final class SessionManager {
	
	// MARK: - Properties
	
	/// Токен авторизации
	var token: String?
	
	/// ID пользователя, под которым авторизовались
	var userID: Int?
	
	///  Инстанс синглтона Session
	static let instance = SessionManager()
	
	// MARK: - Init
	
	private init() {}
	
	// MARK: - Methods
	
	/// Сохраняет данные авторизации пользователя
	/// - Parameters:
	///   - token: Токен авторизации от ВК Апи
	///   - userId: ID юзера, под которым атворизовались
	func loginUser(with token: String, userId: Int) {
		self.token = token
		self.userID = userId
		print("Token: \(token)")
	}
	
	/// Очищает текущую сессию, чтобы можно было сделать logout
	func clean() {
		HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
		WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
			records.forEach { record in
				WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
			}
		}
	}
}
