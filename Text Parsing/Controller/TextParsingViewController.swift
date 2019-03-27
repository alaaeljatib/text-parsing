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
    
    
    let wordsDict = DataService.instance.provideWordsDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textView.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func parseButtonPressed(_ sender: Any) {
        self.textView.resignFirstResponder()
        
        guard self.textView.text.count > 0 else {
            return
        }
        
        self.textView.delegate = nil
        self.textView.text = ParseService.instance.parse(content: self.textView.text.lowercased(), wordsDict: self.wordsDict)
        
    }
    
    @IBAction func startOverPressed(_ sender: Any) {
        self.textView.resignFirstResponder()
        textView.textColor = UIColor.lightGray
        textView.text = "Enter your text.."
        self.textView.delegate = self
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        self.textView.resignFirstResponder()
    }
}

extension TextParsingViewController : UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if String(text.unicodeScalars.filter{CharacterSet.decimalDigits.contains($0) || $0 == " "}).count > 0 {
            return false
        }
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Enter your text.." {
            textView.text = ""
            textView.textColor = UIColor.black
        }
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.count == 0 {
            textView.textColor = UIColor.lightGray
            textView.text = "Enter your text.."
        }
    }
}

