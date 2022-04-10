//
//  Post.swift
//  Navigation
//
//  Created by Vitaly Glushkov on 19.03.2022.
//

import Foundation

struct Posts {
    let author, description, image: String
    var likes, views: Int
    var liked : Bool
}

var dataSource: [Posts] = [
    Posts(author: "Андрей Загородний", description: "Тогда и сейчас. Проблемы разные, решения не меняются...", image: "post1", likes: 8, views: 16, liked: false),
    Posts(author: "Лев Красильников", description: "Крепитесь люди, скоро лето...", image: "post2", likes: 2, views: 4, liked: false),
    Posts(author: "Сергей Судаков", description: "Коты замышляют...", image: "post3", likes: 4, views: 8, liked: false),
    Posts(author: "Алексей Кузнецов", description: "Крутые тапки за смешные бабки!", image: "post4", likes: 16, views: 32, liked: false),
    Posts(author: "Андрей Слащев", description: "5G? Нет, не слышали!!!", image: "post5", likes: 32, views: 64, liked: false)
]
