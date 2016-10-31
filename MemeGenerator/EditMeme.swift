//
//  EditMeme.swift
//  MemeGenerator
//
//  Created by Flatiron School on 10/31/16.
//  Copyright © 2016 Susan Zheng. All rights reserved.
//

import UIKit

class EditMeme: UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var memeImage: UIImageView!
    
    var selectedMeme : meme?
    
    @IBOutlet weak var writtenTextView: UITextView!
    @IBOutlet weak var editTextField: UITextField!
    @IBOutlet weak var textSlider: UISlider!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.title = selectedMeme?.name
        
        self.editTextField.delegate = self

        if let data = selectedMeme?.image
        {
            self.memeImage.image = UIImage.init(data: data)
        }
     
      
    }
    @IBAction func textSizeSlider(_ sender: AnyObject)
    {
        self.writtenTextView.font = UIFont.systemFont(ofSize: CGFloat(textSlider.value))
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        self.writtenTextView.text = editTextField.text
        return true
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
