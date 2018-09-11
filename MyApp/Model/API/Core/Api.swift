//
//  Api.swift
//  MyApp
//
//  Created by iOSTeam on 2/21/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

final class Api {
    struct Path {
        static let baseURL = "http://54.221.147.79:8080"
    }

    struct Me { }

    struct TopicDetail { }

    struct Topic { }

    struct NewTopic { }

    struct Vocabulary { }

    struct SystemTopic { }

    struct Level { }

    struct VocabOfLevel { }

    struct Score { }

    struct TopTopic { }

    struct EditTopic { }

    struct DeleteTopic { }

    struct Comment { }

    struct Ranking { }

    struct FavoriteTopic { }
}

extension Api.Path {

    struct Me: ApiPath {
        static var path: String { return baseURL }
        var version = "v1"
        var role = "user"
        var login = "login"
        var update = "update"

        var urlString: String {
            return Me.path / version / role
        }

        var urlLogin: String {
            return urlString / login
        }

        var urlUpdate: String {
            return urlString / update
        }
    }

    //http://54.221.147.79:8080/v1/vpn/user/topic/{id}
    struct TopicDetail: ApiPath {
        static var path: String { return baseURL }
        var version = "v1"
        var team = "vpn"
        var role = "user"
        var category = "topic"
        var id: Int
        var urlString: String {
            return TopicDetail.path / version / team / role / category / id
        }

        init(id: Int) {
            self.id = id
        }
    }

    struct Vocabulary: ApiPath {
        static var path: String { return baseURL }
        var version = "v1"
        var team = "vpn"
        var category = "vocabularies"
        var urlString: String {
            return Vocabulary.path / version / team / category
        }
    }

    struct NewTopic: ApiPath {
        static var path: String { return baseURL }
        var version = "v1"
        var team = "vpn"
        var role = "user"
        var category = "topic"
        var urlString: String {
            return NewTopic.path / version / team / role / category
        }
    }

    struct Level: ApiPath {
        static var path: String { return baseURL }
        var version = "v1"
        var team = "vpn"
        var action = "levels"
        var urlString: String {
            return Level.path / version / team / action
        }
    }

    struct SystemTopic: ApiPath {
        static var path: String { return baseURL }
        var version = "v1"
        var team = "vpn"
        var role = "user"
        var category = "topics"
        var owner = "system"

        var urlString: String {
            return SystemTopic.path / version / team / role / category / owner
        }
    }

    struct Topic: ApiPath {
        static var path: String { return baseURL }
        var version = "v1"
        var team = "vpn"
        var role = "user"
        var category = "topics"
        var favorite = "likes"
        var urlString: String {
            return Topic.path / version / team / role / category
        }

        var urlFavorite: String {
            return Topic.path / version / team / role / favorite
        }
    }

    //http://54.221.147.79:8080/v1/vpn/user/vocabularies/level/{id}
    struct VocabOfLevel: ApiPath {
        static var path: String { return baseURL }
        var version = "v1"
        var team = "vpn"
        var role = "user"
        var category = "vocabularies"
        var action = "level"
        var id: Int
        var urlString: String {
            return VocabOfLevel.path / version / team / role / category / action / id
        }
        init(id: Int) {
            self.id = id
        }
    }

    struct Score: ApiPath {
        static var path: String { return baseURL }
        var version = "v1"
        var team = "vpn"
        var role = "user"
        var category = "score"
        var urlString: String {
            return Score.path / version / team / role / category
        }
    }

    struct EditTopic: ApiPath {
        static var path: String { return baseURL }
        var version = "v1"
        var team = "vpn"
        var role = "user"
        var category = "topic"
        var id: Int
        var urlString: String {
            return EditTopic.path / version / team / role / category / id
        }
        init(id: Int) {
            self.id = id
        }
    }

    struct TopTopic: ApiPath {
        static var path: String { return baseURL }
        var version = "v1"
        var team = "vpn"
        var role = "user"
        var category = "topics"
        var top = "top"
        var urlString: String {
            return TopTopic.path / version / team / role / category / top
        }
    }

    struct Ranking: ApiPath {
        static var path: String { return baseURL }
        var version = "v1"
        var team = "vpn"
        var role = "user"
        var category = "ranking"
        var urlString: String {
            return Me.path / version / team / role / category
        }
    }

    //http://54.221.147.79:8080/v1/vpn/user/comment/topic/{id}
    struct Comment: ApiPath {
        static var path: String { return baseURL }
        var version = "v1"
        var team = "vpn"
        var role = "user"
        var category = "comment"
        var owner = "topic"
        var id: Int
        var urlString: String {
            return Comment.path / version / team / role / category
        }
        var topic: String {
            return urlString / owner / id
        }

        init(id: Int = 1) {
            self.id = id
        }
    }
    //v1/vpn/user/topic/like
    struct FavoriteTopic: ApiPath {
        static var path: String { return baseURL }
        var version = "v1"
        var team = "vpn"
        var role = "user"
        var category = "topic"
        var action = "like"
        var urlString: String {
            return Comment.path / version / team / role / category / action
        }
    }
}

protocol URLStringConvertible {
    var urlString: String { get }
}

protocol ApiPath: URLStringConvertible {
    static var path: String { get }
}

extension URL: URLStringConvertible {
    var urlString: String { return absoluteString }
}

extension Int: URLStringConvertible {
    var urlString: String { return String(describing: self) }
}

private func / (lhs: URLStringConvertible, rhs: URLStringConvertible) -> String {
    return lhs.urlString + "/" + rhs.urlString
}

extension String: URLStringConvertible {
    var urlString: String { return self }
}

extension CustomStringConvertible where Self: URLStringConvertible {
    var urlString: String { return description }
}
