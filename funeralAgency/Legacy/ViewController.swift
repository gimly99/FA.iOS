//
//  ViewController.swift
//  funeralAgency
//
//  Created by user on 20/12/2019.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var funeralAgencyField: UITextField!
    @IBOutlet weak var suenameField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var patronymicField: UITextField!
    @IBOutlet weak var eMailField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var deadManIDField: UITextField!
    @IBOutlet weak var cemeteryField: UITextField!

    let datePicker = UIDatePicker()
    //@IBAction func dateField(_ sender: UITextField) {
//        func createDatePicker(){
//
//         //format for datepicker display
//         datePicker.datePickerMode = .date
//
//         //assign datepicker to our textfield
//         //dateField.inputView = datePicker
//
//         //create a toolbar
//         let toolbar = UIToolbar()
//         toolbar.sizeToFit()
//
//         //add a done button on this toolbar
//         let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClicked))
//
//            toolbar.setItems([doneButton], animated: true)
//
//            dateField.inputAccessoryView = toolbar
//        }
//    }
//
//    @objc func doneClicked(){
//
//            //format for displaying the date in our textfield
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateStyle = .medium
//            dateFormatter.timeStyle = .none
//
//        dateField.text = dateFormatter.string(from: datePicker.date)
//            self.view.endEditing(true)
//    }
    
    
    @IBAction func reqForFuneral(_ sender: Any) {
        let session = URLSession.shared
            let url = URL(string: "http://localhost:3200")!.appendingPathComponent("ordering")
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            struct OrderForm: Codable {
                public var dateee: Date
                public var idFuneralAgency: Int?
                public var surnameCustomer: String
                public var nameCustomer: String
                public var patronymicCustomer: String
                public var eMailCustomer: String
                public var phoneNumberCustomer: String
                public var idClient: Int?
                public var idCemetery: Int?
            }
        
        if funeralAgencyField.text == nil || suenameField.text == "" || nameField.text == "" ||
            patronymicField.text == "" || eMailField.text == "" || phoneNumberField.text == "" || deadManIDField.text == nil || cemeteryField.text == "" {
            
            
            let alert = UIAlertController(title: "Something went wrong", message: "Fill all fields to finish ordering", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in

            })
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        else{
            let alert = UIAlertController(title: "Success ordering", message: "We'll consider your order in nearest time", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                self.funeralAgencyField.text = nil
                self.suenameField.text = ""
                self.nameField.text = ""
                self.patronymicField.text = ""
                self.eMailField.text = ""
                self.phoneNumberField.text = ""
                self.deadManIDField.text = nil
                self.cemeteryField.text = nil
            })
                            
            self.present(alert, animated: true, completion: nil)

        }
            
        let kkk = OrderForm(dateee: Date.init(), idFuneralAgency: Int(funeralAgencyField.text!)!, surnameCustomer: suenameField.text!, nameCustomer: nameField.text!, patronymicCustomer: patronymicField.text!, eMailCustomer: eMailField.text!, phoneNumberCustomer: phoneNumberField.text!, idClient: Int(deadManIDField.text!)!, idCemetery: Int(cemeteryField.text!)!)
            
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            
            request.allHTTPHeaderFields = ["Content-Type": "application/json"]
            
            let data = try? encoder.encode(kkk)
            
            request.httpBody = data
            
            let task = URLSession.shared.dataTask(with: request) { (data, res, err) in
                if let data = data { print(String(data: data, encoding: .utf8)) }
                
            }
            task.resume()
        }
    }
    
    




    

class LoginViewController: UIViewController {
    
