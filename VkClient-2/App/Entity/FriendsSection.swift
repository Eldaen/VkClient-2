//
//  FriendsSection.swift
//  VkClient-2
//
//  Created by Денис Сизов on 23.05.2022.
//

/// Секция друзей, имя которых начинается на одинаковую буквы
struct FriendsSection: Comparable {
	var key: Character
	var data: [UserModel]
	
	static func < (lhs: FriendsSection, rhs: FriendsSection) -> Bool {
		return lhs.key < rhs.key
	}
	
	static func == (lhs: FriendsSection, rhs: FriendsSection) -> Bool {
		return lhs.key == rhs.key
	}
}
