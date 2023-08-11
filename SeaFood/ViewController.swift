//
//  ViewController.swift
//  SeaFood
//
//  Created by Hamed Hashemi on 8/12/23.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!

    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false // later we can make it true to exand the app
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // get the selected photo
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            // add it to the imageView
            imageView.image = userPickedImage
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
        
    }

    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        // present the image picker to the user
        present(imagePicker, animated: true, completion: nil)
        
        
    }
}

