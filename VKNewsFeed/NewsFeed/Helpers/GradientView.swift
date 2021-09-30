//
//  GradientView.swift
//  VKNewsFeed
//
//  Created by Алексей Черанёв on 30.09.2021.
//

import UIKit

class GradientView: UIView {
    
    @IBInspectable private var startColor: UIColor = .red
    @IBInspectable private var endColor: UIColor = .blue
    private let gradientLayer = CAGradientLayer()
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    private func setupGradient(){
        self.layer.addSublayer(gradientLayer)
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
}
