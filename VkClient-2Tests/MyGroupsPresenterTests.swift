//
//  MyGroupsPresenterTests.swift
//  VkClient-2Tests
//
//  Created by Денис Сизов on 27.05.2022.
//

import XCTest
@testable import VkClient_2

class MyGroupsPresenterTests: XCTestCase {
	
	var networkManager: NetworkManager!
	var cache: ImageCacheManager!
	var service: DemoGroupsService!
	var viewController: MyGroupsViewController!
	var interactor: MyGroupsInteractor!
	var router: MyGroupsRouter!
	var presenter: MyGroupsPresenter!

	override func setUpWithError() throws {
		networkManager = NetworkManager()
		cache = ImageCacheManager()
		service = DemoGroupsService(networkManager: networkManager, cache: cache)
		viewController = MyGroupsViewController()
		interactor = MyGroupsInteractor(groupsService: service)
		router = MyGroupsRouter()
		presenter = MyGroupsPresenter(router: router, interactor: interactor, view: viewController)
		
		viewController.output = presenter
		presenter.interactor = interactor
		presenter.view = viewController
		router.viewController = viewController
		interactor.output = presenter
	}

	override func tearDownWithError() throws {
		networkManager = nil
		service = nil
		viewController = nil
		interactor = nil
		router = nil
		presenter = nil
	}

	/// Тестирует загрузку групп
	func testFetchGroups() throws {
		
		//Given
		let validatorExpectation = expectation(description: #function)
		
		//When
		presenter.fetchGroups ()
		DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
			validatorExpectation.fulfill()
		}
		
		//Then
		waitForExpectations(timeout: 1.0) { error in
			if error != nil {
				XCTFail()
			}
			
			XCTAssertFalse(self.viewController.groups.isEmpty)
		}
	}
	
	/// Тестирует поиск с пустым запросом
	func testSearchWithEmptyQuery() {
		//Given
		let validatorExpectation = expectation(description: #function)
		
		//When
		presenter.search("")
		DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
			validatorExpectation.fulfill()
		}
		
		//Then
		waitForExpectations(timeout: 1.0) { error in
			if error != nil {
				XCTFail()
			}
			
			XCTAssertEqual(self.viewController.groups, self.viewController.filteredGroups)
			XCTAssertFalse(self.viewController.filteredGroups.isEmpty)
		}
	}
	
	/// Тестирует поиск с корректным запросом
	func testSearchWithCorrectQuery() {
		//Given
		let validatorExpectation = expectation(description: #function)
		self.presenter.search("бу")
		
		//When
		DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
			self.presenter.search("бу")
			validatorExpectation.fulfill()
		}
		
		DispatchQueue.global().asyncAfter(deadline: .now() + 1.5) {
			validatorExpectation.fulfill()
		}
		
		//Then
		waitForExpectations(timeout: 2.0) { error in
			if error != nil {
				XCTFail()
			}
			
			XCTAssertEqual(self.viewController.filteredGroups.count, 2)
			XCTAssertEqual(self.viewController.filteredGroups[0].name, "Пикабу")
		}
	}
}
