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
}

extension MVCViewController: ViewAttributes {
    func setNavigationBar() {
        self.navigationItem.title = navTitle
    }
    
    func setUI() {
    }
    
    func setAttribute() {
    }
}
