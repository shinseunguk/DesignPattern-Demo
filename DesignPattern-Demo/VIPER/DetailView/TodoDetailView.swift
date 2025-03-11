//
//  TodoDetailView.swift
//  DesignPattern-Demo
//
//  Created by ukseung.dev on 3/11/25.
//

import UIKit

class TodoDetailView: UIViewController {
    var text: String
    
    lazy var label = UILabel().then {
        $0.text = text
    }
    
    init(text: String) {
        self.text = text
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
}

extension TodoDetailView: ViewAttributes {
    func setNavigationBar() {
    }
    
    func setUI() {
        [
            label
        ].forEach { self.view.addSubview($0) }
    }
    
    func setAttribute() {
        label.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
