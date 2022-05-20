//
//  VkLoginPresenter.swift
//  VkClient-2
//
//  Created by Денис Сизов on 26.04.2022.
//

import Foundation

// MARK: - VkLoginPresenter
final class VkLoginPresenter {
	
	// MARK: - Properties
	
	var router: VkLoginRouterInputProtocol?
	var interactor: VkLoginInteractorInputProtocol?
	weak var view: VkLoginViewInputProtocol?
}

// MARK: - VkLoginViewInputProtocol
extension VkLoginPresenter: VkLoginViewOutputProtocol {
	func authorize() {
		router?.pushRealApp()
	}
	
	func setupWKView(with view: VkLoginView) {
		interactor?.loadScreen(with: view)
	}
}

// MARK: - VkLoginInteractorOutputProtocol
extension VkLoginPresenter: VkLoginInteractorOutputProtocol {
	
}
