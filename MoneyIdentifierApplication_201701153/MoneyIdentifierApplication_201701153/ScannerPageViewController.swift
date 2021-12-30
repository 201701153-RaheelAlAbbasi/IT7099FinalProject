//
//  ScannerPageViewController.swift
//  MoneyIdentifierApplication_201701153
//
//  Created by Raheel AlAbbasi on 30/12/2021.
//


import UIKit
import CoreML
import Vision
import AVFoundation

class ScannerPageViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    
    @IBOutlet var imageViewObject: UIImageView!
    
    @IBOutlet var imageDescription: UITextView!
    
    var imagePicker : UIImagePickerController!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera

        
        
    }

    @IBAction func takePhoto(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
 
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        imageViewObject.image=info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        imagePicker.dismiss(animated: true, completion: nil)
        currencyIdentifyML(image: (info[UIImagePickerController.InfoKey.originalImage] as? UIImage)!)
        
    }
    
    func currencyIdentifyML (image: UIImage){
    
        guard let mlModel = try? VNCoreMLModel(for:CurrencyIdentifier().model) else {
            fatalError("ML Model could not load")
        }
        
        let request = VNCoreMLRequest (model: mlModel){
            [weak self] request, error in
            
            guard let results = request.results as? [VNClassificationObservation], let firstResult = results.first else {
                fatalError("VNCoreMLRequest not yielding results")
                //VNCoreMLRequest is a library
            }
            
            
            if (Int(firstResult.confidence * 100) > 90){
            
            DispatchQueue.main.async {
                self?.imageDescription.text = "الثقة = \(Int(firstResult.confidence * 100))%\n نوع العملة:  \((firstResult.identifier))"
                
                //Text to speech - Change language
                
                let utterance1 = AVSpeechUtterance(string: (self?.imageDescription.text)!)
                utterance1.voice = AVSpeechSynthesisVoice (language: "ar")
                let synthesizer = AVSpeechSynthesizer()
                synthesizer.speak(utterance1)
            }
        }
            else {
                DispatchQueue.main.async {
                    self?.imageDescription.text = "الصورة غير واضحة"
                    
                    //Text to speech - Change language
                    
                    let utterance2 = AVSpeechUtterance(string: (self?.imageDescription.text)!)
                    utterance2.voice = AVSpeechSynthesisVoice (language: "ar")
                    let synthesizer = AVSpeechSynthesizer()
                    synthesizer.speak(utterance2)
                }
            }
        }
        //Sending the image to start processing
        guard let ciImageCheck = CIImage(image:image) else {
            fatalError("Cannot convert to CIImage")
        }
        let imageHandle = VNImageRequestHandler (ciImage: ciImageCheck)
        
        DispatchQueue.global(qos: .userInteractive).async{
            do{
              
                try imageHandle.perform([request])
                }catch {
                print("Error \(error)")
                }
            
        }
    }

    

}
