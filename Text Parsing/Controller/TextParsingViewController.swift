//
//  ViewController.swift
//  Text Parsing
//
//  Created by Alaa Eljatib Etmaz Alsebaei on 2019-03-27.
//  Copyright © 2019 Alaa Eljatib Etmaz Alsebaei. All rights reserved.
//

import UIKit

class TextParsingViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    
    // get the word dictionary from Data Service
    let wordsDict = DataService.instance.provideWordsDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Assign the delegate to let the logic in the extention below work
        self.textView.delegate = self
        
        // add gesture to dismiss keyboard when tapping outside the text area
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func parseButtonPressed(_ sender: Any) {
        // hide keyboard
        self.textView.resignFirstResponder()
        
        // make sure there is text to parse
        guard self.textView.text.count > 0 else {
            return
        }
        
        // stop input restriction mode
        self.textView.delegate = nil
        
        // call the logic
        self.textView.text = ParseService.instance.parse(content: self.textView.text.lowercased(), wordsDict: self.wordsDict)
    }
    
    @IBAction func startOverPressed(_ sender: Any) {
        // hide the keyboard and reset the place holder
        self.textView.resignFirstResponder()
        textView.textColor = UIColor.lightGray
        textView.text = "Enter your text.."
        self.textView.delegate = self
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        // hide the keyboard
        self.textView.resignFirstResponder()
    }
}

extension TextParsingViewController : UITextViewDelegate {
    
    // make sure only letters allowed as input
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if String(text.unicodeScalars.filter{CharacterSet.decimalDigits.contains($0) || $0 == " "}).count > 0 {
            return false
        }
        return true
    }
    
    // handling the place holder when start editing
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Enter your text.." {
            textView.text = ""
            textView.textColor = UIColor.black
        }
        
    }
    
    // handling the place holder when end editing
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.count == 0 {
            textView.textColor = UIColor.lightGray
            textView.text = "Enter your text.."
        }
    }
}

