//
//  NewsSourceProtocol.swift
//  VkClient-2
//
//  Created by Денис Сизов on 25.05.2022.
//

/// Протокол, описывающий создателя новости
protocol NewsSourceProtocol {
	
	/// Название истоичника
	var name: String { get set }
	
	/// Ссылка на картинку
	var image: String { get set }
	
	/// ID источника
	var id: Int { get set }
}
