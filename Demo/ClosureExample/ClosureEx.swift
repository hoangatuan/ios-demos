//
//  ViewControlelr2.swift
//  Demo
//
//  Created by Tuan Hoang Anh on 16/3/24.
//

import UIKit
import SnapKit

class ViewController1: UIViewController {
    
    let button: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Navigate to vc2", for: .normal)
        return btn
    }()
    
    // Scenario 3
    var vc2: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationController?.title = "Closure example"
        
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        button.addTarget(self, action: #selector(goToVC2), for: .touchUpInside)
    }
    
    deinit {
        debugPrint("Deinit View Controller 1 \(Date().timeIntervalSince1970)")
    }
    
    @objc
    func goToVC2() {
        let vc2 = ViewController2()
        
        // Scenario 3
        self.vc2 = vc2
        vc2.performAction {
            self.log()
        }
        
        navigationController?.pushViewController(vc2, animated: true)
    }
    
    func log() {
        debugPrint("Tuanha24: ViewController 1 - \(self)")
    }
}

class ViewController2: UIViewController {
    
    deinit {
        debugPrint("Deinit View Controller 2 \(Date().timeIntervalSince1970)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        /// Scenario 1
//        check()
        
        /// Scenario 2
        performAction {
            self.log()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        debugPrint("Tuanha24: View will disappear \(Date().timeIntervalSince1970)")
    }
    
    func check() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.log()
        }
    }
    
    func log() {
        debugPrint("Tuanha24: ViewController 2 - \(self)")
    }
    
    func performAction(action: @escaping () -> Void) {
        debugPrint("Tuanha24: Trigger action")
        action()
    }
}
