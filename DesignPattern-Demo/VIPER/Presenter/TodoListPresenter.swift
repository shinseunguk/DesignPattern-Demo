//
//  TodoListPresenter.swift
//  DesignPattern-Demo
//
//  Created by ukseung.dev on 3/11/25.
//

import RxSwift

final class TodoListPresenter {
    let todos = BehaviorSubject<[Todo]>(value: [])
    var router: TodoListRouter
    private let interactor: TodoListInteractor
    
    init(router: TodoListRouter, interactor: TodoListInteractor) {
        self.router = router
        self.interactor = interactor
    }
    
    func fectchTodos() {
        todos.onNext(interactor.fetchTodos())
    }
    
    func didSelectedTodo(_ todo: Todo) {
        router.moveToSelectedTodoDetail(todo: todo)
    }
    
    func didFinishDisplayTodoDetail() {
        router.closeSelectedTodoDetail()
    }
}
