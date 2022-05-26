//
//  ShowMoreNewsTextDelegate.swift
//  VkClient-2
//
//  Created by Денис Сизов on 26.05.2022.
//

import Foundation

/// Протокол Делегат для обновления высоты ячейки текста
protocol ShowMoreNewsTextDelegate: AnyObject {
	func updateTextHeight(indexPath: IndexPath)
}
