//
//  TabBarController.swift
//  VkClient-2
//
//  Created by Денис Сизов on 05.05.2022.
//

import UIKit

// MARK: - TabBarController
final class TabBarController: UITabBarController {
	
	// MARK: - LifeCycle
	override func viewDidLoad() {
		super.viewDidLoad()
		configureTabBar()
		configureNavigationControllers()
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
	
	private func configureNavigationControllers() {
		let myGroups = createNavController(
			for: MyGroupsBuilder.build(),
			title: "Мои группы",
			image: UIImage(systemName: "person.3")!
		)
		
		let friends = createNavController(
			for: FriendsListBuilder.build(),
			title: "Друзья",
			image: UIImage(systemName: "person")!
		)
		
		let news = createNavController(
			for: NewsBuilder.build(),
			title: "Новости",
			image: UIImage(systemName: "newspaper")!
		)
		
		self.viewControllers = [myGroups, friends, news]
	}
	
	private func createNavController(
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
