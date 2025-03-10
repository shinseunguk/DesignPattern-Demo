//
//  NetworkService.swift
//  DesignPattern-Demo
//
//  Created by ukseung.dev on 3/10/25.
//

import Foundation
import Alamofire
import RxSwift

final class NetworkService {
    let url = "https://jsonplaceholder.typicode.com/users"
    
    func fetchData() -> Observable<[User]> {
        return Observable.create { observer in
            AF.request(self.url).responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let response = try JSONDecoder().decode([User].self, from: data)
                        observer.onNext(response)
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
