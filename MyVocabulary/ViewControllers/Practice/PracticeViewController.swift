//
//  PracticeViewController.swift
//  MyVocabulary
//
//  Created by Ondrej Andrysek on 5/18/18.
//  Copyright © 2018 Ondrej Andrysek. All rights reserved.
//

import UIKit
import RealmSwift

enum Side{
    case left
    case right
}

class Hidden{
    var hidden: Bool
    var side: Side
    
    init(){
        hidden = false
        side = .left
    }
}

class PracticeViewController: UIViewController {

    var topView: UIView!
    var hideLeftButton: UIButton!
    var hideRightButton: UIButton!
    var tableView: UITableView!
    
    private var viewModel: PracticeViewModel!
    
    init(viewModel: PracticeViewModel){
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.viewModel.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initTopView()
        initTableView()
        initConstraints()
    }
    
    private func initTopView(){
        hideLeftButton = UIButton()
        hideLeftButton.setTitle("Hide", for: .normal)
        hideLeftButton.setTitleColor(.black, for: .normal)
        hideLeftButton.addTarget(self, action: #selector(hideLeftSide), for: .touchUpInside)
        
        hideRightButton = UIButton()
        hideRightButton.setTitle("Hide", for: .normal)
        hideRightButton.setTitleColor(.black, for: .normal)
        hideRightButton.addTarget(self, action: #selector(hideRightSide), for: .touchUpInside)
        
        topView = UIView()
        topView.backgroundColor = .white
        topView.addSubview(hideLeftButton)
        topView.addSubview(hideRightButton)
        view.addSubview(topView)
    }
    
    private func initTableView(){
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(PracticeTableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
    }
    
    private func initConstraints(){
        topView.snp.makeConstraints { (make) in
            make.height.equalTo(80)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(60)
        }
        hideLeftButton.snp.makeConstraints { (make) in
            make.left.equalTo(topView).offset(24)
            make.width.equalTo(80)
            make.centerY.equalTo(topView)
        }
        hideRightButton.snp.makeConstraints { (make) in
            make.right.equalTo(topView).offset(-24)
            make.width.equalTo(80)
            make.centerY.equalTo(topView)
        }
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    @objc private func hideLeftSide(){
        viewModel.hideSide(side: .left)
    }
    
    @objc private func hideRightSide(){
        viewModel.hideSide(side: .right)
    }
}

extension PracticeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getWordsCount()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PracticeTableViewCell
        cell.selectionStyle = .none
        let item = viewModel.getWord(row: indexPath.row)
        if item.1.hidden{
            switch item.1.side{
            case .left:
                cell.leftLabel.text = "---"
                cell.rightLabel.text = item.0.foreignWord
            case .right:
                cell.leftLabel.text = item.0.word
                cell.rightLabel.text = "---"
            }
        }
        else{
            cell.leftLabel.text = item.0.word
            cell.rightLabel.text = item.0.foreignWord
        }
        
        return cell
    }
}

extension PracticeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.showRow(row: indexPath.row)
    }
}

extension PracticeViewController: PracticeViewModelDelegate{
    func reloadTableView() {
        tableView.reloadData()
    }
}
