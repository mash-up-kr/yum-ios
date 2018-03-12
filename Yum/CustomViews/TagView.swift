//
//  TagView.swift
//  Yum
//
//  Created by Noverish Harold on 2018. 3. 12..
//  Copyright © 2018년 Mash-up. All rights reserved.
//

import UIKit

@IBDesignable
class TagView: UIView {
    @IBOutlet private weak var label: UILabel!

    var deleteCallback: (() -> Void)?
    var content: String {
        get {
            return label.text ?? ""
        }
        set(v) {
            label.text = "#\(v)"
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        self.loadNib(String(describing: TagView.self))
    }

    @IBAction func deleteBtnClicked() {
        if let deleteCallback = deleteCallback {
            deleteCallback()
        } else {
            self.removeFromSuperview()
        }
    }

    override func sizeToFit() {
        let size = self.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        self.width = size.width
        self.height = size.height
    }
}
