//
//  BoolResponse.swift
//  VkClient-2
//
//  Created by Денис Сизов on 20.05.2022.
//

/// Ответ, который подразумевает булевый response, но не true/false, а 1/0
struct ApiBoolResponse: Codable {
	var response: Int
}
