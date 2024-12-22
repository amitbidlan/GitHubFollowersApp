//
//  ErrorMessage.swift
//  GitHubFollowers
//
//  Created by Amit Bidlan on 2024/12/18.
//

import Foundation

enum GFError:String,Error {
    case invalidUsername  = "このユーザー名は無効なリクエストを作成しました。もう一度お試しください。"
    case unableToComplete = "リクエストを完了できません。インターネット接続を確認してください。"
    case invalidResponse  = "サーバーからの応答が無効です。もう一度お試しください。"
    case invalidData      = "サーバーから受信したデータが無効です。もう一度お試しください。"
    case unableFavorites = "このユーザーをお気に入りとして保存中にエラーが発生しました。後でもう一度お試しください。"
    case alreadyInFavorites = "このユーザーは既にお気に入りに追加されています。"
    
}
