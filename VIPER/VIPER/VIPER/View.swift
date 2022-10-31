//
//  View.swift
//  VIPER
//
//  Created by Supapon Pucknavin on 31/10/2565 BE.
//

import Foundation
import UIKit

// ViewController
// protocol
// reference presenter


protocol AnyView {
    var presenter: AnyPresenter? { get set }
    
    func update(with user: [User])
    func update(with error: String)
}

class UserViewController: UIViewController, AnyView {
    // MARK: - PROPERTY
    var presenter: AnyPresenter?
    var users: [User] = []
    
    
    // MARK: - VIEW
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        table.isHidden = true
        return table
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(label)
        label.center = view.center
        
        view.addSubview(tableView)
        tableView.delegate = self
        view.backgroundColor = .systemBlue
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        label.center = view.center
    }
    
    
    // MARK: - FUNCTION
    func update(with user: [User]) {
        DispatchQueue.main.async {
            self.users = user
            self.tableView.reloadData()
            self.tableView.isHidden = false
            
            self.label.isHidden = true
        }
    
    }
    
    func update(with error: String) {
        print(error)
        DispatchQueue.main.async {
            self.users = []
            
            self.tableView.isHidden = true
            
            self.label.text = error
            self.label.isHidden = false
        }
        
    }
    
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension UserViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }
    
    
}
