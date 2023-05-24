//
//  ExampleTableViewCell.swift
//  CollectionViewCarousel
//
//  Created by Humberto Garcia on 24/05/23.
//

import UIKit

struct ExampleTableViewCellViewModel {
    let viewModels: [ExampleCollectionViewCellViewModel]
}

class ExampleTableViewCell: UITableViewCell {
    
    static let identifier = "ExampleTableViewCell"
    
    private var viewModels: [ExampleCollectionViewCellViewModel] = []
    
    let slider: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ExampleCollectionViewCell.self, forCellWithReuseIdentifier: ExampleCollectionViewCell.identifier)
        collectionView.backgroundColor = .systemBackground
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    let pageControl: UIPageControl = {
        let page = UIPageControl()
        page.currentPageIndicatorTintColor = .blue
        page.pageIndicatorTintColor = .lightGray
        return page
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemPink
        contentView.addSubview(slider)
        contentView.addSubview(pageControl)
        slider.delegate = self
        slider.dataSource = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        slider.frame = contentView.bounds
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: slider.bottomAnchor, constant: -20),
            pageControl.leadingAnchor.constraint(equalTo: slider.leadingAnchor, constant: 50),
            pageControl.trailingAnchor.constraint(equalTo: slider.trailingAnchor, constant: -50),
            pageControl.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configure(with viewModel: ExampleTableViewCellViewModel) {
        self.viewModels = viewModel.viewModels
        slider.reloadData()
        pageControl.numberOfPages = viewModels.count // Update the numberOfPages here
        pageControl.currentPage = 0
    }
    
}

extension ExampleTableViewCell: UICollectionViewDelegate {
    
}

extension ExampleTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExampleCollectionViewCell.identifier,
                                                            for: indexPath) as? ExampleCollectionViewCell else { fatalError() }
        
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
}

extension ExampleTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = contentView.frame.size.width
        return CGSize(width: width, height: contentView.frame.size.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.bounds.width
        let currentPage = Int((scrollView.contentOffset.x + pageWidth / 2) / pageWidth)
        pageControl.currentPage = currentPage
    }
}
