//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Vitaly Glushkov on 20.03.2022.
//

import UIKit

final class PostTableViewCell: UITableViewCell {
    
    struct ViewModel {
        let author: String
        let image: String
        let description: String
        var likes: Int
        var views: Int
        var liked: Bool
        var articleNumber: Int
    }
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
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
        label.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    private lazy var imageImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.setContentCompressionResistancePriority(UILayoutPriority(100), for: .vertical)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Sistem", size: 14)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    private lazy var likesLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont(name: "Sistem", size: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapLiked))
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled = true
        return label
    } ()

    private lazy var viewsLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont(name: "Sistem", size: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    private lazy var liked: Bool = false
    
    private lazy var likesCount: Int = 0
    
    private lazy var articleNumber: Int = 0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.authorLabel.text = nil
        self.imageImageView.image = nil
        self.descriptionLabel.text = nil
        self.likesLabel.text = nil
        self.viewsLabel.text = nil
    }
    
    private func setupView() {
        contentView.backgroundColor = .white
        contentView.addSubview(backView)
        backView.addSubview(stackViewPost)
        stackViewPost.addArrangedSubview(authorLabel)
        stackViewPost.addArrangedSubview(imageImageView)
        stackViewPost.addArrangedSubview(descriptionLabel)
        stackViewPost.addArrangedSubview(stackViewLikesViews)
        stackViewLikesViews.addArrangedSubview(likesLabel)
        stackViewLikesViews.addArrangedSubview(viewsLabel)
        backViewConstraints()
        stackViewPostConstraints()
    }
    
    private func backViewConstraints() {
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func stackViewPostConstraints() {
        NSLayoutConstraint.activate([
            stackViewPost.topAnchor.constraint(equalTo: backView.topAnchor, constant: 10),
            stackViewPost.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 16),
            stackViewPost.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -16),
            stackViewPost.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -10)
        ])
    }

    func setup(with viewModel: ViewModel) {
        self.authorLabel.text = viewModel.author
        self.imageImageView.image = UIImage(named: viewModel.image)
        self.descriptionLabel.text = viewModel.description
        self.likesLabel.text = "Likes: " + String(viewModel.likes)
        self.viewsLabel.text = "Views: " + String(viewModel.views)
        self.liked = viewModel.liked
        self.likesCount = viewModel.likes
        self.articleNumber = viewModel.articleNumber
    }
    
    @objc func tapLiked() {
        if articleNumber < dataSource.count {
            if authorLabel.text == dataSource[articleNumber].author && descriptionLabel.text == dataSource[articleNumber].description {
                liked.toggle()
                dataSource[articleNumber].liked = liked
                likesLabel.text = "Likes: \(dataSource[articleNumber].likes + (dataSource[articleNumber].liked ? 1 : 0))"
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
