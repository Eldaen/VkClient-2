//
//  ImageCacheManager.swift
//  VkClient-2
//
//  Created by Денис Сизов on 20.05.2022.
//

import UIKit
import CryptoKit

// MARK: - ImageCacheInput protocol
/// Протокол для класса, который будет кэшировать изображения по URL
protocol ImageCacheInput: AnyObject {
	
	/// Возвращает изображение по URL
	/// - Parameter url: URL картинки
	/// - Returns: Возвращает картинку или nil
	func getImage(for url: URL) -> UIImage?
	
	/// Cохраняет изображение по URL
	/// - Parameters:
	///   - image: Картинка, которую нужно сохранить
	///   - url: URL картинки
	func saveImage(_ image: UIImage, for url: URL)
	
	/// Удаляет изображение из кэша
	/// - Parameter url: URL картинки
	func deleteImage(for url: URL)
	
	/// Чистит кэш
	func сlearCache()
	
	//Сабскрипт доступа к кэшу
	subscript(_ url: URL) -> UIImage? { get set }
}

// MARK: - ImageCacheService
/// Класс для кэширования изображений после загрузки
final class ImageCacheManager {
	
	// MARK: - Properties
	
	/// Объект NSCache для хранения изображений, в стандартных настройках будет хранить до 40 картинок
	private lazy var imageCache: NSCache<AnyObject, AnyObject> = {
		let cache = NSCache<AnyObject, AnyObject>()
		cache.countLimit = countLimit
		return cache
	}()
	
	/// Максимальное кол-во хранимых изображений, в стандартных настройках - 40
	private let countLimit: Int
	
	/// Время жизни картинок в кеше
	private let expiryTime: TimeInterval
	
	/// Имя папки для сохранения картинок
	private let folderName = "Images"
	
	// MARK: - Init
	
	init(countLimit: Int = 40, expiryTime: TimeInterval = 60 * 60) {
		self.countLimit = countLimit
		self.expiryTime = expiryTime
		
		let deletionBlock = {
			DispatchQueue.global(qos: .background).async { [weak self] in
				self?.deleteExpired()
			}
		}
		deletionBlock()
		
		let timer = Timer(timeInterval: expiryTime, repeats: true) { _ in
			deletionBlock()
		}
		RunLoop.current.add(timer, forMode: .common)
	}
}

//MARK: - ImageCache
extension ImageCacheManager: ImageCacheInput {
	
	func getImage(for url: URL) -> UIImage? {
		if let image = imageCache.object(forKey: url as AnyObject) as? UIImage {
			return image
		} else if let image = loadImageFromDiskWith(imageName: url.absoluteString){
			return image
		} else {
			return nil
		}
	}
	
	func saveImage(_ image: UIImage, for url: URL) {
		imageCache.setObject(image as AnyObject, forKey: url as AnyObject)
		
		DispatchQueue.global(qos: .background).async { [weak self] in
			self?.saveImage(imageName: url.absoluteString, image: image)
		}
	}
	
	func deleteImage(for url: URL) {
		imageCache.removeObject(forKey: url as AnyObject)
	}
	
	func сlearCache() {
		imageCache.removeAllObjects()
	}
	
	subscript(_ url: URL) -> UIImage? {
		get {
			return getImage(for: url)
		}
		set {
			guard let image = newValue else { return }
			return saveImage(image, for: url)
		}
	}
}

// MARK: - Private methods
private extension ImageCacheManager {
	
	/// Загружает и возвращаетк артинку из файловой системы по имени, если нашлась
	private func loadImageFromDiskWith(imageName: String) -> UIImage? {
		
		let imageName = SHA256.hash(data: Data(imageName.utf8)).description
		let cacheDirectory = FileManager.SearchPathDirectory.cachesDirectory
		
		let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
		let paths = NSSearchPathForDirectoriesInDomains(cacheDirectory, userDomainMask, true)
		
		if let dirPath = paths.first {
			let cacheFolder = URL(fileURLWithPath: dirPath).appendingPathComponent(folderName, isDirectory: true)
			let imageUrl = cacheFolder.appendingPathComponent(imageName)
			
			if checkExpiry(for: imageUrl) {
				return nil
			}
			
			let image = UIImage(contentsOfFile: imageUrl.path)
			return image
		}
		
		return nil
	}
	
	/// Сохраняет картинку в файловую систему и удаляет текущую, если она есть с таким названием
	private func saveImage(imageName: String, image: UIImage) {
		guard
			let cachesUrl = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first,
			let cachesDirectory = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first,
			let docURL = URL(string: cachesDirectory)
		else {
			return
		}
		
		let dataPath = docURL.appendingPathComponent(folderName)
		if !FileManager.default.fileExists(atPath: dataPath.absoluteString) {
			do {
				try FileManager.default.createDirectory(atPath: dataPath.absoluteString, withIntermediateDirectories: true, attributes: nil)
			} catch {
				print(error.localizedDescription);
			}
		}
		
		let fileName = SHA256.hash(data: Data(imageName.utf8)).description
		let imageFolder = cachesUrl.appendingPathComponent(folderName, isDirectory: true)
		let fileURL = imageFolder.appendingPathComponent(fileName)
		
		guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
			return
		}
		
		//Если файл есть, то удаляем
		if FileManager.default.fileExists(atPath: fileURL.path) {
			try? FileManager.default.removeItem(atPath: fileURL.path)
		}
		
		// Пробуем записать, если не получилось, то ничего страшного
		do {
			try data.write(to: fileURL)
		} catch {
			print(error)
		}
	}
	
	/// Удаляет устаревшие файлы
	private func deleteExpired() {
		guard
			let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
			return
		}
		let imagesDirectory = cachesDirectory.appendingPathComponent(folderName, isDirectory: true)
		
		do {
			let directoryContents = try FileManager.default.contentsOfDirectory(
				at: imagesDirectory,
				includingPropertiesForKeys: nil
			)
			
			for imageUrl in directoryContents {
				if checkExpiry(for: imageUrl) {
					try FileManager.default.removeItem(at: imageUrl)
				}
			}
		} catch {
			print(error)
		}
	}
	
	/// Проверяет дату модификации файла по URL и сравнивает с expiryTime
	/// - Returns: True если файл просрочен и False если с файлом всё хорошо
	private func checkExpiry(for imageUrl: URL) -> Bool {
		guard
			let info = try? FileManager.default.attributesOfItem(atPath: imageUrl.path),
			let modificationDate = info[FileAttributeKey.modificationDate] as? Date
		else {
			return true
		}
		
		let lifeTime = Date().timeIntervalSince(modificationDate)
		
		if lifeTime >= expiryTime {
			return true
		} else {
			return false
		}
	}
}
