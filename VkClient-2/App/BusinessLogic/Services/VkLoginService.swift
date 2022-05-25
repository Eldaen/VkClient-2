//
//  VkLoginService.swift
//  VkClient-2
//
//  Created by Денис Сизов on 05.05.2022.
//

import Foundation

/// Сервис для экрана авторизации
final class VkLoginService: VkLoginServiceInput {

	func loadView(_ completion: @escaping (URLRequest) -> Void) {
		var urlComponents = URLComponents()
		urlComponents.scheme = "https"
		urlComponents.host = "oauth.vk.com"
		urlComponents.path = "/authorize"
		urlComponents.queryItems = [
			URLQueryItem(name: "client_id", value: "8002071"),
			URLQueryItem(name: "display", value: "mobile"),
			URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html" ),
			URLQueryItem(name: "scope", value: "friends, photos, wall, groups"),
			URLQueryItem(name: "response_type", value: "token"),
			URLQueryItem(name: "revoke", value: "0")
		]
		guard let url = urlComponents.url else { return }
		let request = URLRequest(url: url)
		completion(request)
	}
}
