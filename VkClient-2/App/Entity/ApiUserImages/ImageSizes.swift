//
//  ImageSizes.swift
//  VkClient-2
//
//  Created by Денис Сизов on 20.05.2022.
//

/// Возможные варианты размеров картинки пользователя
struct ImageSizes: Codable {
	let url: String
	let type: String
	let height: Int
	let width: Int
}
