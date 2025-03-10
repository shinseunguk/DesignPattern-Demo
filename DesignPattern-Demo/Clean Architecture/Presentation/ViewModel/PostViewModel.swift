//
//  PostViewModel.swift
//  DesignPattern-Demo
//
//  Created by ukseung.dev on 3/10/25.
//

import Foundation
import RxSwift

final class PostViewModel {
    private let useCase: PostUseCase
    private let disposeBag = DisposeBag()
    
    let posts = PublishSubject<[Post]>()
    let error = PublishSubject<String>()
    let isLoading = BehaviorSubject<Bool>(value: true)
    
    init(useCase: PostUseCase) {
        self.useCase = useCase
    }
    
    func fetchPosts() {
        useCase.fetchPosts()
            .subscribe(onNext: { [weak self] post in
                self?.posts.onNext(post)
                self?.isLoading.onNext(false)
            }, onError: { [weak self] err in
                self?.error.onNext("Failed to fetch repositories")
                self?.isLoading.onNext(false)
            })
            .disposed(by: disposeBag)
    }
}
