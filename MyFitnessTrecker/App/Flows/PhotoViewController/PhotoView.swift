//
//  PhotoView.swift
//  MyFitnessTrecker
//
//  Created by ios_Dev on 10.07.2020.
//  Copyright © 2020 ios_Dev. All rights reserved.
//

import UIKit

protocol  PhotoViewDelegate: class {
    func goToMap()
}

class PhotoView: UIView {
    
    weak var delegate: PhotoViewDelegate?
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var usePhotoButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Use", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.addTarget(self, action: #selector(goToMap), for: .touchUpInside)
        button.layer.cornerRadius = 10
        return button
    }()
    
    @objc func goToMap(_ sender: UIButton){
        delegate?.goToMap()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    private func configureUI() {
        addSubview(imageView)
        imageView.fillSuperview()
        addSubview(usePhotoButton)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        usePhotoButton.frame = CGRect(x: self.bounds.width / 2 - 100, y: self.bounds.height - 200, width: 200, height: 60)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
