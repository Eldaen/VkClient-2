//
//  DataStoreManager.swift
//  VkClient-2
//
//  Created by Денис Сизов on 27.05.2022.
//

import Foundation
import CoreData

// MARK: - DataManagerInput
/// Протокол менеджера Кор Даты
protocol DataManagerInput: AnyObject {
	
	/// Сохраняет данные групп
	/// - Parameter groups: Массив моделей групп
	func saveGroups(_ groups: [GroupModel])
}

// MARK: - DataStoreManager
final class DataStoreManager: DataManagerInput {
	
	// MARK: - Core Data stack
	
	lazy var persistentContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "CoreData")
		container.loadPersistentStores(completionHandler: { (storeDescription, error) in
			if let error = error as NSError? {
				fatalError("Unresolved error \(error), \(error.userInfo)")
			}
		})
		return container
	}()
	
	lazy var viewContext = persistentContainer.viewContext
	lazy var backgroundContext: NSManagedObjectContext = persistentContainer.newBackgroundContext()
	
	// MARK: - CRUD
	
	func saveContext () {
		let context = persistentContainer.viewContext
		if context.hasChanges {
			do {
				try context.save()
			} catch {
				let nserror = error as NSError
				fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
			}
		}
	}
	
	func saveGroups(_ groups: [GroupModel]) {
		for group in groups {
			let coreDataGroup = CoreDataGroup(context: viewContext)
			coreDataGroup.id = Int32(group.id)
			coreDataGroup.name = group.name
			coreDataGroup.image = group.image
			coreDataGroup.isMember = Int16(group.isMember)
			
			do {
				try viewContext.save()
			} catch let error {
				print(error)
			}
		}
	}
}
