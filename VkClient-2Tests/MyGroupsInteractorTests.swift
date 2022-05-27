//
//  MyGroupsInteractorTests.swift
//  VkClient-2Tests
//
//  Created by Денис Сизов on 27.05.2022.
//

import XCTest
@testable import VkClient_2

class MyGroupsInteractorTests: XCTestCase {
	
	var interactor: MyGroupsInteractor!

    override func setUpWithError() throws {
		interactor = MyGroupsInteractor(groupsService: DemoGroupsService(
			networkManager: NetworkManager(),
			cache: ImageCacheManager()
		))
    }

    override func tearDownWithError() throws {
        interactor = nil
    }

	/// Проверяем факт загрузки групп после запроса
	func testFetchGroups() throws {
		
		//Given
		let validatorExpectation = expectation(description: #function)
		var groups = [GroupModel]()
		
		//When
		interactor.fetchGroups { result in
			switch result {
			case .success(let freshGroups):
				groups = freshGroups
				validatorExpectation.fulfill()
			case .failure:
				XCTFail()
			}
		}
		
		//Then
		waitForExpectations(timeout: 1.0) { error in
			if error != nil {
				XCTFail()
			}
			
			XCTAssertFalse(groups.isEmpty)
		}
	}
	
	/// Если искать пустую строчку, то покажет все группы, передадим 3 группы и проверим кол-во найденных
	func testSearchWithEmptyQuery() throws {
		
		//Given
		let group = GroupModel(name: "", image: "", id: 0, isMember: 1)
		let groups = [group, group, group]
		var filteredGroups = [GroupModel]()
		let validatorExpectation = expectation(description: #function)
		
		//When
		interactor.search(for: "", in: groups, completion: { groups in
			filteredGroups = groups
			validatorExpectation.fulfill()
		})
		
		//Then
		waitForExpectations(timeout: 1.0) { error in
			if error != nil {
				XCTFail()
			}
			
			XCTAssertEqual(groups, filteredGroups)
			XCTAssertEqual(filteredGroups.count, 3)
		}
	}
	
	/// Тест поиска с корректными данными
	func testSearchWithValues() throws {
		
		//Given
		let group1 = GroupModel(name: "Программисты", image: "", id: 0, isMember: 0)
		let group2 = GroupModel(name: "Дизайнеры", image: "", id: 0, isMember: 0)
		let group3 = GroupModel(name: "Майнеры", image: "", id: 0, isMember: 0)
		
		let queryString = "еры"
		
		let groups = [group1, group2, group3]
		var filteredGroups = [GroupModel]()
		let validatorExpectation = expectation(description: #function)
		
		//When
		interactor.search(for: queryString, in: groups) { result in
			filteredGroups = result
			validatorExpectation.fulfill()
		}
		
		//Then
		waitForExpectations(timeout: 1.0) { error in
			if error != nil {
				XCTFail()
			}
			
			XCTAssertEqual(filteredGroups.count, 2)
			XCTAssertEqual(filteredGroups, [group2, group3])
		}
	}
}
