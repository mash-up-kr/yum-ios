//
//  SearchViewContoller.swift
//  Yum
//
//  Created by Ryan Yoo on 2017. 11. 4..
//  Copyright © 2017년 Mash-up. All rights reserved.
//

import UIKit
import RangeSeekSlider

class SearchViewContoller: UIViewController {
    @IBOutlet weak var calorieTagView: TagView!
    @IBOutlet weak var calorieSlider: RangeSeekSlider!
    @IBOutlet weak var materialTagView: TagView!
    @IBOutlet weak var materialField: UITextField!
    @IBOutlet weak var userTagView: TagView!
    @IBOutlet weak var userField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTap()

        calorieSlider.delegate = self
        materialField.delegate = self
        userField.delegate = self

        calorieTagView.deleteCallback = calorieTagViewDeleteClicked
        materialTagView.deleteCallback = materialTagViewDeleteClicked
        userTagView.deleteCallback = userTagViewDeleteClicked

        updateUI()
    }

    private func updateUI() {
        self.calorieTagView.content = "\(Int(calorieSlider.selectedMinValue)) ~ \(Int(calorieSlider.selectedMaxValue))"
        self.materialTagView.isHidden = (materialField.text ?? "").count == 0
        self.userTagView.isHidden = (userField.text ?? "").count == 0
    }

    @IBAction func searchBtnClicked() {
        let nav = UIStoryboard.instantiate(SearchResultNavigationController.self, storyboardName: "SearchResultViewController")

        guard let vc = nav.topViewController as? SearchResultViewController else {
            fatalError()
        }

        vc.startCalorie = Int(calorieSlider.selectedMinValue)
        vc.endCalorie = Int(calorieSlider.selectedMaxValue)

        if let material = materialField.text {
            if material != "" {
                vc.tag = material
            }
        }

        if let userName = userField.text {
            if userName != "" {
                vc.userName = userName
            }
        }

        if let tab = self.navigationController?.tabBarController {
            tab.present(nav, animated: true, completion: nil)
        }
    }

    func calorieTagViewDeleteClicked() {
        calorieSlider.selectedMinValue = calorieSlider.minValue
        calorieSlider.selectedMaxValue = calorieSlider.maxValue
        calorieSlider.setNeedsLayout()
        updateUI()
    }

    func materialTagViewDeleteClicked() {
        materialField.text = ""
        updateUI()
    }

    func userTagViewDeleteClicked() {
        userField.text = ""
        updateUI()
    }
}

extension SearchViewContoller: RangeSeekSliderDelegate {
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        updateUI()
    }
}

extension SearchViewContoller: UITextFieldDelegate {
    @IBAction func textFieldChanged(_ textField: UITextField) {
        let content = textField.text ?? ""

        if textField == self.materialField {
            self.materialTagView.content = content
        } else if textField == self.userField {
            self.userTagView.content = content
        }

        updateUI()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
