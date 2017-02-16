//
//  CrossFadeTitleView.swift
//  SwiftFPSDemo
//
//  Created by Evan on 2017/2/15.
//  Copyright © 2017年 Evan. All rights reserved.
//

import UIKit

class CrossFadeTitleView: UIView {
    fileprivate let animationDuration = 0.4
    fileprivate var didSetupConstraints = false

    fileprivate lazy var textLabel: UILabel = {
        [unowned self] in
        let l = self.label()
        l.text = "FPS: 00.0"
        return l
    }()
    
    //MARK: - Init Method
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configView()
    }
    
    
    //MARK: - Config View
    fileprivate func configView() {
        backgroundColor = UIColor.clear
        addSubview(textLabel)
        textLabel.frame = frame
    }
    
    
    func show(text: String) {
        let newLabel = label()
        newLabel.text = text
        newLabel.alpha = 0
        newLabel.frame = textLabel.frame
        
        insertSubview(newLabel, aboveSubview: textLabel)
        
        UIView.animate(withDuration: animationDuration, delay: 0.0, options: .curveEaseOut, animations: {
            newLabel.alpha = 1
            self.textLabel.alpha = 0
        }) { (_) in
            self.textLabel.alpha = 1
            self.textLabel.text = newLabel.text
            newLabel.isHidden = true
            newLabel.removeFromSuperview()
        }
    }
    
    fileprivate func label() -> UILabel {
        let l = UILabel()
        l.font = UIFont.preferredFont(forTextStyle: .headline)
        l.textColor = .darkGray
        l.textAlignment = .center
        return l
    }
}
