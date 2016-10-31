//
//  EditMeme.swift
//  MemeGenerator
//
//  Created by Susan Zheng on 10/31/16.
//  Copyright © 2016 Susan Zheng. All rights reserved.
//

import UIKit
import AssetsLibrary
import SystemConfiguration
import AVFoundation


class EditMeme: UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var memeImage: UIImageView!
    @IBOutlet weak var memeLabel: UILabel!
    @IBOutlet weak var editTextField: UITextField!
    @IBOutlet weak var textSlider: UISlider!
    @IBOutlet weak var colorSilder: UISlider!
    
    var selectedMeme : meme?
    
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
        
        self.memeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.textViewTouched = UIGestureRecognizer(target: self, action: #selector(EditMeme.touchesBegan(_:with:)))
        
        self.memeLabel.addGestureRecognizer(textViewTouched)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "righticon (2).png"), style: .done, target: self, action: #selector(EditMeme.saveMeme))
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "customBackButton (1).png"), style: .done, target: self, action: #selector(EditMeme.backButtonPressed(sender:)))
    }
    
    
    func backButtonPressed(sender:UIButton)
    {
        navigationController?.popViewController(animated: true)
    }
    
    func saveMeme()
    {
        let scale = UIScreen.main.scale
        let layer = UIApplication.shared.keyWindow!.layer
         self.navigationController?.isNavigationBarHidden = true
        
        UIGraphicsBeginImageContextWithOptions(CGRect(x:0, y: 50, width: self.view.frame.width, height: self.view.frame.height - 200).size, false, scale)
        
        layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
        
       self.navigationController?.isNavigationBarHidden = false
        
        
         let saveMemeAlertController = UIAlertController(title: "Meme Saved to Photo Library", message: "Check your photo library for your awesome meme!", preferredStyle: .alert)
         
         self.present(saveMemeAlertController, animated: true, completion: nil)
         
         DispatchQueue.main.async { () -> Void in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(1.2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: { () -> Void in
                saveMemeAlertController.dismiss(animated: true, completion: nil)
            })
         }
        
    }
    
    
    
    @IBAction func colorSliderAction(_ sender: AnyObject)
    {
        let colorValue = CGFloat(colorSilder.value)
        let color = UIColor(hue: colorValue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        
        self.colorSilder.minimumTrackTintColor = color
        self.colorSilder.maximumTrackTintColor = color
        self.colorSilder.minimumTrackTintColor = color
        self.colorSilder.maximumTrackTintColor = color
        self.memeLabel.textColor = color
        
        if colorSilder.value == 0
        {
            self.memeLabel.textColor = UIColor.white
            self.colorSilder.minimumTrackTintColor = UIColor.white
            self.colorSilder.maximumTrackTintColor = UIColor.white
        }
        if colorSilder.value == 1
        {
            self.memeLabel.textColor = UIColor.black
            self.colorSilder.minimumTrackTintColor = UIColor.black
            self.colorSilder.maximumTrackTintColor = UIColor.black
        }
    }
    
    @IBAction func textSizeSlider(_ sender: AnyObject)
    {
        self.memeLabel.font = UIFont.systemFont(ofSize: CGFloat(textSlider.value))
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        self.memeLabel.text = editTextField.text
        self.memeImage.addSubview(memeLabel)
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let touch : UITouch = touches.first as UITouch!
        location = touch.location(in: self.view)
        memeLabel.center = location
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let touch : UITouch = touches.first as UITouch!
        location = touch.location(in: self.view)
        memeLabel.center = location
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
