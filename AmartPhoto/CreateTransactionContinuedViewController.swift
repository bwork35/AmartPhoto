//
//  CreateTransactionContinuedViewController.swift
//  AmartPhoto
//
//  Created by Bryan Workman on 11/1/20.
//

import UIKit

class CreateTransactionContinuedViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var notesTextView: UITextView!
    
    //MARK: - Properties

    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTextView()
    }
    
    //MARK: - Actions
    @IBAction func submitButtonTapped(_ sender: Any) {
    }
    
    
    //MARK: - Helper Methods
    func setUpTextView() {
        notesTextView.delegate = self
        notesTextView.layer.borderWidth = 0.5
        notesTextView.layer.borderColor = UIColor.black.cgColor
        notesTextView.layer.cornerRadius = 12.0
        notesTextView.layer.masksToBounds = true
        
        if notesTextView.text.isEmpty {
            notesTextView.text = "Write down any other info you'd like us to know!"
            notesTextView.textColor = UIColor.gray
        }
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(CreateTransactionContinuedViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(CreateTransactionContinuedViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {return}
        
        self.view.frame.origin.y = 0 - keyboardSize.height + 50
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

} //End of class

extension CreateTransactionContinuedViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Write down any other info you'd like us to know!" {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            if textView == notesTextView {
                textView.text = "Write down any other info you'd like us to know!"
            }
            textView.textColor = UIColor.gray
        }
    }
} //End of extension