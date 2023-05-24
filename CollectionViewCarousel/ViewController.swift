//
//  ViewController.swift
//  CollectionViewCarousel
//
//  Created by Humberto Garcia on 24/05/23.
//

import UIKit

class ViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ExampleTableViewCell.self, forCellReuseIdentifier: ExampleTableViewCell.identifier)
        return tableView
    }()
    
    private let viewModels: [ExampleTableViewCellViewModel] = [
        ExampleTableViewCellViewModel(
            viewModels: [
                ExampleCollectionViewCellViewModel(image: UIImage(named: "Profile image")!, backgroundColor: .systemPink),
                ExampleCollectionViewCellViewModel(image: UIImage(named: "Profile image")!, backgroundColor: .systemBlue),
                ExampleCollectionViewCellViewModel(image: UIImage(named: "Profile image")!, backgroundColor: .systemPurple),
                ExampleCollectionViewCellViewModel(image: UIImage(named: "Profile image")!, backgroundColor: .systemRed),
                ExampleCollectionViewCellViewModel(image: UIImage(named: "Profile image")!, backgroundColor: .systemCyan),
                ExampleCollectionViewCellViewModel(image: UIImage(named: "Profile image")!, backgroundColor: .systemMint)
            ]
        )
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }


}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = viewModels[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExampleTableViewCell.identifier,
                                                       for: indexPath) as? ExampleTableViewCell else { fatalError() }
        cell.configure(with: viewModel)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.width
    }
}

