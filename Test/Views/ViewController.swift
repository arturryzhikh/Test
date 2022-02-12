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
    //MARK: IB Actions
    @IBAction func clearButtonTapped() {
        let actionSheet = UIAlertController(title: nil,
                                            message: nil,
                                            preferredStyle: .actionSheet)
        
        let clearAction = UIAlertAction(title: "Сбросить данные",
                                        style: .default) { [weak self ] action -> Void in
            guard let self = self else { return }
            self.viewModel.clear()
        }
        
        let cancelAction = UIAlertAction(title: "Отмена",
                                         style: .cancel) { action -> Void in
            
            return
        }
        
        actionSheet.addAction(clearAction)
        actionSheet.addAction(cancelAction)
        present(actionSheet, animated: true,completion: nil)
    }
    
    //MARK: Bind view model
    private func bindViewModel(_ viewModel: ViewModel) {
        viewModel.onReload = { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
    
    //MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindViewModel(viewModel)
        dismissKeyboard()
        
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: PersonFooter.className, bundle: nil), forHeaderFooterViewReuseIdentifier: PersonFooter.className)
    }
    
    
}
//MARK: UITableViewDelegate & UITableViewDataSource
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
            let cell = tableView
                .dequeueReusableCell(withIdentifier: PersonCell.className, for: indexPath) as! PersonCell
            
            if let parent = viewModel.pickPerson(at: indexPath) {
                cell.ageTextField.text = parent.age
                cell.nameTextField.text = parent.name
            }
            
            
            cell.nameChanged = { [weak self] name in
                guard let self = self else { return }
                self.viewModel.setName(name,at: indexPath)
            }
            
            cell.ageChanged = { [weak self] age in
                guard let self = self else { return }
                self.viewModel.setAge(age,at: indexPath)
            }
            
            return cell
            
        case .children:
            let cell = tableView
                .dequeueReusableCell(withIdentifier: ChildCell.className, for: indexPath) as! ChildCell
            
            if let child = viewModel.pickPerson(at: indexPath) {
                cell.ageTextField.text = child.age
                cell.nameTextField.text = child.name
            }
            
            
            cell.nameChanged = { [weak self] name in
                guard let self = self else { return }
                self.viewModel.setName(name,at: indexPath)
            }
            
            cell.ageChanged = { [weak self] age in
                guard let self = self else { return }
                self.viewModel.setAge(age,at: indexPath)
                
            }
            cell.deleteChild = { [weak self] in
                guard let self = self else { return }
                self.viewModel.deleteChild(at: indexPath.row)
            }
            return cell
            
        case .none:
            fatalError("No appropriate cell for indexPath : \(indexPath)")
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView
            .dequeueReusableHeaderFooterView(withIdentifier: PersonFooter.className) as! PersonFooter
        
        footer.addChildAction = { [weak self] in
            guard let self = self else { return }
            self.viewModel.addChild()
        }
        
        let section = ViewModel.Sections(rawValue: section)
        switch section {
        case .person:
            return  viewModel.canAddChild ? footer : nil
        case .children:
            return nil
        case .none:
            return nil
        }
        
    }
    
    
}


