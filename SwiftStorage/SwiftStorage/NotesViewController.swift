//
//  NotesViewController.swift
//  SwiftStorage
//
//  Created by new on 28/05/18.
//  Copyright © 2018 yuvraj. All rights reserved.
//

import UIKit

class NotesViewController: BaseViewController, UITextViewDelegate , UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet var textNotes: UITextView!
    @IBOutlet var imgPhoto: UIImageView!
    @IBOutlet var imgPhotoPicker: UIButton!
    @IBOutlet var labelLocation: UILabel!
    @IBOutlet var labelContent: UITextView!
    
    var helper : LocationHelper? = nil
    var imageUrl = ""
    var handler = CoreDataHandler()
    
    var picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(onImageTapped(gesture:)))
        imgPhoto.isUserInteractionEnabled = true
        imgPhoto.addGestureRecognizer(gesture)
        
        textNotes.sizeToFit()
        textNotes.delegate = self
        picker.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @objc func onImageTapped(gesture : UITapGestureRecognizer){
        //        let tappedImage = gesture.view as! UIImageView
        openPicker()
    }
    
    @IBAction func addPicture(_ sender: Any) {
        openPicker()
    }
    
    @IBAction func locationHandler(_ sender: Any){
        performSegue(withIdentifier: "location", sender: nil)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textNotes.text = ""
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if(textView.text == ""){
            textNotes.text = "Start typing your notes here"
        }
    }
    
    func openPicker(){
        let alert = UIAlertController(title: "Select", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        alert.addAction(UIAlertAction(title: "Camera", style:
            UIAlertActionStyle.default, handler: { (view) in
                
                guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
                    print("This device doesn't have a camera.")
                    return
                }
                
                self.picker.allowsEditing = false
                self.picker.cameraDevice = .rear
                self.picker.mediaTypes = UIImagePickerController.availableMediaTypes(for:.camera)!
                self.picker.sourceType = UIImagePickerControllerSourceType.camera
                
                self.present(self.picker, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Library", style: UIAlertActionStyle.default, handler: { (view) in
            
            guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
                print("can't open photo library")
                return
            }
            
            self.picker.allowsEditing = false
            self.picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            
            self.present(self.picker, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    /*
     let UIImagePickerControllerMediaType: String //Specifies the media type selected by the user.
     let UIImagePickerControllerOriginalImage: String //Specifies the original, uncropped image selected by the user.
     let UIImagePickerControllerEditedImage: String //Specifies an image edited by the user.
     let UIImagePickerControllerCropRect: String //Specifies the cropping rectangle that was applied to the original image.
     let UIImagePickerControllerMediaURL: String //Specifies the filesystem URL for the movie.
     let UIImagePickerControllerReferenceURL: String //The Assets Library URL for the original version of the picked item.
     let UIImagePickerControllerMediaMetadata: String //Metadata for a newly-captured photograph.
     let UIImagePickerControllerLivePhoto: String //The Live Photo representation of the selected or captured photo.
     */
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let tempImage = ""+UUID().uuidString+".png"
        let imagePath = getDocumentsDirectory().appendingPathComponent(tempImage)
        
        if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imgPhotoPicker.isHidden = true
            imgPhoto.image = originalImage
            
            if let imageData = UIImagePNGRepresentation(originalImage){
                try? imageData.write(to: imagePath)
                self.imageUrl = tempImage
            }
        }
        
        //        let imageUrl = info[UIImagePickerControllerImageURL] as? String
        //        if imageUrl != nil {
        //            print(imageUrl!)
        //        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDir = paths.first!
        return documentDir
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "location"){
            let controller = segue.destination as! LocationViewController
            controller.controller = self
        }
    }
    
    func setLocationParams(helper : LocationHelper){
        self.helper = helper
        labelLocation.text = helper.location
    }
    
    func validateNotes() -> Bool{
        if self.imageUrl != "" && self.helper != nil && labelContent.text != "" &&
            labelContent.text != "Enter your note" {
            return true;
        }else{
            return false
        }
    }
    
    @IBAction func saveNoteClick(_ sender: Any) {
        if validateNotes(){
            let notesHelper = NotesHelper(photo: self.imageUrl, location: self.helper!, content: labelContent.text)
            handler.createNotes(helper: notesHelper)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    
    
    
    
    
}
