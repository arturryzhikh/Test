//
//  ViewController.swift
//  Test
//
//  Created by Artur Ryzhikh on 10.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Subviews
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: PersonCell.className, bundle: nil), forCellReuseIdentifier: PersonCell.className)
        tableView.register(UINib(nibName: ChildCell.className, bundle: nil), forCellReuseIdentifier: ChildCell.className)
        
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChildCell.className, for: indexPath) as! ChildCell
        return cell
    }
    
    
}
