//
//  PopUpButton.swift
//  CreativityTrial
//
//  Created by Olajide Osho on 03/07/2021.
//

import UIKit

class PopUpButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }

    func setupButton(){
        self.backgroundColor = .red
        self.setTitleColor(.white, for: .normal)
        self.layer.cornerRadius = frame.height / 2
    }
}
