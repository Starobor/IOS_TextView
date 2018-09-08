//
//  ViewController.swift
//  TextView
//
//  Created by Citizen on 08.09.2018.
//  Copyright © 2018 Citizen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var newTextView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextView), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(updateTextView), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        newTextView = UITextView(frame: CGRect(x: 20, y: 100, width: Int(self.view.bounds.width - 50), height: Int(self.view.bounds.height/2)))
        newTextView.text = "text text"
        newTextView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        newTextView.font = UIFont.systemFont(ofSize: 17)
        newTextView.backgroundColor = UIColor.cyan
        self.view.addSubview(newTextView)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.newTextView.resignFirstResponder()
        newTextView.backgroundColor = UIColor.green
    }
    
    @objc func updateTextView(param: Notification) {
        let userInfo = param.userInfo
        let getKeyboard = (userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardFrame = self.view.convert(getKeyboard, to: view.window)
        
        if param.name == Notification.Name.UIKeyboardWillHide {
            newTextView.contentInset = UIEdgeInsets.zero
        } else {
            newTextView.contentInset = UIEdgeInsetsMake(0, 0, keyboardFrame.height, 0)
            newTextView.scrollIndicatorInsets = newTextView.contentInset
        }
        newTextView.scrollRangeToVisible(newTextView.selectedRange)
    }

}

