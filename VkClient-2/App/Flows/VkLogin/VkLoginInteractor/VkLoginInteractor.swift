//
//  VkLoginInteractor.swift
//  VkClient-2
//
//  Created by Денис Сизов on 26.04.2022.
//

import Foundation

// MARK: - VkLoginInteractor
final class VkLoginInteractor {
	var service: VkLoginService?
}

// MARK: - VkLoginInteractorInputProtocol
extension VkLoginInteractor: VkLoginInteractorInputProtocol {
	func loadScreen(with view: VkLoginView) {
		service?.loadView { request in
			view.webView.load(request)
		}
	}
}
