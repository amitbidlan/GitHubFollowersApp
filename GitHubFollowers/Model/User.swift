//
//  User.swift
//  GitHubFollowers
//
//  Created by Amit Bidlan on 2024/12/18.
//

import Foundation

struct User:Codable{
    var login:String
    var avatar:String
    var name:String?
    var location:String?
    var bio:String?
    var publicRepos:Int
    var publicGists:Int
    var htmlUrl:String
    var following:Int
    var followers:Int
    var createdAt:String
    
}
