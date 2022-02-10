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
       
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.sectionFooterHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: PersonCell.className, bundle: nil), forCellReuseIdentifier: PersonCell.className)
        tableView.register(UINib(nibName: PersonHeader.className, bundle: nil), forHeaderFooterViewReuseIdentifier: PersonHeader.className)
        tableView.register(UINib(nibName: PersonFooter.className, bundle: nil), forHeaderFooterViewReuseIdentifier: PersonFooter.className)
      }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PersonCell.className, for: indexPath) as! PersonCell
        cell.ageTextField.delegate = self
        cell.nameTextField.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: PersonHeader.className)
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: PersonFooter.className)
        return footer
    }
    
    
}

extension ViewController: UITextFieldDelegate {
    
}
