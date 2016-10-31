//
//  EditMeme.swift
//  MemeGenerator
//
//  Created by Flatiron School on 10/31/16.
//  Copyright © 2016 Susan Zheng. All rights reserved.
//

import UIKit
import AssetsLibrary
import SystemConfiguration


class EditMeme: UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var memeImage: UIImageView!
    
    var selectedMeme : meme?
    
    @IBOutlet weak var writtenTextView: UITextView!
    @IBOutlet weak var editTextField: UITextField!
    @IBOutlet weak var textSlider: UISlider!
    
    var textViewTouched = UIGestureRecognizer()
    
     var location = CGPoint(x: 0, y: 0)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.title = selectedMeme?.name
        
        self.editTextField.delegate = self

        if let data = selectedMeme?.image
        {
            self.memeImage.image = UIImage.init(data: data)
        }
        self.writtenTextView.translatesAutoresizingMaskIntoConstraints = false
        
        
        self.textViewTouched = UIGestureRecognizer(target: self, action: #selector(EditMeme.touchesBegan(_:with:)))
        
        self.writtenTextView.addGestureRecognizer(textViewTouched)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "save", style: .done, target: self, action: #selector(EditMeme.saveMeme))
        
        
    }
    
    func saveMeme()
    {
        UIImageWriteToSavedPhotosAlbum(self.memeImage.image!, self, nil, nil)
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let touch : UITouch = touches.first as UITouch!
        location = touch.location(in: self.view)
        writtenTextView.center = location
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let touch : UITouch = touches.first as UITouch!
        location = touch.location(in: self.view)
        writtenTextView.center = location
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
