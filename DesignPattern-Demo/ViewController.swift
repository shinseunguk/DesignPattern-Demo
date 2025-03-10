//
//  ViewController.swift
//  DesignPattern-Demo
//
//  Created by ukseung.dev on 3/10/25.
//

import UIKit
import Then
import SnapKit

final class ViewController: UIViewController {
    let cellItems = ["MVC", "MVVM", "VIPER", "Clean Architecutre"]
    
    lazy var tableView = UITableView().then {
        $0.dataSource = self
        $0.delegate = self
        $0.register(DesignPatternCell.self, forCellReuseIdentifier: DesignPatternCell.identifier)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        setUI()
        setAttribute()
    }
}

extension ViewController: ViewAttributes {
    func setNavigationBar() {
        self.navigationItem.title = "DesignPattern"
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

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DesignPatternCell.identifier, for: indexPath) as! DesignPatternCell
        cell.configure(with: cellItems[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0: self.navigationController?.pushViewController(MVCViewController(navTitle: cellItems[indexPath.row]), animated: true)
        case 1: self.navigationController?.pushViewController(MVVMViewController(navTitle: cellItems[indexPath.row]), animated: true)
        case 3:
            let useCase = PostUseCase(repository: PostRepository())
            let viewModel = PostViewModel(useCase: useCase)
            let viewController = PostViewController(navTitle: cellItems[indexPath.row], viewModel: viewModel)  // Presentation Layer
            
            self.navigationController?.pushViewController(viewController, animated: true)
        default: break
        }
    }
}

