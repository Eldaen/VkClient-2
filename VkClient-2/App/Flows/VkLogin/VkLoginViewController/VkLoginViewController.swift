//
//  VkLoginViewController.swift
//  VkClient-2
//
//  Created by Денис Сизов on 26.04.2022.
//

import UIKit
import WebKit

// MARK: - VkLoginViewController
final class VkLoginViewController: UIViewController {
	
	// MARK: - Properties
	
	/// Обработчик исходящих событий
	var output: VkLoginViewOutputProtocol?
	
	/// UIView
	var vkLoginView: VkLoginView {
		return self.view as! VkLoginView
	}
	
	// MARK: - LifeCycle
	
	override func loadView() {
		super.loadView()
		self.view = VkLoginView()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupWebView()
		setupController()
	}
}

// MARK: - Extension WKNavigationDelegate
extension VkLoginViewController: WKNavigationDelegate {
	
	/// Перехватывает ответы сервера при переходе, можно отменить при необходимости.
	func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse,
				 decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
		
		// проверяем, что ответ существует и путь не пустой
		guard let url = navigationResponse.response.url,
			  url.path == "/blank.html",
			  let fragment = url.fragment
		else {
			decisionHandler(.allow)
			return
		}
		
		let params = fragment
			.components(separatedBy: "&")
			.map { $0.components(separatedBy: "=") }
			.reduce([String: String]()) { result, param in
				var dict = result
				let key = param[0]
				let value = param[1]
				dict[key] = value
				return dict
			}
		
		// Сохраняем данные авторизации, если она успешна и всё нужное есть
		if let token = params["access_token"], let userId = params["user_id"], let id = Int(userId)
		{
			SessionManager.instance.loginUser(with: token, userId: id)
			//			appModeManager?.setDemoMode(false, nextController: nextController)
			output?.authorize()
		}
		decisionHandler(.cancel)
	}
}

// MARK: - VkLoginViewInputProtocol
extension VkLoginViewController: VkLoginViewInputProtocol {
	
}

// MARK: - Private
private extension VkLoginViewController {
	
	/// Настраивает WebView
	func setupWebView() {
		self.vkLoginView.webView.navigationDelegate = self
	}
	
	/// Настраивает контроллер
	func setupController() {
		navigationController?.isNavigationBarHidden = true
		output?.setupWKView(with: vkLoginView)
	}
}
