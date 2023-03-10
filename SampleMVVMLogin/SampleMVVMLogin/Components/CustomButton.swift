//
//  CustomButton.swift
//  SampleMVVMLogin
//
//  Created by Abhishek Suryawanshi on 09/03/23.
//

import UIKit

class CustomButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 5 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
}
