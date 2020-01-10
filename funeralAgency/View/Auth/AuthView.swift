//
//  AuthView.swift
//  funeralAgency
//
//  Created by user on 20/12/2019.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

public class AuthView: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    let viewModel: AuthViewModelProtocol = AuthViewModel()
    
    public override func viewDidLoad() {
        signInButton.addTarget(
            self,
            action: #selector(signIn),
            for: .touchUpInside
        )
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    @objc func signIn() {
        let login = Login(
            eMail: emailTextField.text!,
            password: passwordTextField.text!
        )
        viewModel.auth(info: login) { (response) in
            switch response {
            case .success(let info):
                TokenContainer.token = info.token
                DispatchQueue.main.async {
                    self.present(OrdersView(), animated: true)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Something went wrong", message: error, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                        self.emailTextField.text = ""
                        self.passwordTextField.text = ""
                    })
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}
