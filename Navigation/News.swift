//
//  News.swift
//  Navigation
//
//  Created by OksanaS on 30.03.2022.
//


class News: Decodable {

    struct Post: Decodable {
        let author, description, image: String
        var likes: Int
        var views: Int

        enum CodingKeys: String, CodingKey {
                case author, description, image, likes, views
            }
    }


    let posts: [Post]
}

