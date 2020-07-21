//
//  ImageStore.swift
//  MyFitnessTrecker
//
//  Created by ios_Dev on 16.07.2020.
//  Copyright © 2020 ios_Dev. All rights reserved.
//

import UIKit

class ImageStore {
    static func saveImage(imageName: String, image: UIImage) {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileName = imageName
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 1) else { return }
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
                print("Removed old image")
            } catch let removeError {
                print("couldn't remove file at path", removeError)
            }
        }
        
        do {
            try data.write(to: fileURL)
        } catch let error {
            print("error saving file with error", error)
        }
    }
    
    static func loadImageFromDiskWith(fileName: String) -> UIImage? {
        let documentDiretory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let path = NSSearchPathForDirectoriesInDomains(documentDiretory, userDomainMask, true)
        if let dirPath = path.first {
            let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent(fileName)
            print(imageURL)
            let image = UIImage(contentsOfFile: imageURL.path)
            return image
        }
        return nil
    }
    
}
