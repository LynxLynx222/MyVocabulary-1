//
//  LanguagesViewController.swift
//  MyVocabulary
//
//  Created by Ondrej Andrysek on 8/4/18.
//  Copyright © 2018 Ondrej Andrysek. All rights reserved.
//

import UIKit

let languageCell = "languageCell"

protocol LanugagesViewControllerDelegate: class{
    func controllerDidFinishWithLanguage(language: Language)
}

class LanguagesViewController: UIViewController {

    let tableView = UITableView()
    
    private var viewModel: LanguagesViewModel!
    weak var delegate: LanugagesViewControllerDelegate?
    private var flowController: MainFlowController!
    init(viewModel: LanguagesViewModel){
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.viewModel.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getLanguages()
    }
    
    private func setupView(){
        
        if let nav = navigationController{
            flowController = MainFlowController(nav)
            self.delegate = flowController
        }
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addLanguage))
        navigationItem.setRightBarButton(addButton, animated: false)
        
        setupTableView()
    }
    
    private func setupTableView(){
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(LanguageTableViewCell.self, forCellReuseIdentifier: languageCell)
        tableView.separatorStyle = .none
        tableView.rowHeight = 76
        tableView.tableFooterView = UIView()
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    @objc private func addLanguage(){
        let alertController = UIAlertController(title: "Add language", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Language"
        }
        let confirmAction = UIAlertAction(title: "OK", style: .default) { (action) in
            guard let textField = alertController.textFields?.first, let text = textField.text else { return }
            let language = Language(title: text)
            self.viewModel.addLanguage(language: language)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension LanguagesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getLanguagesCount()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: languageCell, for: indexPath) as? LanguageTableViewCell else {return UITableViewCell()}
        let item = viewModel.getLanguage(row: indexPath.row)
        cell.languageView.titleLabel.text = item.title
        cell.languageView.lessonsLabel.text = "lessons: \(item.numberOfLessons)"
        cell.languageView.backgroundColor = viewModel.getColor(row: indexPath.row)
        return cell
    }
}

extension LanguagesViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let viewModel = LessonsViewModel(language: self.viewModel.getLanguage(row: indexPath.row))
//        let lessonViewController = LessonsViewController(viewModel: viewModel)
//        self.navigationController?.pushViewController(lessonViewController, animated: true)
        delegate?.controllerDidFinishWithLanguage(language: viewModel.getLanguage(row: indexPath.row))
    }
}

extension LanguagesViewController: LanguagesViewModelDelegate{
    func reloadTableView() {
        tableView.reloadData()
    }
}
