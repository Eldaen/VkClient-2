//
//  Loader.swift
//  VkClient-2
//
//  Created by Денис Сизов on 20.05.2022.
//

import UIKit

// MARK: - Loader протокол
/// Протокол лоадера данных
protocol LoaderProtocol {
	
	/// Переменная, хранящая в себе Networkmanager,
	var networkManager: NetworkManagerProtocol { get set }
	
	/// Кэш сервис
	var cache: ImageCacheInput { get set }
	
	/// Загружает картинку и возвращает её, если получилось
	/// - Parameters:
	///   - url: строка, содержащая URL
	///   - completion: completion, возаращающий картинку
	func loadImage(url: String, completion: @escaping (UIImage) -> Void)
	
	/// Вытаскивает из моделей картинок URL-ы картинок нужного размера
	/// - Parameters:
	///   - sizeType: Тип размера картинки, который хотим получить
	///   - array: Массив моделей картинок из API, из которых нужно отфильтровать нужные
	/// - Returns: Массив строк с URL-ам картинок нужного размера
	func sortImage(by sizeType: String, from array: [ApiImage]) -> [String]
}

// MARK: - Common methods
extension LoaderProtocol {
	
	/// Проверяет свежесть данных
	/// - Parameter key: Ключ, по которому проверяем
	/// - Returns: True - данные свежие, false - нет.
	func checkExpiry(key: String) -> Bool {
		let expiryDate = UserDefaults.standard.string(forKey: key) ?? "0"
		let currentDate = String(Date.init().timeIntervalSince1970)
		
		if expiryDate > currentDate {
			return true
		} else {
			return false
		}
	}
	
	/// Записывает дату просрочки кэша
	/// - Parameters:
	///   - key: Ключ
	///   - time: Время, когда кэш устареет
	func setExpiry(key: String, time: Double) {
		let date = (Date.init() + time).timeIntervalSince1970
		UserDefaults.standard.set(String(date), forKey: key)
	}
	
	/// Сбрасывает кэш, дата просрочки будет 0
	/// - Parameter key: Ключ кэша
	func dropCache(key: String) {
		UserDefaults.standard.set("0", forKey: key)
	}
	
	/// Загружает картинку из сети
	/// - Parameters:
	///   - url: Строка с url картинки
	///   - completion: Клоужер с картинкой
	func loadImage(url: String, completion: @escaping (UIImage) -> Void) {
		guard let imageUrl = URL(string: url) else { return }
		
		// если есть в кэше, то грузить не нужно
		if let image = cache[imageUrl] {
			completion(image)
			return
		}
		
		// Если нигде нет, то грузим и кешируем
		networkManager.loadImage(url: imageUrl) { result in
			switch result {
			case .success(let data):
				guard let image = UIImage(data: data) else {
					return
				}
				
				cache[imageUrl] = image
				completion(image)
			case .failure(let error):
				debugPrint("Error: \(error.localizedDescription)")
			}
		}
	}
	
	/// Достаёт из массива моделей картинок строки с URL-ам картинок нужного размера
	/// - Parameters:
	///   - sizeType: Тип размера, который нас интересует
	///   - array: Массив моделей картинок
	/// - Returns: Массив строк с url картинок
	func sortImage(by sizeType: String, from array: [ApiImage]) -> [String] {
		var imageLinks: [String] = []
		
		for model in array {
			for size in model.sizes {
				if size.type == sizeType {
					imageLinks.append(size.url)
				}
			}
		}
		return imageLinks
	}
}
