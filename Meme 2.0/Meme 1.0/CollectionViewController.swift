//
//  CollectionViewController.swift
//  Meme 1.0
//
//  Created by Ebraham Alskaf on 25/03/2024.
//

import UIKit

class collectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView!

    
    // MARK: Model
    var memes: [Meme] {
            let object = UIApplication.shared.delegate
            let appDelegate = object as! AppDelegate
            return appDelegate.memes
        }
    
    // MARK: Collection View Data Source Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Collection"
        
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumLineSpacing = space
        flowLayout.minimumInteritemSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
    }
    
    // number of items
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Configure and return cells for your collection view
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        let meme = memes[indexPath.row]  // Access the correct meme from the memes array
        
        // Set the name and image
        cell.memeImageView?.image = meme.memedImage
        
        // Configure the cell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        // Handle cell selection
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailController.meme = self.memes[indexPath.row]  // Pass the selected meme to the detail view controller
        present(detailController, animated: true, completion: nil)

    }

}
    


