//
//  NewsCollectionCell.swift
//  VkClient-2
//
//  Created by Денис Сизов on 25.05.2022.
//

import UIKit

/// Протокол медиа ячейки для NewsController
protocol NewCollectionCellProtocol {
	
	/// Конфигурирует ячейку NewsTableViewCell
	/// - Parameters:
	///   - model: Модель новости, которую нужно отобразить
	func configure (with model: NewsTableViewCellModelProtocol)
	
	/// Добавляет в collectionView свежезагруженные картинки
	/// - Parameter images: Массив картинок коллекции новости
	func updateCollection(with images: [UIImage])
}

/// Ячейка для отображения новостей пользователя в контроллере NewsController
final class NewsCollectionCell: UITableViewCell, NewCollectionCellProtocol {
	
	// MARK: - Subviews
	
	private let collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collection.translatesAutoresizingMaskIntoConstraints = false
		collection.alwaysBounceVertical = false
		return collection
	}()
	
	// MARK: - Properties
	
	/// Массив картинок для отображения
	private var collection: [UIImage] = []
	
	/// Стандартная высота ячейки коллекции
	private var standard: NSLayoutConstraint?
	
	/// Ячейка коллекции, если картинок нет
	private var empty: NSLayoutConstraint?
	
	/// Констрейнт высоты коллекции
	var collectionHeight: NSLayoutConstraint?
	
	// MARK: - Methods
	
	func configure (with model: NewsTableViewCellModelProtocol) {
		setupCollectionView()
		setupConstraints()
		updateCellData(with: model)
		
		selectionStyle = .none
	}
	
	func updateCollection(with images: [UIImage]) {
		collection = images
		
		let layout = getCollectionLayout(isMultiple: collection.count > 1)
		collectionView.collectionViewLayout = layout
		collectionView.reloadData()
	}
	
	override func prepareForReuse() {
		standard = nil
		empty = nil
		collection = []
	}
}

// MARK: - UICollectionViewDataSource
extension NewsCollectionCell: UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return collection.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell: NewsCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
		
		// находим нужную модель ячейки коллекции в массиве collection и потом в нашу новую ячейку коллекции передаэм готовую картинку
		let collectionCell = collection[indexPath.row]
		cell.configure(with: collectionCell)
		
		return cell
	}
}

// MARK: - UICollectionViewDelegateFlowLayout
extension NewsCollectionCell: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						minimumInteritemSpacingForSectionAt section: Int
	) -> CGFloat {
		return 0
	}
}

// MARK: - Private methods
private extension NewsCollectionCell {
	
	func setupConstraints() {
		NSLayoutConstraint.activate([
			collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
		])
		
		collectionHeight = collectionView.heightAnchor.constraint(equalTo: contentView.heightAnchor)
		collectionHeight?.isActive = true
		
		let top = collectionView.topAnchor.constraint(equalTo: contentView.bottomAnchor)
		top.priority = .init(rawValue: 999)
	}
	
	/// Конфигурируем нашу collectionView и добавляем в основную view
	func setupCollectionView() {
		collectionView.register(cell: NewsCollectionViewCell.self)
		collectionView.backgroundColor = .white
		collectionView.dataSource = self
		collectionView.delegate = self
		
		contentView.addSubview(collectionView)
	}
	
	/// обновляет данные ячейки
	func updateCellData(with model: NewsTableViewCellModelProtocol) {
		collection = model.collection
		self.collectionView.reloadData()
	}
	
	/// Генерирует Сomposition Layout для нашей коллекции
	func getCollectionLayout(isMultiple: Bool) -> UICollectionViewCompositionalLayout {
		
		let image = collection.first ?? UIImage()
		let aspectRatio = image.size.height / ( image.size.width == 0.0 ? 1 : image.size.width )
		
		let itemSize = NSCollectionLayoutSize(
		  widthDimension: .fractionalWidth(1.0),
		  heightDimension: .fractionalHeight(1.0))
		
		let fullPhotoItem = NSCollectionLayoutItem(layoutSize: itemSize)
		
		let groupSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(isMultiple ? 0.95 : 1.0),
		  heightDimension: .fractionalWidth(aspectRatio))
		
		let group = NSCollectionLayoutGroup.horizontal(
		  layoutSize: groupSize,
		  subitem: fullPhotoItem,
		  count: 1)
		group.contentInsets = NSDirectionalEdgeInsets(
		  top: 5,
		  leading: 5,
		  bottom: 5,
		  trailing: 5)
		
		let section = NSCollectionLayoutSection(group: group)
		section.orthogonalScrollingBehavior = .continuous
		
		let layout = UICollectionViewCompositionalLayout(section: section)
		return layout
	}
}
