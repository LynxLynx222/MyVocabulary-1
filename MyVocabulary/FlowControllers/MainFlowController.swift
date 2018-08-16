//
//  MainFlowController.swift
//  MyVocabulary
//
//  Created by Ondrej Andrysek on 8/5/18.
//  Copyright © 2018 Ondrej Andrysek. All rights reserved.
//

import Foundation
import UIKit

class MainFlowController{
    
    var navigationController: UINavigationController!
    var language: Language?
    var lesson: Lesson?
    
    required init(_ navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func showLessons(){
        guard let language = self.language else {return}
        let viewModel = LessonsViewModel(language: language)
        let viewController = LessonsViewController(viewModel: viewModel)
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showLessonOption(){
        guard let lesson = self.lesson else {return}
        let viewModel = LessonOptionViewModel(lesson: lesson)
        let viewController = LessonOptionViewController(viewModel: viewModel)
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showPractice(){
        guard let lesson = self.lesson else {return}
        let viewModel = PracticeViewModel(lesson: lesson)
        let viewController = PracticeViewController(viewModel: viewModel)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func showQuiz(){
        guard let lesson = self.lesson else {return}
        let viewModel = TestBaseViewModel(base: .quizOwnToForeign, lesson: lesson)
        let viewController = QuizViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showQuizForeign(){
        guard let lesson = self.lesson else {return}
        let viewModel = TestBaseViewModel(base: .quizForeignToOwn, lesson: lesson)
        let viewController = QuizViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showTest(){
        guard let lesson = self.lesson else {return}
        let viewModel = TestBaseViewModel(base: .testOwnToForeign, lesson: lesson)
        let viewController = TestViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showTestForeign(){
        guard let lesson = self.lesson else {return}
        let viewModel = TestBaseViewModel(base: .testForeignToOwn, lesson: lesson)
        let viewController = TestViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension MainFlowController: LanugagesViewControllerDelegate{
    func controllerDidFinishWithLanguage(language: Language) {
        self.language = language
        showLessons()
    }
}

extension MainFlowController: LessonsViewControllerDelegate{
    func controllerDidFinishWithLesson(lesson: Lesson) {
        self.lesson = lesson
        showLessonOption()
    }
}

extension MainFlowController: LessonOptionViewControllerDelegate{
    func controllerDidFinish(navigation: LessonNavigation) {
        switch navigation {
        case .practice:
            showPractice()
        case .quiz:
            showQuiz()
        case .quizForeign:
            showQuizForeign()
        case .test:
            showTest()
        case .testForeign:
            showTestForeign()
        }
    }
}
