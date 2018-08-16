//
//  RectangleButton.swift
//  MyVocabulary
//
//  Created by Ondrej Andrysek on 7/29/18.
//  Copyright © 2018 Ondrej Andrysek. All rights reserved.
//

import UIKit

class RectangleButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        clipsToBounds = true
        backgroundColor = .appBlue
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
