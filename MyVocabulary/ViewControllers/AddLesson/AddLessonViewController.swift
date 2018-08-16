//
//  AddLessonViewController.swift
//  MyVocabulary
//
//  Created by Ondrej Andrysek on 8/5/18.
//  Copyright © 2018 Ondrej Andrysek. All rights reserved.
//

import UIKit

class AddLessonViewController: UIViewController {

    let dismissButton = UIButton()
    let filenameLabel = UILabel()
    let changeButton = UIButton()
    let wordsCountLabel = UILabel()
    let checkDiacriticsSwitch = SwitchView()
    let isAlphabetSwitch = SwitchView()
    let addButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addSubviews()
        setupSubviews()
        setupConstraints()
    }
    
    private func addSubviews(){
        [dismissButton, filenameLabel, changeButton, wordsCountLabel, checkDiacriticsSwitch, isAlphabetSwitch, addButton].forEach(view.addSubview(_:))
    }
    
    private func setupSubviews(){
        view.backgroundColor = .white
        
        dismissButton.setTitle("Cancel", for: .normal)
        dismissButton.setTitleColor(.appBlue, for: .normal)
        dismissButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        
        filenameLabel.text = "file.csv"
        
        changeButton.setTitle("Change", for: .normal)
        changeButton.setTitleColor(.appBlue, for: .normal)
        changeButton.contentHorizontalAlignment = .trailing
        
        wordsCountLabel.textColor = .darkGray
        wordsCountLabel.font = UIFont.systemFont(ofSize: 14)
        wordsCountLabel.text = "50 words"
        
        checkDiacriticsSwitch.titleLabel.text = "Ignore capital letters"
        checkDiacriticsSwitch.descriptionLabel.text = "i.e. Hello can be written as hello"
        
        isAlphabetSwitch.titleLabel.text = "Imported file is alphabet"
        isAlphabetSwitch.descriptionLabel.text = "Alphabet will have adjusted layout and quiz only"
        
        addButton.setTitle("Add", for: .normal)
        addButton.setTitleColor(.appBlue, for: .normal)
    }
    
    private func setupConstraints(){
        dismissButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(24)
            make.leading.equalToSuperview().offset(8)
        }
        
        filenameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(80)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(30)
        }
        
        changeButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(filenameLabel)
            make.height.equalTo(30)
            make.width.equalTo(80)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        wordsCountLabel.snp.makeConstraints { (make) in
            make.top.equalTo(filenameLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        checkDiacriticsSwitch.snp.makeConstraints { (make) in
            make.top.equalTo(wordsCountLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(60)
        }
        
        isAlphabetSwitch.snp.makeConstraints { (make) in
            make.top.equalTo(checkDiacriticsSwitch.snp.bottom)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(60)
        }
        addButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-40)
            make.width.equalTo(140)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc private func dismissViewController(){
        self.dismiss(animated: true, completion: nil)
    }

}
