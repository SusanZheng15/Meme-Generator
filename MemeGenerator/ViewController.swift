//
//  ViewController.swift
//  MemeGenerator
//
//  Created by Flatiron School on 10/27/16.
//  Copyright © 2016 Susan Zheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        APIClient.getMemeInfo { (dictionary) in
            print(dictionary)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

