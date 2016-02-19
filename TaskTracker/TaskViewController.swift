//
//  TaskViewController.swift
//  TaskTracker
//
//  Created by Alex Yi on 2/12/16.
//  Copyright © 2016 Alex Yi. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIPickerViewDelegate {
    
    // MARK: Properties
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var priorityPickerView: UIPickerView!
    @IBOutlet weak var saveButton: UIBarButtonItem!

    var pickerDataSource = ["Low", "Medium", "High"]
    
    /* This value is either passed by 'TaskTableViewController' in 'prepareForSegue(_:sender:)'
    or constructd as part of adding a new task
    */
    var task: Task?
    var priority: String = ""
    
    var text: String?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        var priorityIndex = 0
        
        // set this ViewController as a delegate to handle text field input
        taskTextField.delegate = self
        
        // Set up views if editing an existing task
        if let task = task {
            navigationItem.title = task.name
            taskTextField.text = task.name
            commentTextView.text = task.comments
            if task.priority == "High" {
                priorityIndex = 2
            }
            else if task.priority == "Medium" {
                priorityIndex = 1
            }
            else {
                priorityIndex = 0
            }
        }
        
        // Enable the save button if the text field has a valid task Name
        checkValidTaskName()
        
        commentTextView.delegate = self
        priorityPickerView.delegate = self
        //commentTextView.becomeFirstResponder()
        

        priorityPickerView.selectRow(priorityIndex, inComponent: 0, animated: true)
        // create border for text view and initialize placeholder text
        commentTextView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).CGColor
        commentTextView.layer.borderWidth = 1.0
        commentTextView.layer.cornerRadius = 5
        
        let isPresentingInAddTaskMode = presentingViewController is UINavigationController
        
        if isPresentingInAddTaskMode {
            commentTextView.text = "Add comments..."
            commentTextView.textColor = UIColor.lightGrayColor()
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        commentTextView.resignFirstResponder()
    }

    
    // MARK: UITextFieldDelegate
    // implement methods to handle first responder status
    func textFieldDidBeginEditing(textField: UITextField) {
        // Disable the save button while editing
        //saveButton.enabled = false
        text = textField.text ?? ""
        saveButton.enabled = !text!.isEmpty
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        let currentText = textField.text ?? ""
//        if currentText.isEmpty {
//            textField.text = text
//        }
        // Hide the keyboard
        textField.resignFirstResponder()
        
        return true
    }
    
    
    func checkValidTaskName() {
        // disable the save button if the text field is empty
        let text = taskTextField.text ?? ""
        saveButton.enabled = !text.isEmpty
        if text.isEmpty{
            taskTextField.text = text
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        let currentText = textField.text
        
        if currentText!.isEmpty {
            textField.text = text
        } //restore previous text if it is empty and user navigates elsewhere
        checkValidTaskName()
        navigationItem.title = textField.text
    }
    
    // MARK: UITextViewDelegate
//    func textViewShouldEndEditing(textView: UITextView) -> Bool {
//        textView.resignFirstResponder()
//        
//        return true
//    }
    
    
    
    func textViewDidBeginEditing(textView: UITextView) {
        textView.becomeFirstResponder()
        
        if textView.textColor == UIColor.lightGrayColor() {
            textView.text = nil
            textView.textColor = UIColor.blackColor()
        }
        //let text = textView.text ?? ""
        //saveButton.enabled = !text.isEmpty
    } // clear placeholder text
    
    func textViewDidEndEditing(textView: UITextView) {
        textView.resignFirstResponder()
        if textView.text.isEmpty {
            textView.text = "Add comments..."
            textView.textColor = UIColor.lightGrayColor()
        }
    } // put back placeholder if text view is empty
    
    
//    func textViewDidChangeSelection(textView: UITextView) {
//        if self.view.window != nil {
//            if textView.textColor == UIColor.lightGrayColor(){
//                textView.selectedTextRange = textView.textRangeFromPosition(textView.beginningOfDocument, toPosition: textView.beginningOfDocument)
//            }
//        }
//    } // prevents user from changing the position of the cursor while the placeholder is visible
    
    // MARK: UIPickerViewDelegate
    // use these methods temporarily
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerDataSource[row]
    }
    
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //Called by the picker view when the user selects a row in a component.
        priority = pickerDataSource[priorityPickerView.selectedRowInComponent(0)]
    }
    
    
    
    
    // MARK: Navigation
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
        
        // Depending on style of presentation (modal or push), this view controller needs to be dismissed in two diff ways
        let isPresentingInAddTaskMode = presentingViewController is UINavigationController
        
        if isPresentingInAddTaskMode {
            dismissViewControllerAnimated(true, completion: nil)
        }
        else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    // This method lets you configure a view controller before it's presented
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            let name = taskTextField.text ?? ""
            let comments = commentTextView.text ?? ""
//            let priority = "Low" //default, implement later after implementing pickerView delegate
            
            // Set the task to be passed to TaskTableViewController after the unwind segue
            task = Task(name: name, comments: comments, priority: priority)
        }
    }
    
    // MARK: Actions
//    @IBAction func setDefaultLabelText(sender: UIButton) {
//        taskLabel.text = "Default"
//    }
    

}

