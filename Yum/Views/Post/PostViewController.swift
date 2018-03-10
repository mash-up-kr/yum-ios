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

class PostViewController: UIViewController {

    var originImage: UIImage!

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var contentField: UITextView!
    @IBOutlet weak var contentPlaceholder: UILabel!
    @IBOutlet weak var calorieField: UITextView!
    @IBOutlet weak var caloriePlaceholder: UILabel!
    @IBOutlet weak var tagField: UITextView!
    @IBOutlet weak var tagPlaceholder: UILabel!
    @IBOutlet weak var scrollViewBottom: NSLayoutConstraint!

    var pickerShowed = false
    var keyboardShowing = false

    override func viewDidLoad() {
        contentField.delegate = self
        calorieField.delegate = self
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

    @IBAction func doneClicked() {
        guard let content = contentField.text, let calorie = Int(calorieField.text ?? "") else {
            return
        }

        ServerClient.writeFeed(content: content, calorie: calorie, tags: [], image: self.imageView.image!) { error in
            if let error = error {
                CrashUtil.process(error)
                return
            }

            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }

    @IBAction func cancelClicked() {
        dismiss(animated: true, completion: nil)
    }
}

extension PostViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView == contentField {
            contentPlaceholder.isHidden = (textView.text == "") ? false : true
        } else if textView == calorieField {
            caloriePlaceholder.isHidden = (textView.text == "") ? false : true
        } else if textView == tagField {
            tagPlaceholder.isHidden = (textView.text == "") ? false : true
        }
    }
}

extension PostViewController: SHViewControllerDelegate {
    func shViewControllerImageDidFilter(image: UIImage) {
        self.imageView.image = image
    }

    func shViewControllerDidCancel() {
        self.imageView.image = self.originImage
    }
}

extension PostViewController {
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

extension PostViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
