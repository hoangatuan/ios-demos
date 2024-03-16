//
//  ViewController.swift
//  Demo
//
//  Created by Tuan Hoang Anh on 16/3/24.
//

import UIKit

enum Scenario: String, CaseIterable {
    case closure = "Closure: When it captures/release object?"
}

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.title = "Scenarios"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CELL")
    }
    
    func log() {
        debugPrint("Tuanha24: Logging vc1")
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Scenario.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath)
        let scenario = Scenario.allCases[indexPath.row]
        cell.textLabel?.text = scenario.rawValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let scenario = Scenario.allCases[indexPath.row]
        switch scenario {
        case .closure:
            let vc = ViewController1()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
