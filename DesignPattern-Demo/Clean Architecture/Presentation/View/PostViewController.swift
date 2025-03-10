//
//  PostViewController.swift
//  DesignPattern-Demo
//
//  Created by ukseung.dev on 3/10/25.
//

import Foundation
import UIKit
import RxSwift

final class PostViewController: UIViewController {
    private var navTitle: String
    private let disposeBag = DisposeBag()
    private let viewModel: PostViewModel
    
    lazy var tableView = UITableView().then {
        $0.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
    }
    
    let indicatorView = UIActivityIndicatorView().then {
        $0.tintColor = .red
    }
    
    init(navTitle: String, viewModel: PostViewModel) {
        self.navTitle = navTitle
        self.viewModel = viewModel
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

extension PostViewController: ViewAttributes {
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
        viewModel.fetchPosts()
        
        viewModel.posts
            .bind(to: tableView.rx.items(cellIdentifier: CustomCell.identifier, cellType: CustomCell.self)) { tableView, indexPath, cell in
                cell.configure(with: indexPath.title + "\n\n" + indexPath.body)
            }
            .disposed(by: disposeBag)
        
        viewModel.isLoading
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                $0 ? indicatorView.startAnimating() : indicatorView.stopAnimating()
            })
            .disposed(by: disposeBag)
    }
}
