//
//  MemeDetailViewController.swift
//  Meme 1.0
//
//  Created by Ebraham Alskaf on 26/03/2024.
//

import UIKit


class MemeDetailViewController: UIViewController {
    
    // MARK: Properties
    var meme: Meme?
    
    // MARK: Outlets
    
    @IBOutlet weak var imageview: UIImageView!
        
        // MARK: View Life Cycle
        override func viewDidLoad() {
            super.viewDidLoad()
            // Update UI with meme data
            if let meme = meme {
                imageview.image = meme.memedImage
            }
        }
    }

