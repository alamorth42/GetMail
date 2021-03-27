//
//  ViewController.swift
//  GetMail
//
//  Created by Achille Lamorthe on 27/03/2021.
//  Copyright © 2021 Achille Lamorthe. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var mailTextField: UITextField!
    
    var ref: DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // SETUP FIREBASE AND DELEGATE
        mailTextField.delegate = self
        ref = Database.database().reference()
        
    }


    @IBAction func EnvoyerButton(_ sender: UIButton) {
        
        if (mailTextField.text != "") {

            // Trier par date dans la database les plus recents seront en bas
            let formatDate = DateFormatter()
            formatDate.dateStyle = .medium
            formatDate.locale = Locale(identifier: "FR")
            formatDate.dateFormat = "yyyyMMddHHmmss"
            let DateNow = formatDate.string(from: Date())
            
            ref?.child("email").child(DateNow).setValue(mailTextField.text!)
            
            displayMessage(userMessage: "Votre email a bien été enregistré", userTitle: "Merci !")
        }
            
        else {
            displayMessage(userMessage: "Veuillez rentrer votre email", userTitle: "Attention !")
        }
    }
    
    
    // Fermer le clavier avec Done
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        mailTextField.resignFirstResponder()
    }
    
    //MESSAGE ERREUR QUI POP
    func displayMessage(userMessage: String, userTitle: String) -> Void {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: userTitle, message: userMessage, preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    
}

