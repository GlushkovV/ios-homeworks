//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Vitaly Glushkov on 24.02.2022.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    private lazy var profileHeaderView = ProfileHeaderView()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "ArticleCell")
        tableView.backgroundColor = .systemGray6
        tableView.layer.borderColor = UIColor.lightGray.cgColor
        tableView.layer.borderWidth = 0.5
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    } ()
    
    private var heightConstraint: NSLayoutConstraint?
    
    private var dataSource: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.addDataSource()
        self.hidingKeyboard()
    }
    
    private func hidingKeyboard() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    private func setupView() {
        view.backgroundColor = .systemGray6
        view.addSubview(self.tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
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
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as? PostTableViewCell else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
            return cell
        }
        let article = self.dataSource[indexPath.row]
        let viewModel = PostTableViewCell.ViewModel(author: article.author,
                                                   image: article.image,
                                                   description: article.description,
                                                   likes: article.likes,
                                                   views: article.views)
        cell.setup(with: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerView = UIView()
        if section == 0 {
            headerView = ProfileHeaderView()
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 250
    }
}
