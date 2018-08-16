//
//  RoundedButton.swift
//  MyVocabulary
//
//  Created by Ondrej Andrysek on 7/29/18.
//  Copyright © 2018 Ondrej Andrysek. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 22)
        layer.cornerRadius = 25
        backgroundColor = .appBlue
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
