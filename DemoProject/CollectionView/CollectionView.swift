//
//  CollectionView.swift
//  DemoProject
//
//  Created by Frog Pepe on 24/06/2022.
//

import UIKit

class CollectionViewController: UIViewController {
    
    @IBOutlet weak var CollectionView: UICollectionView!
    let CellId = "CollectionViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        CollectionView.delegate = self
        CollectionView.dataSource = self
        let nibCell = UINib(nibName: CellId, bundle: .main)
        CollectionView.register(nibCell, forCellWithReuseIdentifier: CellId)
        // Do any additional setup after loading the view.
    }
}
    extension CollectionViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        
        // init cell
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            
            return 5        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellId, for: indexPath) as! CollectionViewCell
            
            return cell
        }
    
    // select Item
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    // layout
    func collectionView(_ collectionView: UICollectionView, layout collectViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath)-> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 100)

        
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}


