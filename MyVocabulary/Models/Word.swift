//
//  Dictionary.swift
//  MyVocabulary
//
//  Created by Ondrej Andrysek on 5/17/18.
//  Copyright © 2018 Ondrej Andrysek. All rights reserved.
//

import Foundation
import RealmSwift

class Word: Object{
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var lessonID = ""
    @objc dynamic var word = ""
    @objc dynamic var foreignWord = ""
    //LEARNED STATE 0 = not learned, 1 = learned
    @objc dynamic var learnedStateQuiz = 0
    @objc dynamic var learnedStateQuizForeign = 0
    @objc dynamic var learnedStateTest = 0
    @objc dynamic var learnedStateTestForeign = 0
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(lessonID: String, word: String, foreignWord: String){
        self.init()
        self.lessonID = lessonID
        self.word = word
        self.foreignWord = foreignWord
        self.learnedStateQuiz = 0
        self.learnedStateQuizForeign = 0
        self.learnedStateTest = 0
        self.learnedStateTestForeign = 0
    }
    
    convenience init(lessonID: String, word: String, foreignWord: String, learnedStateQuiz: Int, learnedStateQuizForeign: Int, learnedStateTest: Int, learnedStateTestForeign: Int){
        self.init()
        self.lessonID = lessonID
        self.word = word
        self.foreignWord = foreignWord
        self.learnedStateQuiz = learnedStateQuiz
        self.learnedStateQuizForeign = learnedStateQuizForeign
        self.learnedStateTest = learnedStateTest
        self.learnedStateTestForeign = learnedStateTestForeign
    }
}
