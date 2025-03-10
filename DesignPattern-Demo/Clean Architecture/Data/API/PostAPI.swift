//
//  PostAPI.swift
//  DesignPattern-Demo
//
//  Created by ukseung.dev on 3/10/25.
//

import Foundation
import Moya
import RxSwift

enum PostAPI {
    case fetchPosts
}

extension PostAPI: TargetType {
    var baseURL: URL { return URL(string: "https://jsonplaceholder.typicode.com")! }
    var path: String {
        switch self {
        case .fetchPosts:
            return "/posts"
        }
    }
    var method: Moya.Method {
        return .get
    }
    var task: Task {
        return .requestPlain
    }
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
