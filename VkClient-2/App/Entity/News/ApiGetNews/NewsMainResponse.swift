//
//  NewsMainResponse.swift
//  VkClient-2
//
//  Created by Денис Сизов on 25.05.2022.
//

/// Основной ответ от АПИ при запросе новостей
struct NewsMainResponse: Codable {
	let response: NewsContentResponse
}
