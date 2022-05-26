//
//  GroupModel.swift
//  VkClient-2
//
//  Created by Денис Сизов on 20.05.2022.
//

import Foundation

/// Модель группы Вконтакте
struct GroupModel: NewsSourceProtocol, Codable {
	var name: String
	var image: String
	var id: Int
	var isMember: Int
	
	enum CodingKeys: String, CodingKey {
		case name
		case id
		case image = "photo_50"
		case isMember = "is_member"
	}
}
