//
//  MemeDetailViewController.swift
//  Meme 1.0
//
//  Created by Ebraham Alskaf on 26/03/2024.
//

import UIKit



class MemeDetailViewController: UIViewController {
    
    // MARK: Properties
    
    var meme: Meme!
    
    // MARK: Outlets
    
    @IBOutlet weak var imageview: UIImageView!
    
    // MARK: Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.imageview.image = self.meme.memedImage
        
        // Hide the tab bar when this view appears
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the tab bar when this view disappears
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: Actions
    @IBAction func dismissButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