    @IBOutlet weak var authEMailfield: UITextField!
    @IBOutlet weak var authPassworfField: UITextField!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginSegue" {
            guard let vc = segue.destination as? OrdersTableViewController else { return }
            vc.token = loadedToken
        }
    }
    
    @IBAction func dismissViewController(segue: UIStoryboardSegue) {
        self.dismiss(animated: true)
    }
    
    var loadedToken: String?
    
    @IBAction func signInBtn(_ sender: Any) {
        let session = URLSession.shared
        let url = URL(string: "http://localhost:3200")!.appendingPathComponent("login")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        struct Login: Codable {
            let eMail: String
            let password: String
            
        }
        
        
        let kek = Login(eMail: authEMailfield.text!, password: authPassworfField.text!)
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        
        request.allHTTPHeaderFields = ["Content-Type": "application/json"]
        
        let data = try? encoder.encode(kek)
        
        request.httpBody = data
        
        struct Ppp: Codable {
            let token: String
            let employee: [String: String]
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, res, err) in
            if let data = data {
                print(String(data: data, encoding: .utf8)) // я отойду мин на 10
                let dictionary = try? JSONDecoder().decode(Ppp.self, from: data)
                if let token = dictionary?.token {
                    self.loadedToken = token
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "loginSegue", sender: nil)
                    }
                }
                
                else {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Something went wrong", message: "Wrong password or e-mail", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                            self.authEMailfield.text = ""
                            self.authPassworfField.text = ""
                        })
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
        
        
        
        task.resume()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
        //textView.resignFirstResponder()
    }
    
    @objc func updateTextView(notification: Notification){
        guard let userInfo = notification.userInfo as? [String: AnyObject], let _ = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)? .cgRectValue
            else {return}
        if notification.name == UIResponder.keyboardWillHideNotification {
            authPassworfField.contentMode = .center
        }
    }
}


class ViewController: UIViewController {


    @IBOutlet weak var repetePasswordField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var eMailField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var experienceField: UITextField!
    @IBOutlet weak var surnameField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var registerLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        self.registerLabel.textAlignment = .center
        self.registerLabel.textColor = .systemRed
        self.registerLabel.text = "Registration"
        
        
        
        // Do any additional setup after loading the view.
    }
    
    struct RegisterForm: Codable {
        public var eMail: String
        public var name: String
        public var surname: String
        public var password: String
        public var phoneNumber: String
        public var experience: Int
    }
    

    
    @IBAction func regg(_ sender: Any) {
        let session = URLSession.shared
        let url = URL(string: "http://localhost:3200")!.appendingPathComponent("register")
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        


        if repetePasswordField.text == "" || passwordField.text == "" || nameField.text == "" ||
            surnameField.text == "" || eMailField.text == "" || experienceField.text == nil || phoneNumberField.text == "" {
            
            
            let alert = UIAlertController(title: "Something went wrong", message: "Fill all fields to finish ordering", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in

            })
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        

        
        var kok = RegisterForm(eMail: eMailField.text!,
                               name: nameField.text!,
                               surname: surnameField.text!,
                               password: passwordField.text!,
                               phoneNumber: phoneNumberField.text!,
                               experience: Int(experienceField.text!)!)
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        
        request.allHTTPHeaderFields = ["Content-Type": "application/json"]
        
        let data = try? encoder.encode(kok)
        
        request.httpBody = data
        
        let task = URLSession.shared.dataTask(with: request) { (data, res, err) in
            if let data = data {
            
            
                if true {
                    DispatchQueue.main.async {
                                            let alert = UIAlertController(title: "Successful regestrate", message: "Now you can login", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                            self.repetePasswordField.text = ""
                            self.passwordField.text = ""
                            self.nameField.text = ""
                            self.surnameField.text = ""
                            self.eMailField.text = ""
                            self.phoneNumberField.text = ""
                            self.experienceField.text = nil
                            
                            self.dismiss(animated: true)
                            
                        })
                                        
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
        task.resume()

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
        //textView.resignFirstResponder()
    }
    
    @objc func updateTextView(notification: Notification){
        guard let userInfo = notification.userInfo as? [String: AnyObject], let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)? .cgRectValue
            else {return}
        if notification.name == UIResponder.keyboardWillHideNotification {
            passwordField.contentMode = .center
        }
    }


}

