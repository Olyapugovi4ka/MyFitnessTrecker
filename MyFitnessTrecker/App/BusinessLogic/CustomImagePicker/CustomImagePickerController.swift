//
//  CustomImagePickerController.swift
//  MyFitnessTrecker
//
//  Created by ios_Dev on 17.07.2020.
//  Copyright © 2020 ios_Dev. All rights reserved.
//

import UIKit

protocol ImagePickerControllerDelegate: class {
    func goToPhotoViewController()
}

final class ImagePickerController: UIImagePickerController  {
    
     weak var imagePickerControllerDelegate: ImagePickerControllerDelegate?
    
    override func viewDidLoad() {
         guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else { return }
               configureImagePickerController()
    }
    
    
    func configureImagePickerController() {
        self.delegate = self
        self.sourceType = .photoLibrary
        self.allowsEditing = true
    }
}

extension ImagePickerController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           picker.dismiss(animated: true, completion: nil)
       }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: true) { [weak self]  in
            guard let image = self?.extractImage(from: info) else { return }
            ImageStore.saveImage(imageName: "Selfy", image: image)
            self?.imagePickerControllerDelegate?.goToPhotoViewController()
        }
    }
    
    private func extractImage(from info: [UIImagePickerController.InfoKey: Any]) -> UIImage? {
        if let image = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.editedImage.rawValue)] as? UIImage {
            return image
        } else if let image = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue)]
            as? UIImage {
            return image
        } else {
            return nil
        }
    }
}
