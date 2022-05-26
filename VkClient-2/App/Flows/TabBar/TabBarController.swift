//
//  TabBarController.swift
//  VkClient-2
//
//  Created by Денис Сизов on 05.05.2022.
//

import UIKit

// MARK: - TabBarController
final class TabBarController: UITabBarController {

	// MARK: - Properties
	
	/// Флаг демо режима
	private var isDemoModeEnabled: Bool
	
	weak var restartDelegate: RestartDelegate?
	
	// MARK: - Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureTabBar()
		configureNavigationControllers()
	}
	
	// MARK: - Init
	
	init(isDemoModeEnabled: Bool, restartDelegate: RestartDelegate?) {
		self.isDemoModeEnabled = isDemoModeEnabled
		self.restartDelegate = restartDelegate
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: - Private methods
private extension TabBarController {
	func configureTabBar() {
		self.tabBar.tintColor = .black
		self.tabBar.barTintColor = .white
		self.tabBar.unselectedItemTintColor = .gray
		self.tabBar.backgroundColor = .white
	}
	
	func configureNavigationControllers() {
		let myGroupsController = isDemoModeEnabled ? DemoMyGroupsBuilder.build() : MyGroupsBuilder.build()
		let friendsListController = isDemoModeEnabled ? DemoFriendsListBuilder.build() : FriendsListBuilder.build()
		let newsController = isDemoModeEnabled ? DemoNewsBuilder.build() : NewsBuilder.build()
		
		[myGroupsController, friendsListController, newsController].forEach { $0.restartDelegate = restartDelegate }
		
		let myGroups = createNavController(
			for: myGroupsController,
			title: "Мои группы",
			image: UIImage(systemName: "person.3")!
		)
		
		let friends = createNavController(
			for: friendsListController,
			title: "Друзья",
			image: UIImage(systemName: "person")!
		)
		
		let news = createNavController(
			for: newsController,
			title: "Новости",
			image: UIImage(systemName: "newspaper")!
		)
		
		self.viewControllers = [myGroups, friends, news]
	}
	
	func createNavController(
		for rootViewController: UIViewController,
		title: String,
		image: UIImage
	) -> UIViewController {
		let navController = UINavigationController(rootViewController: rootViewController)
		navController.tabBarItem.title = title
		navController.tabBarItem.image = image
		rootViewController.navigationItem.title = title
		navController.navigationBar.tintColor = .black
		return navController
	}
}
