//
//  LessonsViewModel.swift
//  MyVocabulary
//
//  Created by Ondrej Andrysek on 8/5/18.
//  Copyright © 2018 Ondrej Andrysek. All rights reserved.
//

import Foundation
import RealmSwift

protocol LessonsViewModelDelegate: class{
    func reloadTableView()
}

class LessonsViewModel{
    
    weak var delegate: LessonsViewModelDelegate?
    
    private var language: Language!
    private var lessons = [Lesson]()
    private var pickedLesson = ""
    
    init(language: Language){
        self.language = language
    }
    
    func getLessonsCount() -> Int{
        return lessons.count
    }
    
    func getLesson(row: Int) -> Lesson{
        return lessons[row]
    }
    
    func getLessons(){
        let realm = try! Realm()
        let result = realm.objects(Lesson.self).filter(NSPredicate(format: "languageID = %@", language.id))
        lessons.removeAll()
        for i in result{
            lessons.append(i)
        }
        delegate?.reloadTableView()
    }
    
    func getLanguageID() -> String{
        return language.id
    }
    
    func buttonAction(lesson: Lesson, words: [Word]){
        var isAlphabet = true
        for i in words{
            if i.foreignWord.count > 4 || i.word.count > 4{
                isAlphabet = false
                break
            }
        }
        lesson.isAlphabet = isAlphabet
        lesson.numberOfWords = words.count
        self.lessons.append(lesson)
        delegate?.reloadTableView()
        RealmManager.shared.write(item: lesson)
        self.createLesson(words: words)
        
        let realm = try! Realm()
        try! realm.write {
            language.numberOfLessons += 1
        }
    }
    
    func calculateCompleted(lesson: Lesson) -> Int{
        var value = lesson.quizCompleted + lesson.quizForeignCompleted + lesson.testCompleted + lesson.testForeignCompleted
        value = Int(Float(value)/4)
        return value
    }
    
    private func createLesson(words: [Word]){
        for i in words{
            RealmManager.shared.write(item: i)
        }
    }
}
