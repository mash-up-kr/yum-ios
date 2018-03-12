//
//  TagListView.swift
//  Yum
//
//  Created by Noverish Harold on 2018. 3. 5..
//  Copyright © 2018년 Mash-up. All rights reserved.
//

import UIKit

class TagListView: UIView {
    private let HORIZONTAL_GAP = CGFloat(6)
    private let VERTICAL_GAP = CGFloat(6)
    private let LABEL_PADDING = CGFloat(8)

    private var mEstimatedHeight = CGFloat(0)
    var estimatedHeight: CGFloat {
        return mEstimatedHeight
    }

    @IBOutlet private weak var calorieLabel: GraphicLabel!
    @IBOutlet private weak var tagView: GraphicLabel!
    var tagViews: [UILabel] = []
    
    var calorie: Int = 0 {
        didSet {
            let text = "# \(calorie)kcal"
            let estimatedLabelWidth
                    = text.width(withConstrainedHeight: calorieLabel.width, font: calorieLabel.font) + 2 * LABEL_PADDING

            calorieLabel.width = estimatedLabelWidth
            calorieLabel.text = text
        }
    }
    
    var tags: [String] = [] {
        didSet {
            self.tagViews.forEach({ $0.removeFromSuperview() })
            self.tagViews.removeAll()
            
            var nowX = calorieLabel.width + HORIZONTAL_GAP
            var nowY = tagView.y

            for tag in tags {
                mEstimatedHeight = nowY + tagView.height

                let label = GraphicLabel(frame: tagView.bounds)
                label.textAlignment = tagView.textAlignment
                label.cornerRadius = tagView.cornerRadius
                label.backgroundColor = tagView.backgroundColor
                label.font = tagView.font
                label.textColor = tagView.textColor

                let text = "#\(tag)"
                let estimatedLabelWidth
                        = text.width(withConstrainedHeight: label.width, font: label.font) + 2 * LABEL_PADDING

                if nowX + estimatedLabelWidth > self.width {
                    nowX = 0
                    nowY += VERTICAL_GAP + label.height
                }

                label.text = text
                label.x = nowX
                label.y = nowY
                label.width = estimatedLabelWidth
                self.addSubview(label)
                tagViews.append(label)

                nowX += HORIZONTAL_GAP + label.width
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadNib(String(describing: TagListView.self))
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadNib(String(describing: TagListView.self))
    }
}
