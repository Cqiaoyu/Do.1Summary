//
//  ViewController.swift
//  HandleTextField
//
//  Created by LJ on 15/7/30.
//  Copyright (c) 2015年 广东道一信息科技有限公司. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var first: UITextField!
    @IBOutlet weak var second: UITextField!
    @IBOutlet weak var fourth: UITextField!
    @IBOutlet weak var third: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textFieldTextDidChangeNoti:", name: UITextFieldTextDidChangeNotification, object: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldTextDidChangeNoti(noti:NSNotification){
        println("改变-通知")
        
        if let currentField = noti.object as? UITextField {
            currentField.resignFirstResponder()
            let text = currentField.text
            switch currentField {
            case first:
                println(first.text)
                println("第一个")
                if text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) != 0{
                    second.becomeFirstResponder()
                }
            case second:
                
                if text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0{
                    first.becomeFirstResponder()
                }else{
                    third.becomeFirstResponder()
                }
            case third:
                if text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0{
                    second.becomeFirstResponder()
                }else{
                    fourth.becomeFirstResponder()
                }
            case fourth:
                if text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0{
                    third.becomeFirstResponder()
                }else{
                    
                }
            default:
                println("默认")
            }
        }
    }
    
    // MARK: - UITextField Delegate Methods
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        print("改变-协议")
        return true
    }
}

