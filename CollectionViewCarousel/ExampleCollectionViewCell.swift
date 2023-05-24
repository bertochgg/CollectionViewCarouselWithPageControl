//
//  ExampleCollectionViewCell.swift
//  CollectionViewCarousel
//
//  Created by Humberto Garcia on 24/05/23.
//

import UIKit

struct ExampleCollectionViewCellViewModel {
    let image: UIImage
    let backgroundColor: UIColor
}

class ExampleCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ExampleCollectionViewCell"
    
    private let image: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemPink
        contentView.addSubview(image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        image.frame = contentView.bounds
    }
    
    func configure(with viewModel: ExampleCollectionViewCellViewModel) {
        contentView.backgroundColor = viewModel.backgroundColor
        image.image = viewModel.image
    }
}
