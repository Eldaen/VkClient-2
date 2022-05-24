//
//  FriendsProfileViewController.swift
//  VkClient-2
//
//  Created by Денис Сизов on 23.05.2022.
//

import UIKit

// MARK: - FriendsProfileViewController
final class FriendsProfileViewController: UIViewController {
	
	// MARK: - Properties
	
	/// Количество колонок
	private let cellsCount: CGFloat = 3.0
	
	/// Отступы между фото
	private let cellsOffset: CGFloat = 10.0
	
	var storedImages = [String]() {
		didSet {
			friendsProfileView.photosCount.text = String(storedImages.count)
		}
	}
	
	/// Обработчик исходящих событий
	var output: FriendsProfileViewOutputProtocol?
	
	/// UIView
	var friendsProfileView: FriendsProfileView {
		return self.view as! FriendsProfileView
	}
	
	// MARK: - LifeCycle
	
	override func loadView() {
		super.loadView()
		self.view = FriendsProfileView()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureNavigation()
		setupCollectionView()
		startLoadAnimation()
		setStaticData()
		loadProfilePhoto()
		output?.loadProfile()
	}
}

// MARK: - UICollectionViewDataSource
extension FriendsProfileViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		storedImages.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell: FriendsProfileCell = friendsProfileView.collectionView.dequeueReusableCell(for: indexPath)
		let imageLink = storedImages[indexPath.row]
		
		output?.loadImage(imageLink) { image in
			cell.configure(with: image)
		}
		return cell
	}
}

// MARK: - UICollectionViewDelegate
extension FriendsProfileViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		output?.openGalleryFor(photo: indexPath.item)
	}
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FriendsProfileViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

		let frameCV = collectionView.frame

		let cellWidth = frameCV.width / cellsCount
		let cellHeight = cellWidth

		// считаем размеры ячеек с учётом отступов, чтобы всё ровненько было
		let spacing = ( cellsCount + 1 ) * cellsOffset / cellsCount
		return CGSize(width: cellWidth - spacing, height: cellHeight - ( cellsOffset * 2) )
	}
}

// MARK: - FriendsProfileViewInputProtocol
extension FriendsProfileViewController: FriendsProfileViewInputProtocol {
	func reloadСollectionView() {
		friendsProfileView.collectionView.reloadData()
	}
	
	func startLoadAnimation() {
		friendsProfileView.spinner.startAnimating()
	}
	
	func stopLoadAnimation() {
		friendsProfileView.spinner.stopAnimating()
	}
	
	func showProfileLoadingErrorText(_ text: String) {
		
	}
}

// MARK: - FriendsProfileViewController
private extension FriendsProfileViewController {
	
	// Конфигурирует Нав Бар
	func configureNavigation() {
		self.title = "Профиль"
	}
	
	func setupCollectionView() {
		friendsProfileView.collectionView.register(cell: FriendsProfileCell.self)
		friendsProfileView.collectionView.dataSource = self
		friendsProfileView.collectionView.delegate = self
	}
	
	func setStaticData() {
		friendsProfileView.photosCount.text = String(storedImages.count)
		friendsProfileView.friendName.text = output?.friend.name
	}
	
	func loadProfilePhoto() {
		output?.loadImage(output?.friend.image ?? "") { [weak self] image in
			self?.friendsProfileView.userAvatar.image = image
		}
	}
}
