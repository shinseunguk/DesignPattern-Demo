//
//  TodoListInteractor.swift
//  DesignPattern-Demo
//
//  Created by ukseung.dev on 3/11/25.
//

import Foundation

protocol TodoListInteractorInput: AnyObject {
  func fetchTodos() -> [Todo]
}

class TodoListInteractor: TodoListInteractorInput {
  func fetchTodos() -> [Todo] {
    let todos = (1...10).map {
      Todo(title: "할 일 \($0)")
    }
    return todos
  }
}
