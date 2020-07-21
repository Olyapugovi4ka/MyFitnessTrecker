//
//  PhotoViewController.swift
//  MyFitnessTrecker
//
//  Created by ios_Dev on 10.06.2020.
//  Copyright © 2020 ios_Dev. All rights reserved.
//

import UIKit
import  AVFoundation

class PhotoViewController: UIViewController {
    
    private let photoView = PhotoView()
    
    var presenter: PhotoViewPresenterProtocol?
    var assembler: PhotoViewAssembly!
    
    override func loadView() {
        self.view = photoView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        assembler.assembly()
        self.photoView.imageView.image = ImageStore.loadImageFromDiskWith(fileName: "Selfy")
        photoView.delegate = self
    }
}

extension PhotoViewController: PhotoViewDelegate {
    
    func goToMap() {
        presenter?.goToMap()
    }
}
