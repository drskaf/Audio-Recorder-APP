//
//  ViewController.swift
//  Meme 1.0
//
//  Created by Ebraham Alskaf on 31/01/2024.
//

import UIKit

// dictionary of memed image
struct Meme {
    var toptext: String
    var bottomtext: String
    var originalImage: UIImage
    var memedImage: UIImage
}

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    // define outlets
    @IBOutlet weak var ImagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    
    var memedImage: UIImage!
    
    // define text parameters
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth: -3
    ]
    

    // define image picker
    let imagePicker = UIImagePickerController()
    
    override func viewWillAppear(_ animated: Bool) {
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
 
        super.viewWillAppear(animated)
        // show keyboard
        subscribeToKeyboardNotification()
        subscribeToKeyboardHideNotificaiton()
        // remove keyboard when click outside text
        let tapGesture = UITapGestureRecognizer(target:  self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
#if targetEnvironment(simulator)
        cameraButton.isEnabled = false
#else
        cameraButton.isEnabled = true
#endif
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotification()
        subscribeToKeyboardHideNotificaiton()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ImagePickerView.contentMode = .scaleAspectFit
        
        func setupTextField(textField: UITextField, text: String) {
            textField.textAlignment = .center
            textField.autocapitalizationType = .allCharacters
            textField.defaultTextAttributes = memeTextAttributes
            textField.delegate = self
            topText.placeholder = "TOP"
            bottomText.placeholder = "BOTTOM"
        }
        
        setupTextField(textField: topText, text: "TOP")
        setupTextField(textField: bottomText, text: "BOTTOM")
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "TOP" {
            textField.text = ""
        }
        if textField.text == "BOTTOM" {
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // picking image function
    func pickImage(source: UIImagePickerController.SourceType) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = source
        present(pickerController, animated: true, completion: nil)
    }
    
    // Picking an image from album
    @IBAction func pickFromAlbum(_ sender: Any) {
        pickImage(source: .photoLibrary)
    }
    
    // Picking an image from camera
    @IBAction func pickFromCamera(_ sender: Any) {
        pickImage(source: .camera)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        if let image = info[.originalImage] as? UIImage {
            ImagePickerView.image = image
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // keyboard functions
    @objc func keyboardWillShow(_ notification:Notification) {
        print("keyboard will show")
        view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        print("keyboard will hide")
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        guard let userInfo = notification.userInfo,
              let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return 0}
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name:  UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    func subscribeToKeyboardHideNotificaiton() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification,object: nil)
    }
    
    func save() {
        // create the meme
        let meme = Meme(toptext: topText.text!, bottomtext: bottomText.text!, originalImage: ImagePickerView.image!, memedImage: memedImage)
        
        
        // Add it to the memes array in the Application Delegate
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    func generateMemedImage() -> UIImage {
        // hide toolbar
        self.toolBar.isHidden = true
        
        // render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // show toolbar
        self.toolBar.isHidden = false
        
        return memedImage
    }
    
    
    @IBAction func shareMeme(_ sender: Any) {
        
        let image = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(controller, animated: true, completion: nil)
        
        //save Meme
        controller.completionWithItemsHandler = { [self]
            _, completed, _, _ in if completed {
                _ = (topText: self.topText.text! as NSString?, bottomText: self.bottomText.text! as NSString?, image: self.ImagePickerView.image, memedImage: memedImage)
                self.dismiss(animated: true, completion: nil)
                
            }
        }
        let meme = Meme(toptext: topText.text!, bottomtext: bottomText.text!, originalImage: ImagePickerView.image!, memedImage: memedImage)
        
        
        // Add it to the memes array in the Application Delegate
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        
    }
}
