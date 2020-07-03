//
//  UIView+Extension.swift
//  MyFitnessTrecker
//
//  Created by ios_Dev on 10.06.2020.
//  Copyright © 2020 ios_Dev. All rights reserved.
//
import UIKit

extension UIView {
   
    func addBackground() {
        // screen width and height:
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height

        let imageViewBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        imageViewBackground.image = UIImage(named: "MapSnapShot")

        // you can change the content mode:
        imageViewBackground.contentMode = .scaleAspectFill
        imageViewBackground.clipsToBounds = true

        self.addSubview(imageViewBackground)
        self.sendSubviewToBack(imageViewBackground)
        
        
//        UIView.animate(withDuration: 2, delay: 0.2, options: [], animations: {
//            imageViewBackground.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
//        }, completion: { (succes) in
//            imageViewBackground.transform = .identity
//        })
        UIView.animate(withDuration: 2, delay: 0.3, options: [.curveEaseInOut], animations: {
            imageViewBackground.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }, completion: nil)
        
            
        
        //self.insertSubview(imageViewBackground, at: 0)
    }
    
    
}
