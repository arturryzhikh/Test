//
//  ViewController.swift
//  Test
//
//  Created by Artur Ryzhikh on 10.02.2022.
//

import UIKit

class ViewController: UIViewController {
    //MARK: View Model
    private let viewModel = ViewModel()
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection(section)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = ViewModel.Sections(rawValue: indexPath.section)
        switch section {
        case .person:
            let cell = tableView.dequeueReusableCell(withIdentifier: PersonCell.className, for: indexPath)
            return cell
        case .children:
            let cell = tableView.dequeueReusableCell(withIdentifier: ChildCell.className, for: indexPath)
            return cell
        case .none:
            fatalError("No appropriate cell for indexPath : \(indexPath)")
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: PersonFooter.className)
        return (section == 0) ? footer : nil
    }
    
    
}

extension ViewController: UITextFieldDelegate {
    
}
