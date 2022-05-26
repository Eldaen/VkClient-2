//
//  VkLoginView.swift
//  VkClient-2
//
//  Created by Денис Сизов on 05.05.2022.
//

import WebKit

// MARK: - VkLoginView
final class VkLoginView: UIView {
	
	/// webView
	private(set) lazy var webView: WKWebView = {
		let webConfiguration = WKWebViewConfiguration()
		let view = WKWebView(frame: .zero, configuration: webConfiguration)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	/// Кнопка перехода в демо режим
	private let demoButton: UIButton = {
		var configuration = UIButton.Configuration.filled()
		configuration.title = "Demo режим"
		configuration.titlePadding = 10
		configuration.titleAlignment = .center
		configuration.baseBackgroundColor = .orange
		let button = UIButton(configuration: configuration, primaryAction: nil)
		
		button.setTitleColor(.black, for: .normal)
		button.layer.cornerRadius = 8
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	/// Обработчик нажатия на кнопку demo mode
	weak var demoModeDelegate: DemoModeDelegate?
	
	// MARK: - Init
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.setupWebView()
		self.setupDemoButton()
		self.setupConstraints()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	// MARK: - Methods
	
	func setupDemoButton() {
		self.addSubview(demoButton)
		// TODO: Добавить таргет и работоспособность этой кнопке
	}
}

// MARK: - Private
private extension VkLoginView {
	
	func setupWebView() {
		self.addSubview(webView)
		demoButton.addTarget(self, action: #selector(demoOn), for: .touchUpInside)
	}
	
	func setupConstraints() {
		NSLayoutConstraint.activate([
			webView.topAnchor.constraint(equalTo: self.topAnchor),
			webView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			webView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			webView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
			demoButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40),
			demoButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
		])
	}
	
	@objc func demoOn() {
		demoModeDelegate?.demoOn()
	}
}
