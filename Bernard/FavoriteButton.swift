//
//  FavoriteButton.swift
//  Bernard
//
//  Created by Michael Johnson on 3/14/17.
//  Copyright © 2017 Michael Johnson. All rights reserved.
//

import UIKit

@IBDesignable class FavoriteButton: UIButton {

    var imageShape: CAShapeLayer!
    @IBInspectable open var image: UIImage! {
        didSet {
            createLayers(image: image)
        }
    }

    @IBInspectable open var imageColorOff: UIColor! = UIColor(red: 136/255, green: 153/255, blue: 166/255, alpha: 1.0) {
        didSet {
            if (!isSelected) {
                imageShape.fillColor = imageColorOff.cgColor
            }
        }
    }

    @IBInspectable open var imageColorOn: UIColor! = UIColor(red: 255/255, green: 172/255, blue: 51/255, alpha: 1.0) {
        didSet {
            if (isSelected) {
                imageShape.fillColor = imageColorOn.cgColor
            }
        }
    }
    
    func createLayers(image: UIImage!) {
        self.layer.sublayers = nil
        
        let imageFrame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        let imgCenterPoint = CGPoint(x: imageFrame.midX, y: imageFrame.midY)

        imageShape = CAShapeLayer()
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

    }

    func select() {
        isSelected = true
        imageShape.fillColor = imageColorOn.cgColor
    }

    func deselect() {
        isSelected = false
        imageShape.fillColor = imageColorOff.cgColor
    }
    
}
