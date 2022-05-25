//
//  GroupsMyResponse.swift
//  VkClient-2
//
//  Created by Денис Сизов on 20.05.2022.
//

/// Cтруктура стандартного ответа API Вконтакте по запросу групп пользователя
struct GroupsMyResponse: Codable {
	let count: Int
	let items: [GroupModel]
}
