//
//  Extension+UICollectionView.swift
//  VkClient-2
//
//  Created by Денис Сизов on 24.05.2022.
//

import UIKit

// MARK: - UICollectionReusableView reuseIdentifier
extension UICollectionReusableView {
	static var reuseIdentifier: String {
		return String(describing: Self.self)
	}
}

// MARK: - UICollectionView register + dequeue
extension UICollectionView {
	
	/// Регистрирует ячейку в коллекции
	/// - Parameter cell: Тип регистрируемой ячейки
	func register<T: UICollectionViewCell>(cell: T.Type) {
		register(cell.self, forCellWithReuseIdentifier: T.reuseIdentifier)
	}
	
	/// Запрашивает и возвращает ячейку нужного типа
	/// - Parameter indexPath: indexPath
	/// - Returns: Ячейка нужного типа
	func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
		guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
			fatalError("Could not dequeue cell with identifier \(T.reuseIdentifier)")
		}
		return cell
	}
}
