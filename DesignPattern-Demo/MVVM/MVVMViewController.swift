//
//  MVVMViewController.swift
//  DesignPattern-Demo
//
//  Created by ukseung.dev on 3/10/25.
//

import Foundation
import UIKit
import RxSwift

final class MVVMViewController: UIViewController {
    private var navTitle: String
    private let viewModel = MVVMViewModel()
    private let disposeBag = DisposeBag()
    
    lazy var tableView = UITableView().then {
        $0.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
    }
    
    let indicatorView = UIActivityIndicatorView().then {
        $0.tintColor = .red
    }
    
    init(navTitle: String) {
        self.navTitle = navTitle
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

extension MVVMViewController: ViewAttributes {
    func setNavigationBar() {
        self.navigationItem.title = navTitle
    }
    
    func setUI() {
        [
            tableView,
            indicatorView
        ].forEach { self.view.addSubview($0) }
        
        view.bringSubviewToFront(indicatorView)
    }
    
    func setAttribute() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        indicatorView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    func bindRx() {
        viewModel.isLoading
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                $0 ? self.indicatorView.startAnimating() : self.indicatorView.stopAnimating()
            })
            .disposed(by: disposeBag)
        
        viewModel.fetchData()
            .bind(to: tableView.rx.items(cellIdentifier: CustomCell.identifier, cellType: CustomCell.self)) { _, item, cell in
                cell.configure(with: item.username)
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(User.self)
            .subscribe(onNext: { [weak self] user in
                guard let self = self, let indexPath = self.tableView.indexPathForSelectedRow else { return }
                
                print("선택된 유저: \(user.username)")
                
                // 선택 해제 (색상 복원)
                self.tableView.deselectRow(at: indexPath, animated: true)
            })
            .disposed(by: disposeBag)
    }
}
