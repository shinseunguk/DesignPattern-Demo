//
//  TodoListViewController.swift
//  DesignPattern-Demo
//
//  Created by ukseung.dev on 3/11/25.
//

import UIKit
import SnapKit
import Then
import RxSwift

class TodoListViewController: UIViewController {
    var navTitle: String
    var disposeBag = DisposeBag()
    
    private let tableView = UITableView().then {
        $0.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
    }

    private let presenter: TodoListPresenter

    init(navTitle:String, presenter: TodoListPresenter) {
        self.navTitle = navTitle
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        setUI()
        setAttribute()
        bindRx()
    }
}

extension TodoListViewController: ViewAttributes {
    func setNavigationBar() {
        self.navigationItem.title = navTitle
    }
    
    func setUI() {
        [
            tableView
        ].forEach { self.view.addSubview($0) }
    }
    
    func setAttribute() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    func bindRx() {
        presenter.fectchTodos()
        presenter.todos
            .bind(to: tableView.rx.items(cellIdentifier: CustomCell.identifier, cellType: CustomCell.self)) { tableView, item, cell in
                cell.configure(with: item.title)
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Todo.self)
            .subscribe(onNext: { [weak self] todo in
                guard let self = self, let indexPath = self.tableView.indexPathForSelectedRow else { return }
                presenter.didSelectedTodo(todo)
                
                // 선택 해제 (색상 복원)
                self.tableView.deselectRow(at: indexPath, animated: true)
            })
            .disposed(by: disposeBag)
        
        presenter.router.selectedTodo
            .subscribe(onNext: { [weak self] in
                guard let self = self, let todo = $0 else { return }
                self.navigationController?.pushViewController(TodoDetailView(text: todo.title), animated: true)
            })
            .disposed(by: disposeBag)
    }
}

