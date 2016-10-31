//
//  EditMeme.swift
//  MemeGenerator
//
//  Created by Flatiron School on 10/31/16.
//  Copyright © 2016 Susan Zheng. All rights reserved.
//

import UIKit

class EditMeme: UIViewController
{
    @IBOutlet weak var memeImage: UIImageView!
    
    var selectedMeme : meme?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.title = selectedMeme?.name

        if let data = selectedMeme?.image
        {
            self.memeImage.image = UIImage.init(data: data)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
