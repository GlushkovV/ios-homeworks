//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Vitaly Glushkov on 24.02.2022.
//

import UIKit

final class ProfileViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        //tableView.rowHeight = UITableView.automaticDimension
        //tableView.estimatedRowHeight = 44
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosTableViewCell")
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "ArticleCell")
        tableView.backgroundColor = .systemGray6
        tableView.layer.borderColor = UIColor.lightGray.cgColor
        tableView.layer.borderWidth = 0.5
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    } ()

    private var dataSource: [Post] = []
    
    private let tapGestureRecognizer = UITapGestureRecognizer()
    
    private let profileHeaderView = ProfileHeaderView()
    
    private let avatarView: AvatarView = {
        let view = AvatarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.addDataSource()
        //self.hidingKeyboard()
        self.setupGesture()
    }
    
    private func setupGesture() {
        tapGestureRecognizer.addTarget(self, action: #selector(handleTapGesture(_ :)))
        profileHeaderView.avatarImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func handleTapGesture(_ gestureRecognizer: UITapGestureRecognizer){
        guard self.tapGestureRecognizer === gestureRecognizer else { return }
        UIView.animate(withDuration: 0.5) {
            self.avatarView.alpha = 1
        }
    }
    
    private func hidingKeyboard() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        navigationItem.backButtonTitle = "Назад"
    }
    
    private func setupView() {
        view.backgroundColor = .systemGray6
        view.addSubview(tableView)
        view.addSubview(avatarView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            avatarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            avatarView.leftAnchor.constraint(equalTo: view.leftAnchor),
            avatarView.rightAnchor.constraint(equalTo: view.rightAnchor),
            avatarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func addDataSource() {
        self.dataSource.append(.init(author: "Андрей Загородний", description: "Тогда и сейчас. Проблемы разные, решения не меняются...", image: "post1", likes: 8, views: 16))
        self.dataSource.append(.init(author: "Лев Красильников", description: "Крепитесь люди, скоро лето...", image: "post2", likes: 2, views: 4))
        self.dataSource.append(.init(author: "Сергей Судаков", description: "Коты замышляют...", image: "post3", likes: 4, views: 8))
        self.dataSource.append(.init(author: "Алексей Кузнецов", description: "Крутые тапки за смешные бабки!", image: "post4", likes: 16, views: 32))
    }
    
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosTableViewCell", for: indexPath)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as? PostTableViewCell else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
                return cell
            }
            let article = self.dataSource[indexPath.row - 1]
            let viewModel = PostTableViewCell.ViewModel(author: article.author,
                                                        image: article.image,
                                                        description: article.description,
                                                        likes: article.likes,
                                                        views: article.views)
            cell.setup(with: viewModel)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        /* var headerView = UIView()
        if section == 0 {
            headerView = ProfileHeaderView()
        }
        return headerView */
        return profileHeaderView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 270
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.navigationController?.pushViewController(PhotosViewController(), animated: true)
        } else { return }
    }
    
}
