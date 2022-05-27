//
//  ApiImage.swift
//  VkClient-2
//
//  Created by Денис Сизов on 20.05.2022.
//

/// Модель картинки с разными размерами
struct ApiImage: Codable {
	let sizes: [ImageSizes]
}
