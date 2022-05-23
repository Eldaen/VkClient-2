//
//  FriendsListInteractor.swift
//  VkClient-2
//
//  Created by Денис Сизов on 23.05.2022.
//

import UIKit.UIImage

// MARK: - FriendsListInteractor
final class FriendsListInteractor {
	
	// MARK: - Properties
	
	/// Cсылка на презентер
	weak var output: FriendsListInteractorOutputProtocol?
	
	/// Cервис по работе с группами
	private var friendsLoader: UserLoader
	
	// MARK: - Init
	
	init(friendsService: UserLoader) {
		self.friendsLoader = friendsService
	}
}

// MARK: - FriendsListInteractorInputProtocol
extension FriendsListInteractor: FriendsListInteractorInputProtocol {
	func fetchFriends(_ completion: @escaping (Result<[FriendsSection], Error>) -> Void) {
		friendsLoader.loadFriends { result in
			switch result {
			case .success(let friends):
				completion(.success(friends))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
	
	func loadImage(_ url: String, completion: @escaping (UIImage) -> Void) {
		friendsLoader.loadImage(url: url) { image in
			completion(image)
		}
	}
	
	func search(for query: String, in friends: [FriendsSection], completion: @escaping ([FriendsSection]) -> Void) {
		var result = [FriendsSection]()
		
		if query == "" {
			result = friends
			completion(result)
		} else {
			DispatchQueue.global().async {
				for section in friends { // сначала перебираем массив секций с друзьями
					for (_, friend) in section.data.enumerated() { // потом перебираем массивы друзей в секциях
						if friend.name.lowercased().contains(query.lowercased()) { // Ищем в имени нужный текст, оба текста сравниваем в нижнем регистре
							var searchedSection = section
							
							// Если фильтр пустой, то можно сразу добавлять
							if result.isEmpty {
								searchedSection.data = [friend]
								result.append(searchedSection)
							} else {
								
								// Если в массиве секций уже есть секция с таким ключом, то нужно к имеющемуся массиву друзей добавить друга
								var found = false
								for (sectionIndex, filteredSection) in result.enumerated() {
									if filteredSection.key == section.key {
										result[sectionIndex].data.append(friend)
										found = true
										break
									}
								}
								
								// Если такого ключа ещё нет, то создаём новый массив с нашим найденным другом
								if !found {
									searchedSection.data = [friend]
									result.append(searchedSection)
								}
							}
						}
					}
				}
			}
		}
		DispatchQueue.main.async {
			completion(result)
		}
	}
}
