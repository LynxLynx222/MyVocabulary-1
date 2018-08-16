//
//  QuizViewController.swift
//  MyVocabulary
//
//  Created by Ondrej Andrysek on 5/19/18.
//  Copyright © 2018 Ondrej Andrysek. All rights reserved.
//

import UIKit
import RealmSwift

class QuizViewController: TestBaseViewController {

    private var button1: UIButton!
    private var button2: UIButton!
    private var button3: UIButton!
    private var button4: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewModel.lesson.isAlphabet ? initAlphabetButtons() : initRoundedButtons()
        initLabels()
        initButtons()
        initConstraints()
        viewModel.lesson.isAlphabet ? initAlphabetAdditionalConstraints() : initAdditionalConstraints()
        
        viewModel?.delegate = self
        viewModel?.setQuiz()
    }
    
    private func initRoundedButtons(){
        button1 = RoundedButton()
        button2 = RoundedButton()
        button3 = RoundedButton()
        button4 = RoundedButton()
    }
    
    private func initAlphabetButtons(){
        button1 = RectangleButton()
        button2 = RectangleButton()
        button3 = RectangleButton()
        button4 = RectangleButton()
    }
    
    private func initButtons(){
        button1.addTarget(self, action: #selector(button1Tapped), for: .touchUpInside)
        view.addSubview(button1)
        button2.addTarget(self, action: #selector(button2Tapped), for: .touchUpInside)
        view.addSubview(button2)
        button3.addTarget(self, action: #selector(button3Tapped), for: .touchUpInside)
        view.addSubview(button3)
        button4.addTarget(self, action: #selector(button4Tapped), for: .touchUpInside)
        view.addSubview(button4)
    }
    
    private func initAdditionalConstraints(){
        button4.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.bottom.equalToSuperview().inset(40)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().inset(24)
        }
        button3.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.bottom.equalTo(button4.snp.top).offset(-16)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().inset(24)
        }
        button2.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.bottom.equalTo(button3.snp.top).offset(-16)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().inset(24)
        }
        button1.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.bottom.equalTo(button2.snp.top).offset(-16)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().inset(24)
        }
    }
    
    private func initAlphabetAdditionalConstraints(){
        let width = view.bounds.width * 0.5 - 12
        button4.snp.makeConstraints { (make) in
            make.width.equalTo(width)
            make.height.equalTo(width)
            make.bottom.equalToSuperview().offset(-8)
            make.right.equalToSuperview().offset(-8)
        }
        button3.snp.makeConstraints { (make) in
            make.width.equalTo(width)
            make.height.equalTo(width)
            make.bottom.equalToSuperview().offset(-8)
            make.left.equalToSuperview().offset(8)
        }
        button2.snp.makeConstraints { (make) in
            make.width.equalTo(width)
            make.height.equalTo(width)
            make.bottom.equalTo(button4.snp.top).offset(-8)
            make.right.equalToSuperview().offset(-8)
        }
        button1.snp.makeConstraints { (make) in
            make.width.equalTo(width)
            make.height.equalTo(width)
            make.bottom.equalTo(button3.snp.top).offset(-8)
            make.left.equalToSuperview().offset(8)
        }
    }

    @objc private func button1Tapped(){
        guard let text = button1.titleLabel?.text else {return}
        viewModel?.checkAnswer(answer: text)
    }

    @objc private func button2Tapped(){
        guard let text = button2.titleLabel?.text else {return}
        viewModel?.checkAnswer(answer: text)
    }

    @objc private func button3Tapped(){
        guard let text = button3.titleLabel?.text else {return}
        viewModel?.checkAnswer(answer: text)
    }

    @objc private func button4Tapped(){
        guard let text = button4.titleLabel?.text else {return}
        viewModel?.checkAnswer(answer: text)
    }

}

extension QuizViewController: TestBaseViewModelDelegate{
    func setWordToTranslate(wordToTranslate: String) {
        wordLabel.text = wordToTranslate
    }
    
    func setButtons(words: [String]) {
        button1.setTitle(words[0], for: .normal)
        button2.setTitle(words[1], for: .normal)
        button3.setTitle(words[2], for: .normal)
        button4.setTitle(words[3], for: .normal)

    }
    
    func passResult(result: Bool, progress: Float, correctWord: String) {
        progressView.progress = progress
        resultLabel.textColor = result ? .green : .red
        resultLabel.text = correctWord
    }
    
    func showResultAlert(score: Int) {
        showAlert(score: score)
    }
    
}
