//
//  TodoListRouter.swift
//  DesignPattern-Demo
//
//  Created by ukseung.dev on 3/11/25.
//

import RxSwift

final class TodoListRouter {
    let selectedTodo = BehaviorSubject<Todo?>(value: nil)
    
    func moveToSelectedTodoDetail(todo: Todo) {
        selectedTodo.onNext(todo)
    }
    
    func closeSelectedTodoDetail() {
        selectedTodo.onNext(nil)
    }
}
