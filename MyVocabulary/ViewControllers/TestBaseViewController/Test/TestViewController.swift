//
//  TestViewController.swift
//  MyVocabulary
//
//  Created by Ondrej Andrysek on 5/20/18.
//  Copyright © 2018 Ondrej Andrysek. All rights reserved.
//

import UIKit
import RealmSwift

class TestViewController: TestBaseViewController {

    var textField: UITextField!
    var checkButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        initLabels()
        initTextField()
        initButton()
        initConstraints()
        initAdditionalConstraints()
        viewModel?.delegate = self
        viewModel?.setQuiz()
    }
    
    private func initTextField(){
        textField = UITextField()
        textField.placeholder = "Type here"
        textField.borderStyle = .roundedRect
        view.addSubview(textField)
    }
    
    private func initButton(){
        checkButton = UIButton()
        checkButton.setTitle("Check", for: .normal)
        checkButton.setTitleColor(.white, for: .normal)
        checkButton.addTarget(self, action: #selector(checkAnswer), for: .touchUpInside)
        checkButton.layer.cornerRadius = 25
        checkButton.backgroundColor = .appBlue
        view.addSubview(checkButton)
    }
    
    private func initAdditionalConstraints(){
        textField.snp.makeConstraints { (make) in
            make.top.equalTo(resultLabel.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().inset(40)
            make.height.equalTo(40)
        }
        
        checkButton.snp.makeConstraints { (make) in
            make.top.equalTo(textField.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.width.equalTo(140)
            make.height.equalTo(50)
        }
    }
    
    @objc private func checkAnswer(){
        guard let text = textField.text else {return}
        viewModel?.checkAnswer(answer: text)
    }
}

extension TestViewController: TestBaseViewModelDelegate{
    func setWordToTranslate(wordToTranslate: String) {
        wordLabel.text = wordToTranslate
    }
    
    func setButtons(words: [String]) {
        
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
