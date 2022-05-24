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
	
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FriendsProfileViewController: UICollectionViewDelegateFlowLayout {
	
}

// MARK: - FriendsProfileViewInputProtocol
extension FriendsProfileViewController: FriendsProfileViewInputProtocol {
	func reloadСollectionView() {
		
	}
	
	func startLoadAnimation() {
		
	}
	
	func stopLoadAnimation() {
		
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
