//
//  Extension+UITableViewCell.swift
//  VkClient-2
//
//  Created by Денис Сизов on 19.05.2022.
//

import UIKit

// MARK: - ReusableView Protocol
protocol ReusableView: AnyObject {
	static var defaultReuseIdentifier: String { get }
}

// MARK: - UITableView register + dequeueReusableCell extension
extension UITableView {
	
	/// Регистрация ячейки
	/// - Parameter registerClass: Тип передаваемой ячейки
	func register<T: UITableViewCell>(registerClass: T.Type) {
		let defaultReuseIdentifier = registerClass.defaultReuseIdentifier
		register(registerClass, forCellReuseIdentifier: defaultReuseIdentifier)
	}
	
	/// Запрашивает и возвращает ячейку нужного типа
	/// - Parameter indexPath: indexPath
	/// - Returns: Ячейка нужного типа
	func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
		guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
			fatalError("Could not dequeue cell with identifier \(T.defaultReuseIdentifier)")
		}
		return cell
	}
}

// MARK: - ReusableView
extension UITableViewCell: ReusableView {
	static var defaultReuseIdentifier: String {
		return String(describing: self)
	}
}
