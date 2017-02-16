//
//  ViewController.swift
//  SwiftFPSDemo
//
//  Created by Evan on 2017/2/15.
//  Copyright © 2017年 Evan. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    fileprivate let cellReuseId = "cellId"
    fileprivate var fpsCounter: FPSCounter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTitleView()
        configFPSCounter()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    fileprivate func configTitleView() {
        let size = CGSize(width: 80, height: 24)
        let titleView = CrossFadeTitleView(frame: CGRect(origin: CGPoint.zero, size: size))
        navigationItem.titleView = titleView
    }

    fileprivate func configFPSCounter() {
        fpsCounter = FPSCounter()
        fpsCounter?.delegate = self
    }

    fileprivate func operationCostTime() {
        let _ = (1...9999).map {
            pow(Decimal($0), 10)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 

}


//MARK: - FPSCounterProtocol
extension ViewController: FPSCounterProtocol {
    func fpsCounter(_ counter: FPSCounter, didChangeFPS toValue: Double) {
        let newFPSText = String(format: "FPS: %02.1lf", toValue)
        (navigationItem.titleView as? CrossFadeTitleView)?.show(text: newFPSText)
    }
}

//MARK: - UITableViewDataSource
extension ViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 999
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        operationCostTime()
        return cell
    }
}


//MARK: - UITableViewDelegate
extension ViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)")
    }
}
