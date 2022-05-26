//
//  ShowMoreNewsTextDelegate.swift
//  VkClient-2
//
//  Created by Денис Сизов on 26.05.2022.
//

import Foundation

/// Протокол Делегат для обновления высоты ячейки текста
protocol ShowMoreNewsTextDelegate: AnyObject {
	
	/// Обновляет высоту текста в нужной ячейке
	/// - Parameter indexPath: indexPath ячейки, текст которой раскрыли
	func updateTextHeight(indexPath: IndexPath)
}
