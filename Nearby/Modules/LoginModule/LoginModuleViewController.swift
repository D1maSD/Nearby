//
//  LoginModuleViewController.swift
//  Nearby
//
//  Created by Мельник Дмитрий on 31.12.2023.
//  
//

import UIKit

final class LoginModuleViewController: BaseControllerWithHeader {

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    init() {
        super.init(type: .withTitle(title: "Вход", backButton: .none))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private var emailLabel = UILabel(style: .baseTextFieldViewStyle.compose(with: ViewStyle<UILabel> {
        $0.textAlignment = .center

    }))
    private var passwordLabel = UILabel(style: .baseTextFieldViewStyle.compose(with: ViewStyle<UILabel> {
        $0.textAlignment = .center
    }))
    private var signInButton = UIButton()

    lazy var emailTextField: TextField = {
        let textField = TextField()
        textField.isSecureTextEntry = false
        textField.placeholder = "Email"
        textField.layer.cornerRadius = 25
        textField.autocapitalizationType = .none
        textField.backgroundColor = .defaultGrayTextFieldColor
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.brown.cgColor
        return textField
    }()
    lazy var passwordTextField: TextField = {
        let textField = TextField()
        textField.isSecureTextEntry = true
        textField.placeholder = "Password"
        textField.layer.cornerRadius = 25
        textField.autocapitalizationType = .none
        textField.backgroundColor = .defaultGrayTextFieldColor
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.brown.cgColor
        return textField
    }()
    // MARK: - Properties
    var presenter: ViewToPresenterLoginModuleProtocol?
    

    // MARK: - setUpLayout
    private func setup() {

        self.view.backgroundColor = .white
        emailLabel.text = "e-mail"
        passwordLabel.text = "Пароль"
        signInButton = UIButton(style: .sighUpButtonStyle)
        signInButton.setTitle("Войти", for: .normal)
        signInButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)

        contentView.addSubview(emailTextField)
        contentView.addSubview(passwordTextField)
        contentView.addSubview(emailLabel)
        contentView.addSubview(passwordLabel)
        contentView.addSubview(signInButton)

        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false

        emailLabel.snp.makeConstraints {
            $0.left.equalTo(contentView.snp.left).offset(25)
            $0.top.equalTo(contentView.snp.top).offset(100)
        }
        emailTextField.snp.makeConstraints {
            $0.left.equalTo(contentView.snp.left).offset(25)
            $0.right.equalTo(contentView.snp.right).offset(-25)
            $0.height.equalTo(52)
            $0.top.equalTo(emailLabel.snp.bottom).offset(10)
            $0.centerX.equalTo(contentView.snp.centerX)
        }
        passwordLabel.snp.makeConstraints {
            $0.left.equalTo(contentView.snp.left).offset(25)
            $0.top.equalTo(emailTextField.snp.bottom).offset(20)
        }

        passwordTextField.snp.makeConstraints {
            $0.left.equalTo(contentView.snp.left).offset(25)
            $0.right.equalTo(contentView.snp.right).offset(-25)
            $0.height.equalTo(52)
            $0.top.equalTo(passwordLabel.snp.bottom).offset(10)
            $0.centerX.equalTo(emailTextField.snp.centerX)
        }
        signInButton.snp.makeConstraints {
            $0.left.equalTo(contentView.snp.left).offset(25)
            $0.right.equalTo(contentView.snp.right).offset(-25)
            $0.top.equalTo(passwordTextField.snp.bottom).offset(30)
            $0.height.equalTo(52)
            $0.centerX.equalTo(contentView.snp.centerX)
        }
    }

    @objc func signInTapped() {
        guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            return
        }
        presenter?.signIn(emailField: email, passwordField: password)
    }
}


extension LoginModuleViewController: PresenterToViewLoginModuleProtocol{
    // TODO: Implement View Output Methods
}
