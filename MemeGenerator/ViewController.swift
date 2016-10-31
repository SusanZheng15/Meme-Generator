//
//  ViewController.swift
//  MemeGenerator
//
//  Created by Flatiron School on 10/27/16.
//  Copyright © 2016 Susan Zheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let api = APIClient()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        api.getMemeInfo { (dictionary) in
            print(dictionary)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

