//
//  PostViewController.swift
//  Yum
//
//  Created by Noverish Harold on 2017. 11. 4..
//  Copyright © 2017년 Mash-up. All rights reserved.
//

import UIKit
import DKImagePickerController
import Sharaku

class PostViewController: UIViewController, UITextViewDelegate, SHViewControllerDelegate {
    
    var originImage: UIImage!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var contentField: UITextView!
    @IBOutlet weak var contentPlaceholder: UILabel!
    @IBOutlet weak var calorieField: UITextField!
    @IBOutlet weak var tagField: UITextView!
    @IBOutlet weak var tagPlaceholder: UILabel!
    @IBOutlet weak var scrollViewBottom: NSLayoutConstraint!
    
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
                if assets.count == 0 {
                    self.dismiss(animated: false)
                }
                
                for img in assets {
                    img.fetchOriginalImageWithCompleteBlock { (image, _) in
                        self.originImage = image!
                        
                        DispatchQueue.main.async {
                            let vc = SHViewController(image: self.originImage)
                            vc.delegate = self
                            self.present(vc, animated: false)
                        }
                    }
                }
            }
            
            present(pickerController, animated: false)
            pickerShowed = true
        }
    }
    
    func shViewControllerImageDidFilter(image: UIImage) {
        self.imageView.image = image
    }
    
    func shViewControllerDidCancel() {
        self.imageView.image = self.originImage
    }
    
    @IBAction func doneClicked() {
        guard let content = contentField.text, let calorie = Int(calorieField.text ?? "") else { // }, let image = imageView.image, let imageData = UIImagePNGRepresentation(image) else {
            return
        }
        
        var feed = Feed()
        feed.userName = "기우영"
        feed.body = content
        feed.calorie = calorie
        
        feed.userProfileImageUrl = "https://images.unsplash.com/photo-1504455583697-3a9b04be6397?auto=format&fit=crop&w=400"
        feed.foodImageUrl = "https://images.unsplash.com/photo-1478369402113-1fd53f17e8b4?auto=format&fit=crop&w=500"
        
        Feed.sampleFeeds.insert(feed, at: 0)
        dismiss(animated: true, completion: nil)
        
//        Feed.postFeed(feed: feed, imageData: imageData) { success in
//            if success {
//                self.dismiss(animated: true, completion: nil)
//            } else {
//
//            }
//        }
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
        guard let keyboardHeight = keyboardHeight(from: notification) else {
            return
        }
        var bottomConstrainConstant = keyboardHeight
        if #available(iOS 11.0, *) {
            bottomConstrainConstant -= view.safeAreaInsets.bottom
        }
        scrollViewBottom.constant = bottomConstrainConstant
        let animations = {
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        }
        let duration = keyboardAnimationDuration(from: notification) ?? 0.25
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: animations, completion: nil)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        keyboardShowing = false
        scrollViewBottom.constant = 0
        let animations = {
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        }
        let duration = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? Double) ?? 0.25
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: animations, completion: nil)
    }
}
