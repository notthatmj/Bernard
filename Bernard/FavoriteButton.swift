//
//  FavoriteButton.swift
//  Bernard
//
//  Created by Michael Johnson on 3/14/17.
//  Copyright © 2017 Michael Johnson. All rights reserved.
//

// For this class, I started with code from https://github.com/okmr-d/DOFavoriteButton.git and modified it.
// The original license is below.

// The MIT License (MIT)

// Copyright (c) 2015 Daiki Okumura
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit

@IBDesignable class FavoriteButton: UIButton {

    var imageShape: CAShapeLayer?
    @IBInspectable open var image: UIImage! {
        didSet {
            createLayers(image: image)
        }
    }

    @IBInspectable open var imageColorOff: UIColor! = UIColor(red: 136/255, green: 153/255, blue: 166/255, alpha: 1.0) {
        didSet {
            if (!isSelected) {
                imageShape?.fillColor = imageColorOff.cgColor
            }
        }
    }

    @IBInspectable open var imageColorOn: UIColor! = UIColor(red: 255/255, green: 172/255, blue: 51/255, alpha: 1.0) {
        didSet {
            if (isSelected) {
                imageShape?.fillColor = imageColorOn.cgColor
            }
        }
    }
    
    override var isSelected: Bool {
        willSet {
            imageShape?.fillColor = (newValue) ? imageColorOn.cgColor : imageColorOff.cgColor
        }
    }
    
    func createLayers(image: UIImage!) {
        self.layer.sublayers = nil
        
        let imageFrame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        let imgCenterPoint = CGPoint(x: imageFrame.midX, y: imageFrame.midY)

        let imageShape = CAShapeLayer()
        imageShape.bounds = imageFrame
        imageShape.position = imgCenterPoint
        imageShape.path = UIBezierPath(rect: imageFrame).cgPath
        imageShape.fillColor = imageColorOff.cgColor
        imageShape.actions = ["fillColor": NSNull()]
        self.layer.addSublayer(imageShape)
        
        imageShape.mask = CALayer()
        imageShape.mask!.contents = image.cgImage
        imageShape.mask!.bounds = imageFrame
        imageShape.mask!.position = imgCenterPoint
        
        self.imageShape = imageShape
    }
    
}
