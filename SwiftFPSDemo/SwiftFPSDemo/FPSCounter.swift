//
//  FPSCounter.swift
//  SwiftFPSDemo
//
//  Created by Evan on 2017/2/15.
//  Copyright © 2017年 Evan. All rights reserved.
//

import Foundation
import QuartzCore


protocol FPSCounterProtocol: class {
    func fpsCounter(_ counter: FPSCounter,didChangeFPS toValue: Double)
}

class FPSCounter {
    fileprivate var lastTimestamp: CFTimeInterval = 0
    fileprivate var frameCount = 0
    
    weak var delegate: FPSCounterProtocol?
    
    fileprivate var displayLink: CADisplayLink?

    //MARK: - Init Method
    init() {
        displayLink = CADisplayLink(target: self, selector: #selector(displayDidSync(link:)))
        displayLink?.isPaused = true
        displayLink?.add(to: RunLoop.main, forMode: .commonModes)
        displayLink?.isPaused = false
    }

    deinit {
        displayLink?.isPaused = true
        displayLink?.remove(from: RunLoop.main, forMode: .commonModes)
    }
    
    //MARK: -
    @objc func displayDidSync(link: CADisplayLink) {
        if lastTimestamp == 0 {
            lastTimestamp = link.timestamp
            return
        }
        frameCount += 1
        let deltaTimestamp = link.timestamp - lastTimestamp
        if deltaTimestamp >= 1 {
            let fps = Double(frameCount) / deltaTimestamp
            delegate?.fpsCounter(self, didChangeFPS: fps)
            lastTimestamp = link.timestamp
            frameCount = 0
        }
    }
    
    
}
