//
//  PostUseCase.swift
//  DesignPattern-Demo
//
//  Created by ukseung.dev on 3/10/25.
//

import Foundation
import RxSwift

final class PostUseCase {
    private let repository: PostRepositoryProtocol
    
    init(repository: PostRepository) {
        self.repository = repository
    }
    
    func fetchPosts() -> Observable<[Post]> {
        return repository.fetchPosts()
    }
}
