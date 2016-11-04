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


class EditMeme: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    @IBOutlet weak var memeImage: UIImageView!
    @IBOutlet weak var memeLabel: UILabel!
    @IBOutlet weak var editTextField: UITextField!
    @IBOutlet weak var textSlider: UISlider!
    @IBOutlet weak var colorSilder: UISlider!
    @IBOutlet weak var usePhotoLibraryOutlet: UIButton!
    @IBOutlet weak var useCameraOutlet: UIButton!
    @IBOutlet weak var changeColorLabel: UILabel!
    @IBOutlet weak var changeFontSizeLabel: UILabel!
    @IBOutlet weak var secondTextField: UITextField!
    
    @IBOutlet weak var secondMemeLabel: UILabel!
    var selectedMeme : meme?
    var textViewTouched = UIGestureRecognizer()
    var location = CGPoint(x: 0, y: 0)
    let imagePicker = UIImagePickerController()
    
    
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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(EditMeme.tap(_:)))
        view.addGestureRecognizer(tapGesture)
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "righticon (2).png"), style: .done, target: self, action: #selector(EditMeme.saveMeme))
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "customBackButton (1).png"), style: .done, target: self, action: #selector(EditMeme.backButtonPressed(sender:)))
        
        self.useCameraOutlet.layer.borderWidth = 1
        self.useCameraOutlet.layer.borderColor = UIColor.white.cgColor
        self.useCameraOutlet.layer.cornerRadius = 10
        self.useCameraOutlet.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        
        self.usePhotoLibraryOutlet.layer.borderWidth = 1
        self.usePhotoLibraryOutlet.layer.borderColor = UIColor.white.cgColor
        self.usePhotoLibraryOutlet.layer.cornerRadius = 10
        self.usePhotoLibraryOutlet.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        
        if self.memeImage.image == nil
        {
            print("theres no image")
            self.title = "Create your own meme!"
            self.colorSilder.isHidden = true
            self.textSlider.isHidden = true
            self.editTextField.isHidden = true
            self.changeColorLabel.isHidden = true
            self.changeFontSizeLabel.isHidden = true
            self.useCameraOutlet.isHidden = false
            self.usePhotoLibraryOutlet.isHidden = false
        }
        else if self.memeImage.image != nil
        {
            print("theres an image")
            self.useCameraOutlet.isHidden = true
            self.usePhotoLibraryOutlet.isHidden = true
            self.colorSilder.isHidden = false
            self.textSlider.isHidden = false
            self.editTextField.isHidden = false
            self.changeColorLabel.isHidden = false
            self.changeFontSizeLabel.isHidden = false
        }
        
    }
    
    @IBAction func useCameraRollAction(_ sender: AnyObject)
    {
        getToCameraRoll()
    }
    
    
    @IBAction func usePhotoLibraryAction(_ sender: AnyObject)
    {
        getToPhotoLibrary()
    }
    

    func getToCameraRoll()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
        {
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.delegate = self
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func getToPhotoLibrary()
    {
        
        let imagePicked = UIImagePickerController()
        imagePicked.delegate = self
        imagePicked.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicked.allowsEditing = false
            
        self.present(imagePicked, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        let photoInfo = info as NSDictionary
        
        let img: UIImage = photoInfo.object(forKey: UIImagePickerControllerOriginalImage) as! UIImage
        
        self.memeImage.image = img
        
        self.dismiss(animated: true, completion: nil)
        
        self.useCameraOutlet.isHidden = true
        self.usePhotoLibraryOutlet.isHidden = true
        
        self.colorSilder.isHidden = false
        self.textSlider.isHidden = false
        self.editTextField.isHidden = false
        self.changeColorLabel.isHidden = false
        self.changeFontSizeLabel.isHidden = false
        self.useCameraOutlet.isHidden = true
        self.usePhotoLibraryOutlet.isHidden = true
    }
    
    func tap(_ gesture: UITapGestureRecognizer)
    {
        self.editTextField.resignFirstResponder()
    }
    

    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        self.dismiss(animated: true, completion: nil)
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
        
        UIGraphicsBeginImageContextWithOptions(CGRect(x:0, y: 100, width: self.view.frame.width, height: self.view.frame.height - 210).size, false, scale)
        
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
        self.editTextField.resignFirstResponder()
        
        return true
    }
    
    @IBAction func memeTextField(_ sender: AnyObject)
    {
        self.memeLabel.text = editTextField.text
    }
    
    @IBAction func secondMemeTextField(_ sender: AnyObject)
    {
        self.secondMemeLabel.text = secondTextField.text
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let touch : UITouch = touches.first as UITouch!
        location = touch.location(in: self.view)
        memeLabel.center = location
     
    }
    

}
