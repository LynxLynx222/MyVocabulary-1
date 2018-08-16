//
//  LessonOptionViewController.swift
//  MyVocabulary
//
//  Created by Ondrej Andrysek on 5/20/18.
//  Copyright © 2018 Ondrej Andrysek. All rights reserved.
//

import UIKit
import RealmSwift

enum LessonNavigation{
    case practice
    case quiz
    case quizForeign
    case test
    case testForeign
}

protocol LessonOptionViewControllerDelegate: class{
    func controllerDidFinish(navigation: LessonNavigation)
}

class LessonOptionViewController: UIViewController {

    var viewPractice: LessonView!
    var viewQuiz: LessonView!
    var viewQuizForeign: LessonView!
    var viewTest: LessonView!
    var viewTestForeign: LessonView!

    private var viewModel: LessonOptionViewModel!
    weak var delegate: LessonOptionViewControllerDelegate?
    
    init(viewModel: LessonOptionViewModel){
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        initViews()
        initConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        refreshViews()
    }
    
    private func initViews(){
        let lesson = viewModel.getLesson()
        
        viewPractice = LessonView()
        viewPractice.titleLabel.text = "Practice"
        viewPractice.progressLabel.text = ""
        viewPractice.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(navigatePractice)))
        view.addSubview(viewPractice)
        
        viewQuiz = LessonView()
        viewQuiz.titleLabel.text = "Quiz"
        viewQuiz.progressLabel.text = "\(lesson.quizCompleted)%"
        viewQuiz.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(navigateQuiz)))
        view.addSubview(viewQuiz)
        
        viewQuizForeign = LessonView()
        viewQuizForeign.titleLabel.text = "Quiz foreign"
        viewQuizForeign.progressLabel.text = "\(lesson.quizForeignCompleted)%"
        viewQuizForeign.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(navigateQuizForeign)))
        view.addSubview(viewQuizForeign)
        
        viewTest = LessonView()
        viewTest.titleLabel.text = "Test"
        viewTest.progressLabel.text = "\(lesson.testCompleted)%"
        viewTest.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(navigateTest)))
        view.addSubview(viewTest)
        
        viewTestForeign = LessonView()
        viewTestForeign.titleLabel.text = "Test foreign"
        viewTestForeign.progressLabel.text = "\(lesson.testForeignCompleted)%"
        viewTestForeign.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(navigateTestForeign)))
        view.addSubview(viewTestForeign)
    }
    
    private func initConstraints(){
        viewPractice.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(100)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
        }
        viewQuiz.snp.makeConstraints { (make) in
            make.top.equalTo(viewPractice.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
        }
        viewQuizForeign.snp.makeConstraints { (make) in
            make.top.equalTo(viewQuiz.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
        }
        viewTest.snp.makeConstraints { (make) in
            make.top.equalTo(viewQuizForeign.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
        }
        viewTestForeign.snp.makeConstraints { (make) in
            make.top.equalTo(viewTest.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
        }
    }
    
    private func refreshViews(){
        viewModel.reloadLesson()
        let lesson = viewModel.getLesson()
        viewQuiz.progressLabel.text = "\(lesson.quizCompleted)%"
        viewQuizForeign.progressLabel.text = "\(lesson.quizForeignCompleted)%"
        viewTest.progressLabel.text = "\(lesson.testCompleted)%"
        viewTestForeign.progressLabel.text = "\(lesson.testForeignCompleted)%"
    }
    
    @objc private func navigatePractice(){
       delegate?.controllerDidFinish(navigation: .practice)
    }
    
    @objc private func navigateQuiz(){
        delegate?.controllerDidFinish(navigation: .quiz)
    }
    
    @objc private func navigateQuizForeign(){
        delegate?.controllerDidFinish(navigation: .quizForeign)
    }
    
    @objc private func navigateTest(){
        delegate?.controllerDidFinish(navigation: .test)
    }
    
    @objc private func navigateTestForeign(){
        delegate?.controllerDidFinish(navigation: .testForeign)
    }
}
