//
//  UserModel.swift
//  VkClient-2
//
//  Created by Денис Сизов on 23.05.2022.
//

import Foundation

/// Модель пользователя
struct UserModel: Codable {
	var name: String
	var image: String
	var id: Int
	
	enum CodingKeys: String, CodingKey {
		case name = "first_name"
		case image = "photo_100"
		case id
	}
}
