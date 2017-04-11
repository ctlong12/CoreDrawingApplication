//
//  ViewController.swift
//  DrawingApp
//
//  Created by Chandler on 4/10/17.
//  Copyright © 2017 C-LongDev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(DrawingView(frame: view.frame))
    }
}

