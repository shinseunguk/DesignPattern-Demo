//
//  UserModel.swift
//  DesignPattern-Demo
//
//  Created by ukseung.dev on 3/10/25.
//

import Foundation

// Geo 모델
struct Geo: Codable {
    let lat: String
    let lng: String
}

// Address 모델
struct Address: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo
}

// Company 모델
struct Company: Codable {
    let name: String
    let catchPhrase: String
    let bs: String
}

// User 모델
struct User: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company
}

final class UserModel {
    static let shared = UserModel()
    
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                completion(.success(users))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
