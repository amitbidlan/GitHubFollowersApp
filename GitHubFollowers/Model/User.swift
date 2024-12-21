//
//  User.swift
//  GitHubFollowers
//
//  Created by Amit Bidlan on 2024/12/18.
//

import Foundation

struct User: Codable, Hashable {
    let login: String
    let avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    let publicRepos: Int
    let publicGists: Int
    let htmlUrl: String
    let following: Int
    let followers: Int
    let createdAt: String
}
