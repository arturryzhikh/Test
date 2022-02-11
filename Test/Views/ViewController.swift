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
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let clearAction = UIAlertAction(title: "Сбросить данные", style: .default) { [weak self ] action -> Void in
            guard let self = self else { return }
            self.viewModel.clear()
        }

        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) { action -> Void in
            return
        }
        actionSheet.addAction(clearAction)
        actionSheet.addAction(cancelAction)
        present(actionSheet, animated: true,completion: nil)
    }
    //MARK: Bind view model
    private func bindViewModel(_viewModel: ViewModel) {
        viewModel.onError = { [weak self] message in
            //FIXME: show alert
            guard let self = self else { return }
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
              // your code with delay
              alert.dismiss(animated: true, completion: nil)
            }
            
        }
        
        viewModel.onReload = { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
    //MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindViewModel(_viewModel: viewModel)
     
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
            let cell = tableView.dequeueReusableCell(withIdentifier: PersonCell.className, for: indexPath) as! PersonCell
            cell.ageTextField.text = viewModel.person.age
            cell.nameTextField.text = viewModel.person.name
            cell.nameChanged = { [weak self] name in
                guard let self = self else {
                    return
                }
               self.viewModel.setName(name)
                
            }
            
            cell.ageChanged = { [weak self] age in
                guard let self = self else {
                    return
                }
                self.viewModel.setAge(age)
            }
            return cell
            
        case .children:
            let cell = tableView.dequeueReusableCell(withIdentifier: ChildCell.className, for: indexPath) as! ChildCell
            cell.nameTextField.text = viewModel.person.children[indexPath.row].name
            cell.ageTextField.text = viewModel.person.children[indexPath.row].age
            cell.deleteChild = { [weak self] in
                guard indexPath.section > 0 , let self = self else { return }
                self.viewModel.deleteChild(at: indexPath.row)
            }
            
            
            return cell
        case .none:
            fatalError("No appropriate cell for indexPath : \(indexPath)")
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: PersonFooter.className) as! PersonFooter
        footer.addChildAction = { [weak self] in
            guard let self = self else { return }
            self.viewModel.addChild()
        }
        
        return (section == 0) ? footer : nil
    }
    
    
}


