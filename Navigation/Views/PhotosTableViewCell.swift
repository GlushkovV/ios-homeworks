//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Vitaly Glushkov on 28.03.2022.
//

import UIKit

final class PhotosTableViewCell: UITableViewCell {
    
    private enum Constants {
        static let itemCount: CGFloat = 4
    }
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        return layout
    } ()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "PhotosCollectionViewCell")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.clipsToBounds = true
        return collectionView
    } ()
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    
    private lazy var collectionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.text = "Фотографии"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    private lazy var arrowImageView: UIImageView = {
        /* let arrow = UIImage(systemName: "arrow.right")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        let imageView = UIImageView()
        imageView.image = arrow */
        let imageView = UIImageView(image: UIImage(systemName: "arrow.right")?.withTintColor(.black, renderingMode: .alwaysOriginal))
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()
    
    private let collectionViewWidth = (UIScreen.main.bounds.width - 48) / Constants.itemCount
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(backView)
        backView.addSubview(collectionLabel)
        backView.addSubview(arrowImageView)
        backView.addSubview(collectionView)
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionLabel.topAnchor.constraint(equalTo: backView.topAnchor, constant: 12.0),
            collectionLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 12.0),
            arrowImageView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -12.0),
            arrowImageView.centerYAnchor.constraint(equalTo: collectionLabel.centerYAnchor),
            arrowImageView.heightAnchor.constraint(equalTo: collectionLabel.heightAnchor),
            arrowImageView.widthAnchor.constraint(equalTo: arrowImageView.heightAnchor, multiplier: 1.0),
            collectionView.topAnchor.constraint(equalTo: collectionLabel.bottomAnchor, constant: 12.0),
            collectionView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -12.0),
            collectionView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 12.0),
            collectionView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -12.0),
            collectionView.heightAnchor.constraint(equalToConstant: collectionViewWidth)
        ])
    }
    
    private func itemSize(for width: CGFloat, with spacing: CGFloat) -> CGSize {
        let neededWidth = width - 3 * spacing
        let itemWidth = floor(neededWidth / Constants.itemCount)
        return CGSize(width: itemWidth, height: itemWidth)
    }
}

extension PhotosTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
       
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as? PhotosCollectionViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
            return cell
        }
        cell.backgroundColor = .systemBackground
        cell.photoGalleryImages.image = UIImage(named: String(indexPath.row + 1))
        cell.photoGalleryImages.contentMode = .scaleAspectFill
        cell.photoGalleryImages.layer.cornerRadius = 6
        cell.photoGalleryImages.isUserInteractionEnabled = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
       
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt: IndexPath) -> CGSize {
        let spacing = ( collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing
        return self.itemSize(for: collectionView.frame.width, with: spacing ?? 0)
    }

}

    
    /*
     
    final class PhotosTableViewCell: UITableViewCell {
     
    private lazy var backView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        return view
    } ()
    
    private lazy var collectionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.text = "Фотографии"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    private lazy var arrowImageView: UIImageView = {
        /* let arrow = UIImage(systemName: "arrow.right")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        let imageView = UIImageView()
        imageView.image = arrow */
        let imageView = UIImageView(image: UIImage(systemName: "arrow.right")?.withTintColor(.black, renderingMode: .alwaysOriginal))
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()
    
    private lazy var photosStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    } ()

    private lazy var firstImageView: UIImageView = {
        return setupImageView(img: "1")
    }()
    
    private lazy var secondImageView: UIImageView = {
        return setupImageView(img: "2")
    }()
    
    private lazy var thirdImageView: UIImageView = {
        return setupImageView(img: "3")
    }()
    
    private lazy var fourImageView: UIImageView = {
        return setupImageView(img: "4")
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupImageView (img: String) -> UIImageView {
        /* let image = UIImage(named: "img")
        let imageCollectionView = UIImageView()
        imageCollectionView.image = image */
        let imageCollectionView = UIImageView(image: UIImage(named: img))
        imageCollectionView.clipsToBounds = true
        imageCollectionView.contentMode = .scaleAspectFill
        imageCollectionView.layer.cornerRadius = 6
        imageCollectionView.translatesAutoresizingMaskIntoConstraints = false
        return imageCollectionView
    }
    
    private func setupView() {
        contentView.addSubview(backView)
        backView.addSubview(collectionLabel)
        backView.addSubview(arrowImageView)
        backView.addSubview(photosStackView)
        photosStackView.addArrangedSubview(firstImageView)
        photosStackView.addArrangedSubview(secondImageView)
        photosStackView.addArrangedSubview(thirdImageView)
        photosStackView.addArrangedSubview(fourImageView)
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionLabel.topAnchor.constraint(equalTo: backView.topAnchor, constant: 12.0),
            collectionLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 12.0),
            arrowImageView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -12.0),
            arrowImageView.centerYAnchor.constraint(equalTo: collectionLabel.centerYAnchor),
            arrowImageView.heightAnchor.constraint(equalTo: collectionLabel.heightAnchor),
            arrowImageView.widthAnchor.constraint(equalTo: arrowImageView.heightAnchor, multiplier: 1.0),
            photosStackView.topAnchor.constraint(equalTo: collectionLabel.bottomAnchor, constant: 12.0),
            photosStackView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -12.0),
            photosStackView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 12.0),
            photosStackView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -12.0),
            firstImageView.heightAnchor.constraint(equalTo: firstImageView.widthAnchor, multiplier: 1.0)
        ])
    }
    
}
     */
