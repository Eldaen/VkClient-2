//
//  PhotosResponseModel.swift
//  VkClient-2
//
//  Created by Денис Сизов on 25.05.2022.
//

/// Ответ АПИ про фото у новости
struct PhotosResponseModel: Codable {
	let count: Int
	let items: [ApiImage]
}
