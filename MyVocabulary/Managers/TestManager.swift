//
//  TestManager.swift
//  MyVocabulary
//
//  Created by Ondrej Andrysek on 6/16/18.
//  Copyright © 2018 Ondrej Andrysek. All rights reserved.
//

import Foundation
import RealmSwift
class TestManager{
    static func getWords(base: Testbase, lessonId: String) -> [Word]{
        var words = [Word]()
        let realm = try! Realm()
        let result = realm.objects(Word.self).filter(NSPredicate(format: "lessonID = %@", lessonId ))
        for i in result{
            words.append(i)
        }
        words.shuffle()
        switch base{
        case .quizOwnToForeign:
            words = words.sorted(by: { $0.learnedStateQuiz < $1.learnedStateQuiz })
        case .quizForeignToOwn:
            words = words.sorted(by: { $0.learnedStateQuizForeign < $1.learnedStateQuizForeign })
        case .testOwnToForeign:
            words = words.sorted(by: { $0.learnedStateTest < $1.learnedStateTest })
        case .testForeignToOwn:
            words = words.sorted(by: { $0.learnedStateTestForeign < $1.learnedStateTestForeign })
        }
        words = Array(words.prefix(upTo: 20))
        words.shuffle()
        return words
    }
    
    static func getAllLessonWords(lessonId: String) -> [Word]{
        var words = [Word]()
        let realm = try! Realm()
        let result = realm.objects(Word.self).filter(NSPredicate(format: "lessonID = %@", lessonId ))
        for i in result{
            words.append(i)
        }
        return words
    }
    
    static func getWordResult(correct: Bool, state: Int) -> Int{
        var learnedState = 0
        if correct{
            if state == 1{
                learnedState = 2
            }
            else if state == 0 || state == 2{
                learnedState = 3
            }
        }
        else{
            learnedState = 1
        }
        return learnedState
    }

    
    static func finishTest(base: Testbase, words: [Word]){
        
    }
}
