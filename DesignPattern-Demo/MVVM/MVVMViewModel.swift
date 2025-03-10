//
//  MVVMViewModel.swift
//  DesignPattern-Demo
//
//  Created by ukseung.dev on 3/10/25.
//

// ViewModel.swift
import Foundation
import RxSwift
import RxCocoa

class MVVMViewModel {
    
    private let networkService: NetworkService
    private let disposeBag = DisposeBag()
    
    // Observable 데이터 스트림
    let networkResponse = PublishSubject<[User]>()
//    let networkResponse = BehaviorSubject<[User]?>(value: nil)
    let isLoading = BehaviorSubject<Bool>(value: true)
    
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetchData() -> Observable<[User]> {
        return networkService.fetchData()
            .observe(on: MainScheduler.instance)
            .do(onSubscribe: { [weak self] in
                self?.isLoading.onNext(true)
            }, onDispose: { [weak self] in
                self?.isLoading.onNext(false)
            })
    }
}

