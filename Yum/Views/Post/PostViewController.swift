//
//  PostViewController.swift
//  Yum
//
//  Created by Noverish Harold on 2017. 11. 4..
//  Copyright © 2017년 Mash-up. All rights reserved.
//

import UIKit
import DKImagePickerController

class PostViewController: UIViewController, UITextViewDelegate {
    
    var image: UIImage!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var contentField: UITextView!
    @IBOutlet weak var contentPlaceholder: UILabel!
    @IBOutlet weak var calorieField: UITextField!
    @IBOutlet weak var tagField: UITextView!
    @IBOutlet weak var tagPlaceholder: UILabel!
    
    var pickerShowed = false
    var keyboardShowing = false

    override func viewDidLoad() {
        contentField.delegate = self
        tagField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backgroundTapped)))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !pickerShowed {
            let pickerController = DKImagePickerController()
            pickerController.maxSelectableCount = 1
            pickerController.didSelectAssets = { assets in
                for img in assets {
                    img.fetchOriginalImageWithCompleteBlock { (image, _) in
                        self.image = image!
                        DispatchQueue.main.async {
                            self.imageView.image = image
                        }
                    }
                }
            }
            
            present(pickerController, animated: true)
            pickerShowed = true
        }
    }
    
    @IBAction func doneClicked() {
        print("done!")
    }
    
    @IBAction func cancelClicked() {
        dismiss(animated: true, completion: nil)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView == contentField {
            contentPlaceholder.isHidden = (textView.text == "") ? false : true
        } else if textView == tagField {
            tagPlaceholder.isHidden = (textView.text == "") ? false : true
        }
    }
    
    @objc func backgroundTapped() {
        if keyboardShowing {
            self.view.endEditing(true)
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        keyboardShowing = true
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        keyboardShowing = false
    }
}
