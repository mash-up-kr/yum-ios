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
    @IBOutlet weak var calorieLabel: UILabel!
    @IBOutlet weak var calorieSlider: RangeSeekSlider!
    @IBOutlet weak var materialLabel: UILabel!
    @IBOutlet weak var materialField: UITextField!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var userField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calorieSlider.delegate = self
        materialField.delegate = self
        userField.delegate = self
    }
}

extension SearchViewContoller: RangeSeekSliderDelegate {
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        self.calorieLabel.text = "\(Int(minValue)) ~ \(Int(maxValue))"
    }
}

extension SearchViewContoller: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if textField == self.materialField {
            self.materialLabel.text = textField.text
            self.materialLabel.isHidden = false
        } else if textField == self.userField {
            self.userLabel.text = textField.text
            self.userLabel.isHidden = false
        }
        
        return true
    }
}
