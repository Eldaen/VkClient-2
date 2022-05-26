//
//  UserImagesResponse.swift
//  VkClient-2
//
//  Created by Денис Сизов on 20.05.2022.
//

/// Cтруктура стандартного ответа API Вконтакте по запросу фото пользователя по id
struct UserImagesResponse: Codable {
	let count: Int
	let items: [ApiImage]
}
