//
//  NewsSourceProtocol.swift
//  VkClient-2
//
//  Created by Денис Сизов on 25.05.2022.
//

/// Протокол, описывающий создателя новости
protocol NewsSourceProtocol {
	var name: String { get set }
	var image: String { get set }
	var id: Int { get set }
}
