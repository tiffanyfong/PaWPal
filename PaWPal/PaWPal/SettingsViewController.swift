//
//  SettingsViewController.swift
//  PaWPal
//
//  Created by cs laptop on 9/12/16.
//  Copyright © 2016 HMC CS121 Group 5. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var wakeTextField: UITextField!
    @IBOutlet weak var sleepTextField: UITextField!
    var wakeTimePicker = UIDatePicker();
    var sleepTimePicker = UIDatePicker();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup time picker text fields with proper input
        wakeTimePicker.datePickerMode = UIDatePickerMode.Time;
        let wakeToolBar = createToolBar(#selector(SettingsViewController.wakeDonePressed));
        let wakeTime = DatabaseController.getWakeTime();
        if (wakeTime != "") {
            wakeTextField.text = wakeTime;
        }
        wakeTextField.inputAccessoryView = wakeToolBar;
        wakeTextField.inputView = wakeTimePicker;
        
        sleepTimePicker.datePickerMode = UIDatePickerMode.Time;
        let sleepToolBar = createToolBar(#selector(SettingsViewController.sleepDonePressed));
        let sleepTime = DatabaseController.getSleepTime();
        if (sleepTime != "") {
            sleepTextField.text = sleepTime;
        }
        sleepTextField.inputAccessoryView = sleepToolBar;
        sleepTextField.inputView = sleepTimePicker;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func wakeDonePressed(sender: UIBarButtonItem) {
        let dateFormatter = NSDateFormatter();
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        let time = dateFormatter.stringFromDate(wakeTimePicker.date);
        DatabaseController.setWakeTime(time);
        wakeTextField.text = time;
        wakeTextField.resignFirstResponder()
        
    }
    
    func sleepDonePressed(sender: UIBarButtonItem) {
        let dateFormatter = NSDateFormatter();
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        let time = dateFormatter.stringFromDate(sleepTimePicker.date);
        DatabaseController.setSleepTime(time);
        sleepTextField.text = time;
        sleepTextField.resignFirstResponder();
    }
    
    func createToolBar(pressedFunc: Selector) -> UIToolbar {
        let toolBar = UIToolbar(frame: CGRectMake(0, self.view.frame.size.height/6, self.view.frame.size.width, 40.0))
    
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
    
        toolBar.barStyle = UIBarStyle.BlackTranslucent
    
        toolBar.tintColor = UIColor.whiteColor()
    
        toolBar.backgroundColor = UIColor.blackColor()
    
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: pressedFunc)
    
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
    
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
    
        label.font = UIFont(name: "Helvetica", size: 12)
    
        label.backgroundColor = UIColor.clearColor()
    
        label.textColor = UIColor.whiteColor()
    
        label.textAlignment = NSTextAlignment.Center
    
        let textBtn = UIBarButtonItem(customView: label)
    
        toolBar.setItems([flexSpace,textBtn,flexSpace,doneButton], animated: true)
        
        return toolBar;
    }
    
    // Confirms that user wants to log out
    @IBAction func displayLogOutAlert(sender: UIButton) {
        let alertController = UIAlertController(title: "Alert", message: "Are you sure you want to log out?", preferredStyle: .Alert)
        
        alertController.addAction(UIAlertAction(title: "Yes", style: .Default, handler: logOut))
        
        alertController.addAction(UIAlertAction(title: "No", style: .Default, handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func logOut(alert: UIAlertAction!) {
        // not part of DB
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isUserLoggedIn")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        // Go to login page
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = storyboard.instantiateViewControllerWithIdentifier("Login") as! LoginViewController
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window?.rootViewController = loginVC
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}