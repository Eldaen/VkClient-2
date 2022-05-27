//
//  NewsRefreshDelegateProtocol.swift
//  VkClient-2
//
//  Created by Денис Сизов on 26.05.2022.
//

import Foundation

/// Протокол делегата, который должен обновлять новости, по запросу View
@objc protocol NewsRefreshDelegateProtocol {
	
	/// Загружает свежие новости
	@objc func refreshNews()
}
