//
//  NetworkManager.swift
//  DesignPattern-Demo
//
//  Created by ukseung.dev on 3/10/25.
//

import Foundation
import RxSwift
import Moya

public final class NetworkManager {
    static let shared = NetworkManager()
    private let provider: MoyaProvider<MultiTarget> = MoyaProvider<MultiTarget>()
    
    public init() {}
    
    func request<T: Decodable>(target: TargetType, type: T.Type) -> Observable<T> {
        return Observable.create { observer in
            self.provider.request(MultiTarget(target)) { result in
                switch result {
                case .success(let result):
                    do {
                        let result = try JSONDecoder().decode(type, from: result.data)
                        
                        observer.onNext(result)
                        observer.onCompleted()
                    } catch {
                        observer.onError(error)
                    }
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
