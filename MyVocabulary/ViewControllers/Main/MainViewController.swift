//
//  MainViewController.swift
//  MyVocabulary
//
//  Created by Ondrej Andrysek on 5/7/18.
//  Copyright © 2018 Ondrej Andrysek. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var practiceButton: UIButton!
    var tutorialButton: UIButton!
    var optionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appBlue
        initButtons()
        initConstraints()
    }
    
    private func initButtons(){
        practiceButton = UIButton()
        practiceButton.setTitle("Practice", for: .normal)
        practiceButton.setTitleColor(.white, for: .normal)
        practiceButton.backgroundColor = .clear
        practiceButton.layer.cornerRadius = 25
        practiceButton.layer.borderColor = UIColor.white.cgColor
        practiceButton.layer.borderWidth = 1.5
        practiceButton.addTarget(self, action: #selector(practiceButtonTapped), for: .touchUpInside)
        view.addSubview(practiceButton)
        
        tutorialButton = UIButton()
        tutorialButton.setTitle("How to import", for: .normal)
        tutorialButton.setTitleColor(.white, for: .normal)
        tutorialButton.backgroundColor = .clear
        tutorialButton.layer.cornerRadius = 25
        tutorialButton.layer.borderColor = UIColor.white.cgColor
        tutorialButton.layer.borderWidth = 1.5
        tutorialButton.addTarget(self, action: #selector(tutorialButtonTapped), for: .touchUpInside)
        view.addSubview(tutorialButton)
        
        optionButton = UIButton()
        optionButton.setTitle("Options", for: .normal)
        optionButton.setTitleColor(.white, for: .normal)
        optionButton.backgroundColor = .clear
        optionButton.layer.cornerRadius = 25
        optionButton.layer.borderColor = UIColor.white.cgColor
        optionButton.layer.borderWidth = 1.5
        optionButton.addTarget(self, action: #selector(optionButtonTapped), for: .touchUpInside)
        view.addSubview(optionButton)
    }
    
    private func initConstraints(){
        practiceButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(120)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(200)
        }
        
        tutorialButton.snp.makeConstraints { (make) in
            make.top.equalTo(practiceButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(200)
        }
        
        optionButton.snp.makeConstraints { (make) in
            make.top.equalTo(tutorialButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(200)
        }
    }
    
    @objc private func practiceButtonTapped(){
//        let viewModel
//        let controller = LessonsViewController()
//        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc private func tutorialButtonTapped(){
        
    }
    
    @objc private func optionButtonTapped(){
        
    }

}
