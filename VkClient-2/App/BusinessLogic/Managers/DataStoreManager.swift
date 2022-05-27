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
	
	/// Загружает все группы
	/// - Returns: Массив групп, который был в базе данных или nil
	func getGroups() -> [GroupModel]?
	
	/// Удаляет все группы из базы данных
	func deleteAllGroups()
	
	/// Удаляет из базы группу с указанным ID
	/// - Parameter id: ID группы
	func deleteGroup(with id: Int)
}

// MARK: - DataStoreManager
final class DataStoreManager: DataManagerInput {
	
	// MARK: - Core Data stack
	
	lazy var persistentContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "VkClient_2")
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
	
	func getGroups() -> [GroupModel]? {
		let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CoreDataGroup")
		if let groups = try? viewContext.fetch(fetchRequest) as? [CoreDataGroup],
		   !groups.isEmpty {
			var result = [GroupModel]()
			for group in groups {
				let group = GroupModel(
					name: group.name ?? "",
					image: group.image ?? "",
					id: Int(group.id),
					isMember: Int(group.isMember)
				)
				result.append(group)
			}
			return result
		} else {
			return nil
		}
	}
	
	func deleteAllGroups() {
		let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CoreDataGroup")
		if let groups = try? viewContext.fetch(fetchRequest) as? [CoreDataGroup] {
			for group in groups {
				viewContext.delete(group)
			}
		}
	}
	
	func deleteGroup(with id: Int) {
		let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CoreDataGroup")
		fetchRequest.predicate = NSPredicate(format: "id = %@", id)
		
		if let group = try? viewContext.fetch(fetchRequest) as? [CoreDataGroup] {
			if let firstGroup = group.first {
				viewContext.delete(firstGroup)
			}
		}
	}
}
