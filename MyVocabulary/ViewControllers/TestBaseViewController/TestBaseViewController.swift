//
//  TestBaseViewController.swift
//  MyVocabulary
//
//  Created by Ondrej Andrysek on 5/20/18.
//  Copyright © 2018 Ondrej Andrysek. All rights reserved.
//

import UIKit
import RealmSwift

enum Testbase: Int{
    case quizOwnToForeign = 0
    case quizForeignToOwn = 1
    case testOwnToForeign = 2
    case testForeignToOwn = 3
}

class TestBaseViewController: UIViewController {

    let progressView = UIProgressView(progressViewStyle: .bar)
    var scoreLabel = UILabel()
    var wordLabel = UILabel()
    var resultLabel = UILabel()
    
    var viewModel: TestBaseViewModel!
    
    init(viewModel: TestBaseViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    internal func initLabels(){
        
        view.addSubview(progressView)
        progressView.trackTintColor = .lightGray
        progressView.progressTintColor = UIColor.appBlue
        
        scoreLabel.text = "score"
        scoreLabel.textAlignment = .center
        view.addSubview(scoreLabel)
        
        wordLabel.text = "word"
        wordLabel.textAlignment = .center
        view.addSubview(wordLabel)
        
        resultLabel.text = ""
        resultLabel.textAlignment = .center
        view.addSubview(resultLabel)
    }
    
    internal func initConstraints(){
        
        progressView.snp.makeConstraints { (make) in
            make.top.equalTo(100)
            make.centerX.equalToSuperview()
            make.width.equalTo(140)
        }
        
        scoreLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(120)
            make.centerX.equalToSuperview()
        }
        wordLabel.snp.makeConstraints { (make) in
            make.top.equalTo(scoreLabel.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }
        
        resultLabel.snp.makeConstraints { (make) in
            make.top.equalTo(wordLabel.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }
    }
    
    func showAlert(score: Int){
        let alertController = UIAlertController(title: "Result", message: "You have completed \(score)%", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
