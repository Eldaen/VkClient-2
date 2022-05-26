//
//  NewsContentsResponse.swift
//  VkClient-2
//
//  Created by Денис Сизов on 25.05.2022.
//

/// Структура данных новости
struct NewsContentResponse: Codable {
	let items: [NewsModel]
	let profiles: [UserModel]
	let groups: [GroupModel]
	let nextFrom: String?

	enum CodingKeys: String, CodingKey {
		case items, profiles, groups
		case nextFrom = "next_from"
	}
}
