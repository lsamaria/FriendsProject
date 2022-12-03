//
//  LoginController.swift
//  FriendsProject
//
//  Created by LanceMacBookPro on 12/1/22.
//

import UIKit

final class LoginController: UIViewController {
    
    // MARK: - Init
    init(loginViewModel: LoginViewModel) {
        self.loginViewModel = loginViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Ivars
    private let loginViewModel: LoginViewModel
    
    private let disabledLoginButtonAlpha: CGFloat = 0.3
    
    // MARK: - UIElements
    private lazy var emailTextField: UITextField = {
        let textField = UITextField.createTextField(delegate: self, placeholderText: "Enter Email Address", keyboardType: .emailAddress)
        textField.addTarget(self, action: #selector(handleTextFieldInputWhileEditing), for: .editingChanged)
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField.createTextField(delegate: self, placeholderText: "Enter Password", keyboardType: .default)
        textField.addTarget(self, action: #selector(handleTextFieldInputWhileEditing), for: .editingChanged)
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton.createButton(title: "Login", bgColor: .systemIndigo, alpha: disabledLoginButtonAlpha)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        button.addTarget(self, action: #selector(dismissKeyboard), for: .touchUpInside)
        return button
    }()
    
    private lazy var networkSpinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView.createActivityIndicatorView()
        spinner.center = view.center
        return spinner
    }()
    
    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUILayout()
        
        addTapGestureRecognizer()
    }
}

// MARK: - Login Button Tapped
extension LoginController {
    
    @objc private func loginButtonTapped() {
        
        showNetworkSpinnerAndDisableUIElements(true)
        
        loginViewModel.logUserIn(with: emailTextField.text, passwordText: passwordTextField.text) { [weak self](result) in
            DispatchQueue.main.async { [weak self] in
                
                self?.check(result)
                
                self?.showNetworkSpinnerAndDisableUIElements(false)
            }
        }
    }
    
    private func check(_ result: Result<Bool, FakeSessionError>) {
        
        switch result {
        
        case .failure(let fakeSessionError):
            
            showAlert(title: "Invalid Credentials", message: "\(fakeSessionError).")
            
        case .success(_):
            
            presentHomeVC()
        }
    }
}

// MARK: - Present HomeVC
extension LoginController {
    
    private func presentHomeVC() {
        
        let homeVC = loginViewModel.createHomeVC()
        
        let navVC = UINavigationController(rootViewController: homeVC)
        navVC.modalPresentationStyle = .overFullScreen
        present(navVC, animated: true, completion: { [weak self] in
            self?.setTextFieldsToNil()
        })
    }
    
    private func setTextFieldsToNil() {
        emailTextField.text = nil
        passwordTextField.text = nil
    }
}

// MARK: - Enable/Disable UIElements
extension LoginController {
    
    private func showNetworkSpinnerAndDisableUIElements(_ val: Bool) {
        
        if val {
            networkSpinner.startAnimating()
        } else {
            networkSpinner.stopAnimating()
        }
        
        disableUIElements(val)
    }
    
    private func disableUIElements(_ val: Bool) {
        
        emailTextField.isEnabled = !val
        passwordTextField.isEnabled = !val
        loginButton.isUserInteractionEnabled = !val
    }
}

// MARK: - Check TextField Input
extension LoginController {
    
    @objc private func handleTextFieldInputWhileEditing() {
        
        let areTextFieldsEmpty = loginViewModel.isEmailTextFieldOrPasswordTextFieldEmpty(emailText: emailTextField.text, passwordText: passwordTextField.text)
        
        loginButton.isEnabled = !areTextFieldsEmpty
        
        loginButton.alpha = areTextFieldsEmpty ? disabledLoginButtonAlpha : 1
    }
}

// MARK: - UITextFieldDelegate
extension LoginController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        return true
    }
}

// MARK: - Gesture Recognizer
extension LoginController {
    
    private func addTapGestureRecognizer() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - LayoutUI
extension LoginController {
    
    fileprivate func setupUILayout() {
        
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(networkSpinner)
        
        let padding: CGFloat = 16
        let height: CGFloat = 50
        
        emailTextField.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -padding).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        passwordTextField.bottomAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: padding).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
}
