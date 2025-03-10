//
//  PostRepository.swift
//  DesignPattern-Demo
//
//  Created by ukseung.dev on 3/10/25.
//

import Foundation
import RxSwift

final class PostRepository: PostRepositoryProtocol {
    private let networkService = NetworkManager.shared
    
    func fetchPosts() -> Observable<[Post]> {
        return networkService.request(target: PostAPI.fetchPosts, type: [Post].self)
    }
}
