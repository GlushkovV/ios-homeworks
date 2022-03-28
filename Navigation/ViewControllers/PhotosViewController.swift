//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Vitaly Glushkov on 28.03.2022.
//

import UIKit

final class PhotosViewController: UIViewController {
    
    private enum Constants {
        static let itemCount: CGFloat = 3
    }
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        return layout
    } ()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "PhotosCollectionViewCell")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCollectionCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    } ()
    
    private var collectionDataSource: [CollectionViewModel] = [
        CollectionViewModel(image: "1"),
        CollectionViewModel(image: "2"),
        CollectionViewModel(image: "3"),
        CollectionViewModel(image: "4"),
        CollectionViewModel(image: "5"),
        CollectionViewModel(image: "6"),
        CollectionViewModel(image: "7"),
        CollectionViewModel(image: "8"),
        CollectionViewModel(image: "9"),
        CollectionViewModel(image: "10"),
        CollectionViewModel(image: "11"),
        CollectionViewModel(image: "12"),
        CollectionViewModel(image: "13"),
        CollectionViewModel(image: "14"),
        CollectionViewModel(image: "15"),
        CollectionViewModel(image: "16"),
        CollectionViewModel(image: "17"),
        CollectionViewModel(image: "18"),
        CollectionViewModel(image: "19"),
        CollectionViewModel(image: "20"),
        CollectionViewModel(image: "21"),
        CollectionViewModel(image: "22"),
        CollectionViewModel(image: "23"),
        CollectionViewModel(image: "24"),
        CollectionViewModel(image: "25"),
        CollectionViewModel(image: "26"),
        CollectionViewModel(image: "27"),
        CollectionViewModel(image: "28"),
        CollectionViewModel(image: "29"),
        CollectionViewModel(image: "30")
    ]
    
    let detailPhotoView = DetailPhotoView ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.title = "Фотографии"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setupView() {
        detailPhotoView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self.collectionView)
        view.addSubview(detailPhotoView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            detailPhotoView.topAnchor.constraint(equalTo: view.topAnchor),
            detailPhotoView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            detailPhotoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailPhotoView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func itemSize(for width: CGFloat, with spacing: CGFloat) -> CGSize {
        let neededWidth = width - 4 * spacing
        let itemWidth = floor(neededWidth / Constants.itemCount)
        return CGSize(width: itemWidth, height: itemWidth)
    }

}

extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.collectionDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as? PhotosCollectionViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCollectionCell", for: indexPath)
            return cell
        }
        cell.backgroundColor = .systemGray6
        let photos = collectionDataSource[indexPath.row]
        cell.photoGalleryImages.image = UIImage(named: photos.image)
        cell.photoGalleryImages.contentMode = .scaleAspectFill
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt: IndexPath) -> CGSize {
        let spacing = ( collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing
        return self.itemSize(for: collectionView.frame.width, with: spacing ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5) { [self] in
            detailPhotoView.photoView.image = UIImage(named: collectionDataSource[indexPath.row].image)
            self.detailPhotoView.alpha = 1
        }
        
    }
    
}
