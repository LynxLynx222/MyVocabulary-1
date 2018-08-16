//
//  TestBaseViewModel.swift
//  MyVocabulary
//
//  Created by Ondrej Andrysek on 7/26/18.
//  Copyright © 2018 Ondrej Andrysek. All rights reserved.
//

import Foundation
import RealmSwift

enum Translation{
    case ownToForeign
    case foreignToOwn
}

protocol TestBaseViewModelDelegate: class{
    func setWordToTranslate(wordToTranslate: String)
    func setButtons(words: [String])
    func passResult(result: Bool, progress: Float, correctWord: String)
    func showResultAlert(score: Int)
}

class TestBaseViewModel{
    
    var words = [Word]()
    var allLessonWords = [Word]()
    var lesson: Lesson!
    var wordToTranslate = ""
    var translatedWord = ""
    var round = 0
    var score = 0
    
    var base: Testbase = .testOwnToForeign
    var translation: Translation = .ownToForeign
    weak var delegate: TestBaseViewModelDelegate?
    
    init(base: Testbase, lesson: Lesson) {
        words = TestManager.getWords(base: base, lessonId: lesson.id)
        self.lesson = lesson
        self.base = base
        if base == .quizOwnToForeign || base == .testOwnToForeign{
            translation = .ownToForeign
        }
        else{
            translation = .foreignToOwn
        }
        if base == .quizOwnToForeign || base == .quizForeignToOwn{
            allLessonWords = TestManager.getAllLessonWords(lessonId: lesson.id)
        }
    }
    
    func setQuiz(){
        switch translation {
        case .ownToForeign:
             wordToTranslate = words[round].word
             translatedWord = words[round].foreignWord
            delegate?.setWordToTranslate(wordToTranslate: words[round].word)
        case .foreignToOwn:
             wordToTranslate = words[round].foreignWord
             translatedWord = words[round].word
            delegate?.setWordToTranslate(wordToTranslate: words[round].foreignWord)
        }
        if base == .quizOwnToForeign || base == .quizForeignToOwn{
            setButtons()
        }
    }
    
    func setButtons(){
        var temporaryWords = allLessonWords.filter({$0.id != words[round].id})
        var wordsToShow = [((translation == .ownToForeign) ? words[round].foreignWord : words[round].word)]
        
        for _ in 0...2{
            let randomNumber = Int(arc4random_uniform(UInt32(temporaryWords.count)))
            let word = temporaryWords[randomNumber]
            (translation == .ownToForeign) ? wordsToShow.append(word.foreignWord) : wordsToShow.append(word.word)
            temporaryWords.remove(at: randomNumber)
        }
        wordsToShow.shuffle()
        delegate?.setButtons(words: wordsToShow)
    }
    
    func checkAnswer(answer: String){
        if answer != translatedWord{
            words.append(words[round])
        }
        else{
            let realm = try! Realm()
            switch base{
            case .testOwnToForeign:
                try! realm.write {
                    words[round].learnedStateTest = 1
                }
            case .testForeignToOwn:
                try! realm.write {
                    words[round].learnedStateTestForeign = 1
                }
            case .quizOwnToForeign:
                try! realm.write {
                    words[round].learnedStateQuiz = 1
                }
            case .quizForeignToOwn:
                try! realm.write {
                    words[round].learnedStateQuizForeign = 1
                }
            }
        }
        let result = answer == translatedWord
        score = result ? score + 1 : score
        let progress = Float(score*100/20)
        let floatProgress = progress/100
        delegate?.passResult(result: result, progress: floatProgress, correctWord: translatedWord)
        round += 1
        (round >= words.count) ? finishQuiz() : setQuiz()

    }
    
    func finishQuiz(){
        print("quiz finished")
        let allLessonWords = TestManager.getAllLessonWords(lessonId: lesson.id)
        var score = 0
        for i in allLessonWords{
            switch base{
            case .testOwnToForeign:
                score += i.learnedStateTest
            case .testForeignToOwn:
                score += i.learnedStateTestForeign
            case .quizOwnToForeign:
                print(i.learnedStateQuiz)
                score += i.learnedStateQuiz
            case .quizForeignToOwn:
                score += i.learnedStateQuizForeign
            }
        }
        print("score \(score)")
        score = Int(score*100/allLessonWords.count)
        RealmManager.shared.realm.beginWrite()
        switch base{
        case .testOwnToForeign:
            lesson.testCompleted = score
        case .testForeignToOwn:
            lesson.testForeignCompleted = score
        case .quizOwnToForeign:
            lesson.quizCompleted = score
        case .quizForeignToOwn:
            lesson.quizForeignCompleted = score
        }
        try! RealmManager.shared.realm.commitWrite()
        print("score \(score) written")
        delegate?.showResultAlert(score: score)
    }
    
    

}
