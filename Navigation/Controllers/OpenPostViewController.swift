//
//  OpenPostViewController.swift
//  Navigation
//
//  Created by Vitaly Glushkov on 02.04.2022.
//

import UIKit

final class OpenPostViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = .systemBackground
        return scroll
    } ()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        return view
    } ()
    
    private lazy var stackViewPost: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    } ()
    
    private lazy var stackViewLikesViews: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        //stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    } ()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = NSTextAlignment.left
        label.text = dataSource[articleNumber].author
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    private lazy var imageImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: dataSource[articleNumber].image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Sistem", size: 14)
        label.textColor = .systemGray
        label.text = dataSource[articleNumber].description
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    private lazy var likesLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont(name: "Sistem", size: 16)
        label.textColor = .black
        label.text = "Likes: " + String(dataSource[articleNumber].likes + (dataSource[articleNumber].liked ? 1 : 0))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        return label
    } ()

    private lazy var viewsLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont(name: "Sistem", size: 16)
        label.textColor = .black
        label.text = "Views: " + String(dataSource[articleNumber].views)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    private lazy var liked: Bool = {
        return dataSource[articleNumber].liked
    } ()

    private lazy var articleNumber: Int = {
        let article = selectedArticleNumber ?? 0
        return article
    } ()
    
    private let tapGestureRecognizer = UITapGestureRecognizer()
    
    var selectedArticleNumber: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Запись"
        setupView()
        setupGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        //navigationController?.navigationBar.alpha = 0.9
        //navigationController?.tabBarController?.tabBar.alpha = 0.9
    }
    
    private func setupGesture() {
        self.tapGestureRecognizer.addTarget(self, action: #selector(self.tapLiked(_ :)))
        self.likesLabel.addGestureRecognizer(self.tapGestureRecognizer)
    }
    
    @objc func tapLiked(_ gestureRecognizer: UITapGestureRecognizer) {
        guard self.tapGestureRecognizer === gestureRecognizer else { return }
        liked.toggle()
        dataSource[articleNumber].liked = liked
        likesLabel.text = "Likes: \(dataSource[articleNumber].likes + (dataSource[articleNumber].liked ? 1 : 0))"
    }
    
    private func setupView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.addSubview(stackViewLikesViews)
        contentView.addSubview(stackViewPost)
        stackViewPost.addArrangedSubview(authorLabel)
        stackViewPost.addArrangedSubview(imageImageView)
        stackViewPost.addArrangedSubview(descriptionLabel)
        stackViewLikesViews.addArrangedSubview(likesLabel)
        stackViewLikesViews.addArrangedSubview(viewsLabel)
        
        view.backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -36),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            stackViewPost.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackViewPost.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackViewPost.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 6),
            stackViewPost.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -6),
            
            stackViewLikesViews.topAnchor.constraint(equalTo: stackViewPost.bottomAnchor, constant: 6),
            stackViewLikesViews.leadingAnchor.constraint(equalTo: stackViewPost.leadingAnchor),
            stackViewLikesViews.trailingAnchor.constraint(equalTo: stackViewPost.trailingAnchor)
        ])
    }

}
