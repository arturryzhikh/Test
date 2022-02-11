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
        tableView.register(UINib(nibName: PersonFooter.className, bundle: nil), forHeaderFooterViewReuseIdentifier: PersonFooter.className)
      }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChildCell", for: indexPath)

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: PersonFooter.className)
        return footer
    }
    
    
}

extension ViewController: UITextFieldDelegate {
    
}
