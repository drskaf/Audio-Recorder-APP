//
//  CollectionViewController.swift
//  Meme 1.0
//
//  Created by Ebraham Alskaf on 25/03/2024.
//

import UIKit

class collectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    // MARK: Model
    var memes = [Meme]()
    
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
    
    // number of items
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Configure and return cells for your collection view
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCell", for: indexPath) as! MemeCollectionViewCell
        let meme = memes[indexPath.row]  // Access the correct meme from the memes array
        
        // Set the name and image
        cell.memeLabel.text = meme.toptext
        cell.memeImageView?.image = meme.memedImage
        
        // Configure the cell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        // Handle cell selection
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailController.meme = memes[indexPath.row]  // Pass the selected meme to the detail view controller
        
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }
}
    


