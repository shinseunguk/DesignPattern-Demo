//
//  Extension+UIViewController.swift
//  DesignPattern-Demo
//
//  Created by ukseung.dev on 3/10/25.
//

import UIKit
import ObjectiveC.runtime

extension UIViewController {
    static let swizzleViewDidLoad: Void = {
        let originalSelector = #selector(viewDidLoad)
        let swizzledSelector = #selector(swizzled_viewDidLoad)

        if let originalMethod = class_getInstanceMethod(UIViewController.self, originalSelector),
           let swizzledMethod = class_getInstanceMethod(UIViewController.self, swizzledSelector) {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }()

    @objc func swizzled_viewDidLoad() {
        self.swizzled_viewDidLoad() // 원래 `viewDidLoad()`를 호출

        // 모든 뷰 컨트롤러에 배경색 설정
        self.view.backgroundColor = .white // 원하는 배경색으로 설정
    }
}

// Swizzling 적용하기
extension UIApplication {
    private static let runOnce: Void = {
        UIViewController.swizzleViewDidLoad
    }()

    override open var next: UIResponder? {
        UIApplication.runOnce
        return super.next
    }
}
