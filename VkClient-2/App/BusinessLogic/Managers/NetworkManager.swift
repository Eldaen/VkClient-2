//
//  NetworkService.swift
//  VkClient-2
//
//  Created by Денис Сизов on 20.05.2022.
//

import UIKit

// MARK: - ApiMethods enum
/// Перечисление используемых методов из АПИ Вконтакте
enum ApiMethods: String {
	case friendsGet = "/method/friends.get"
	case usersGet = "/method/users.get"
	case photosGetAll = "/method/photos.getAll"
	case groupsGet = "/method/groups.get"
	case groupsSearch = "/method/groups.search"
	case groupsJoin = "/method/groups.join"
	case groupsLeave = "/method/groups.leave"
	case newsGet = "/method/newsfeed.get"
	case setLike = "/method/likes.add"
	case removeLike = "/method/likes.delete"
}

// MARK: - HttpMethods
/// Возможные http методы
enum HttpMethods: String {
	case get = "GET"
	case post = "POST"
}

// MARK: - NetworkManagerProtocol declaration
/// Класс, управляющий запросами в сеть
protocol NetworkManagerProtocol {
	
	/// Запрашивает данные по заданным параметрам. Возвращает либо результат Generic типа, либо ошибку
	/// - Parameters:
	///   - method: Метод, который нужно вызвать у API
	///   - httpMethod: http метод, get или post
	///   - params: Параметры запроса
	///   - completion: Клоужер с результатом
	func request<T: Decodable>(method: ApiMethods,
							   httpMethod: HttpMethods,
							   params: [String: String],
							   completion: @escaping (Result<T, Error>) -> Void
	)
	
	/// Загружает данные для картинки и возвращает их, если получилось
	/// - Parameters:
	///   - url: URL картинки для загрузки
	///   - completion: Клоужер с Data картинки или ошибкой
	func loadImage(url: URL, completion: @escaping (Result<Data, Error>) -> Void)
}

// MARK: - NetworkManager
/// Класс, управляющий запросами в сеть
final class NetworkManager {
	
	// MARK: - Properties
	
	private let session: URLSession = {
		let config = URLSessionConfiguration.default
		let session = URLSession(configuration: config)
		return session
	}()
	
	/// Декордер JSON, который используем для парсинга ответов
	private let decoder = JSONDecoder()
	
	// Cтандартные данные
	private let scheme = "https"
	private let host = "api.vk.com"
}

// MARK: - NetworkManagerProtocol
extension NetworkManager: NetworkManagerProtocol {
	func request<T: Decodable>(
		method: ApiMethods,
		httpMethod: HttpMethods,
		params: [String: String],
		completion: @escaping (Result<T, Error>) -> Void
	){
		guard let token = SessionManager.instance.token else {
			return
		}
		
		/// Возвращаем разультат через клоужер в основую очередь
		let completionOnMain: (Result<T, Error>) -> Void = { result in
			DispatchQueue.main.async {
				completion(result)
			}
		}
		
		// Конфигурируем URL
		let url = configureUrl(token: token, method: method, httpMethod: httpMethod, params: params)
		
		session.dataTask(with: url) { [weak self] (data, response, error) in
			
			guard let strongSelf = self else { return }
			guard let data = data else { return }
			
			do {
				let decodedData = try strongSelf.decoder.decode(T.self, from: data)
				completionOnMain(.success(decodedData))
			} catch {
				print(error)
				completionOnMain(.failure(error))
			}
			
		}.resume()
	}
	
	func loadImage(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
		
		/// Возвращаем разультат через клоужер в основую очередь
		let completionOnMain: (Result<Data, Error>) -> Void = { result in
			DispatchQueue.main.async {
				completion(result)
			}
		}
		
		session.dataTask(with: url, completionHandler: { (data, response, error) in
			guard let responseData = data, error == nil else {
				if let error = error {
					completionOnMain(.failure(error))
				}
				return
			}
			completionOnMain(.success(responseData))
		}).resume()
	}
}

// MARK: - Private methods
private extension NetworkManager {
	func configureUrl(token: String,
					  method: ApiMethods,
					  httpMethod: HttpMethods,
					  params: [String: String]) -> URL {
	
		
		var queryItems = [URLQueryItem]()
		
		// добавляем общие для всех параметры
		queryItems.append(URLQueryItem(name: "access_token", value: token))
		queryItems.append(URLQueryItem(name: "v", value: "5.131"))
		
		for (param, value) in params {
			queryItems.append(URLQueryItem(name: param, value: value))
		}
		
		var urlComponents = URLComponents()
		urlComponents.scheme = scheme
		urlComponents.host = host
		urlComponents.path = method.rawValue
		urlComponents.queryItems = queryItems
		
		guard let url = urlComponents.url else {
			fatalError("URL is invalid")
		}
		return url
	}
}
