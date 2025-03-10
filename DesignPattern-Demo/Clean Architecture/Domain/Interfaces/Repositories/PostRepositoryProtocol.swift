//
//  PostRepositoryProtocol.swift
//  DesignPattern-Demo
//
//  Created by ukseung.dev on 3/10/25.
//

import Foundation
import RxSwift

protocol PostRepositoryProtocol {
    func fetchPosts() -> Observable<[Post]>
}
