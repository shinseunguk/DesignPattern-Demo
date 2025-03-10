//
//  MVCViewController.swift
//  DesignPattern-Demo
//
//  Created by ukseung.dev on 3/10/25.
//

import Foundation
import UIKit
import Then
import SnapKit

final class MVCViewController: UIViewController {
    var navTitle: String
    let viewModel = UserModel.shared
    
    private var users: [User] = []
    lazy var tableView = UITableView().then {
        $0.dataSource = self
        $0.delegate = self
        $0.register(MVCCell.self, forCellReuseIdentifier: MVCCell.identifier)
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
}

extension MVCViewController: ViewAttributes {
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
}

extension MVCViewController {
    func fetchData() {
        viewModel.fetchUsers { result in
            switch result {
            case .success(let user):
                self.users = user
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            default:
                break
            }
        }
    }
}

extension MVCViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MVCCell.identifier, for: indexPath) as! MVCCell
        cell.configure(with: users[indexPath.row].username)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
