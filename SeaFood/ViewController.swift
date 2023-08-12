//
//  ViewController.swift
//  objectRecogniser
//
//  Created by Hamed Hashemi on 8/12/23.
//

import UIKit
import CoreML
import Vision // VNCoreMLModel

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!

    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false // later we can make it true to expand the app
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // get the selected photo
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            // add it to the imageView
            imageView.image = userPickedImage
            
            // changing the type to CIImage which is for CoreML specific type
            guard let ciimage = CIImage(image: userPickedImage) else {
                fatalError("Could not convert to CIImage")
            }
            
            detect(image: ciimage)
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    // this will process the image
    func detect(image: CIImage) {
        // Creating an object called model, using the VNcoreMLModel and loading the Inceptionv3 model as the model
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError("loading core ml model failed")
        }
        
        let request = VNCoreMLRequest(model: model) { request, error in
            
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("model failed to process image, failed to downcast results")
            }
            
            if let firstResult = results.first?.identifier {
                self.navigationItem.title = firstResult
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do {
            try handler.perform([request])
        } catch {
            print("error while perform: \(error)")
        }
    }

    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        // present the image picker to the user
        present(imagePicker, animated: true, completion: nil)
    }
    
}

