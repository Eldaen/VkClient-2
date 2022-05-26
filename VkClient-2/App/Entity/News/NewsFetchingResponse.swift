//
//  NewsFetchingResponse.swift
//  VkClient-2
//
//  Created by Денис Сизов on 25.05.2022.
//

/// Структура ответа лоадера новостей
struct NewsFetchingResponse {
	
	/// Массив новостей
	var news: [NewsTableViewCellModelProtocol]
	
	/// Данные для пре-фетчинга
	var nextFrom: String
}
