//
//  VkFriendsResponse.swift
//  VkClient-2
//
//  Created by Денис Сизов on 23.05.2022.
//

/// Cтруктура стандартного ответа API Вконтакте по запросу друзей
struct VkFriendsResponse: Codable {
	let count: Int
	let items: [UserModel]
}
