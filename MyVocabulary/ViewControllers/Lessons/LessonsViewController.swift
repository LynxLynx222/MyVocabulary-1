//
//  LessonsViewController.swift
//  MyVocabulary
//
//  Created by Ondrej Andrysek on 5/7/18.
//  Copyright © 2018 Ondrej Andrysek. All rights reserved.
//

import UIKit
import RealmSwift

protocol LessonsViewControllerDelegate: class{
    func controllerDidFinishWithLesson(lesson: Lesson)
}

class LessonsViewController: UIViewController {

    var tableView = UITableView()
    
    private var viewModel: LessonsViewModel!
    weak var delegate: LessonsViewControllerDelegate?
    
    init(viewModel: LessonsViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.viewModel.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        initNavigationBar()
        initTableView()
        initConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.getLessons()
    }
    
    private func initNavigationBar(){
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showLessons))
        navigationItem.setRightBarButton(addButton, animated: false)
    }
    
    private func initTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 66
        tableView.tableFooterView = UIView()
        tableView.register(LessonsTableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
    }
    
    private func initConstraints(){
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(80)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    @objc private func showLessons2(){
        self.present(AddLessonViewController(), animated: true, completion: nil)
    }
    
    @objc private func showLessons(){
        let dataProvider = DataProvider()
        let alertController = UIAlertController(title: "Add lesson", message: "", preferredStyle: .alert)
        let bundle1Action = UIAlertAction(title: "Norsk 1", style: .default) { (action) in
            let lesson = Lesson(languageID: self.viewModel.getLanguageID(), title: "Norsk 1")
            let words = dataProvider.getArray(lessonID: lesson.id, bundle: 1)
            self.viewModel.buttonAction(lesson: lesson, words: words)
        }
        let bundle2Action = UIAlertAction(title: "Norsk 2", style: .default) { (action) in
            let lesson = Lesson(languageID: self.viewModel.getLanguageID(), title: "Norsk 2")
            let words = dataProvider.getArray(lessonID: lesson.id, bundle: 2)
            self.viewModel.buttonAction(lesson: lesson, words: words)
        }
        let bundle3Action = UIAlertAction(title: "Norsk 3", style: .default) { (action) in
            let lesson = Lesson(languageID: self.viewModel.getLanguageID(), title: "Norsk 3")
            let words = dataProvider.getArray(lessonID: lesson.id, bundle: 3)
            self.viewModel.buttonAction(lesson: lesson, words: words)
        }
        let bundle4Action = UIAlertAction(title: "Norsk 4", style: .default) { (action) in
            let lesson = Lesson(languageID: self.viewModel.getLanguageID(), title: "Norsk 4")
            let words = dataProvider.getArray(lessonID: lesson.id, bundle: 4)
            self.viewModel.buttonAction(lesson: lesson, words: words)
        }
        let bundle5Action = UIAlertAction(title: "Hirigana", style: .default) { (action) in
            let lesson = Lesson(languageID: self.viewModel.getLanguageID(), title: "Hirigana")
            let words = dataProvider.getArray(lessonID: lesson.id, bundle: 5)
            self.viewModel.buttonAction(lesson: lesson, words: words)
        }
        let bundle6Action = UIAlertAction(title: "Japanese 1", style: .default) { (action) in
            let lesson = Lesson(languageID: self.viewModel.getLanguageID(), title: "Japanese")
            let words = dataProvider.getArray(lessonID: lesson.id, bundle: 6)
            self.viewModel.buttonAction(lesson: lesson, words: words)
        }
        let bundle7Action = UIAlertAction(title: "Japanese AIUEO", style: .default) { (action) in
            let lesson = Lesson(languageID: self.viewModel.getLanguageID(), title: "Japanese AIUEO")
            let words = dataProvider.getArray(lessonID: lesson.id, bundle: 7)
            self.viewModel.buttonAction(lesson: lesson, words: words)
        }
        let bundle8Action = UIAlertAction(title: "Japanese basic 1", style: .default) { (action) in
            let lesson = Lesson(languageID: self.viewModel.getLanguageID(), title: "Japanese basic 1")
            let words = dataProvider.getArray(lessonID: lesson.id, bundle: 8)
            self.viewModel.buttonAction(lesson: lesson, words: words)
        }
        alertController.addAction(bundle1Action)
        alertController.addAction(bundle2Action)
        alertController.addAction(bundle3Action)
        alertController.addAction(bundle4Action)
        alertController.addAction(bundle5Action)
        alertController.addAction(bundle6Action)
        alertController.addAction(bundle7Action)
        alertController.addAction(bundle8Action)
        present(alertController, animated: true, completion: nil)
    }
    
}

extension LessonsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getLessonsCount()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? LessonsTableViewCell else {return UITableViewCell()}
        let item = viewModel.getLesson(row: indexPath.row)
        cell.lessonView.titleLabel.text = item.title
        cell.lessonView.progressLabel.text = "\(viewModel.calculateCompleted(lesson: item))%"
        cell.lessonView.wordCountLabel.text = "\(item.numberOfWords) words"
        cell.selectionStyle = .none
        return cell
    }
}

extension LessonsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.controllerDidFinishWithLesson(lesson: self.viewModel.getLesson(row: indexPath.row))
    }
}

extension LessonsViewController: LessonsViewModelDelegate{
    func reloadTableView() {
        tableView.reloadData()
    }
}
