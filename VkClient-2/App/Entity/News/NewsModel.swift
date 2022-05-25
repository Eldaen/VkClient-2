//
//  NewsModel.swift
//  VkClient-2
//
//  Created by Денис Сизов on 25.05.2022.
//

/// Модель новости из ответа АПИ
struct NewsModel: Codable {
	let sourceID, date: Int
	let postId: Int?
	let postType, text: String?
	let likes: LikesModel?
	let comments: CommentsModel?
	let reposts: RepostsModel?
	let views: Views?
	let type: String
	let photos: PhotosResponseModel?
	let attachments: [AttachmentsResponseModel]?
	var shortText: String? {
		get {
			guard let text = text else { return nil }
			guard text.count >= 200 else { return nil }
			
			let shortText = text.prefix(200)
			return String(shortText + "...")
		}
	}

	enum CodingKeys: String, CodingKey {
		case sourceID = "source_id"
		case date
		case postType = "post_type"
		case postId = "post_id"
		case text
		case attachments
		case likes
		case comments
		case reposts
		case views
		case type
		case photos
	}
}

/// Модель для получения кол-ва просмотров
struct Views: Codable {
	let count: Int
}

/// Модель для получения кол-ва комментов
struct CommentsModel: Codable {
	let count: Int
}

/// Модель для получения кол-ва репостов
struct RepostsModel: Codable {
	let count: Int
}
