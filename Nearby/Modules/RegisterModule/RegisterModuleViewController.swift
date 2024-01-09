//
//  RegisterModuleViewController.swift
//  Nearby
//
//  Created by Мельник Дмитрий on 31.12.2023.
//  
//

import UIKit
import SnapKit
import CoreData

final class RegisterModuleViewController: BaseControllerWithHeader {

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
    }


    // MARK: - Properties
    lazy var loginTextField: TextField = {
        let textField = TextField()
        textField.isSecureTextEntry = false
        textField.placeholder = "Login"
        textField.layer.cornerRadius = 10
        textField.autocapitalizationType = .none
        textField.backgroundColor = .defaultGrayTextFieldColor
        return textField
    }()

    lazy var emailTextField: TextField = {
        let textField = TextField()
        textField.isSecureTextEntry = false
        textField.placeholder = "Email"
        textField.layer.cornerRadius = 25
        textField.autocapitalizationType = .none
        textField.backgroundColor = .defaultGrayTextFieldColor
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor(hex: "#846340").cgColor
        return textField
    }()

    lazy var passwordTextField: TextField = {
        let textField = TextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.layer.cornerRadius = 25
        textField.autocapitalizationType = .none
        textField.backgroundColor = .defaultGrayTextFieldColor
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor(hex: "#846340").cgColor
        return textField
    }()

    lazy var confirmPasswordTextField: TextField = {
        let textField = TextField()
        textField.placeholder = "Confirm password"
        textField.isSecureTextEntry = true
        textField.layer.cornerRadius = 25
        textField.autocapitalizationType = .none
        textField.backgroundColor = .defaultGrayTextFieldColor
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor(hex: "#846340").cgColor
        return textField
    }()

    // MARK: View Input (View -> Presenter)
    var presenter: ViewToPresenterRegisterModuleProtocol?

    // MARK: View Input (View -> Output)
    private var output: PresenterToViewRegisterModuleProtocol?

    private var signInButton = UIButton()
    private var signUpButton = UIButton()
    private var passwordArray = [String]()
    private var emailLabel = UILabel(style: .baseTextFieldViewStyle.compose(with: ViewStyle<UILabel> {
        $0.textAlignment = .center
    }))
    private var passwordLabel = UILabel(style: .baseTextFieldViewStyle.compose(with: ViewStyle<UILabel> {
        $0.textAlignment = .center
    }))
    private var confirmPasswordLabel = UILabel(style: .baseTextFieldViewStyle.compose(with: ViewStyle<UILabel> {
        $0.textAlignment = .center
    }))


    init() {
        super.init(type: .withTitle(title: "Регистрация", backButton: .none))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: - signInTapped
    @objc func signInTapped() {
        presenter?.signInTapped()
    }

    private func setupUI() {
        emailLabel.text = "e-mail"
        passwordLabel.text = "Пароль"
        confirmPasswordLabel.text = "Подтвердите пароль"
        signInButton = UIButton(style: .sighUpButtonStyle)
        signUpButton = UIButton(style: .sighUpButtonStyle)

        signInButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)

        signUpButton.setTitle("Регистрация", for: .normal)
        signInButton.setTitle("Вход", for: .normal)

        self.contentView.backgroundColor = .white

        contentView.addSubview(loginTextField)
        contentView.addSubview(emailTextField)
        contentView.addSubview(passwordTextField)
        contentView.addSubview(confirmPasswordTextField)
        contentView.addSubview(emailLabel)
        contentView.addSubview(passwordLabel)
        contentView.addSubview(confirmPasswordLabel)
        contentView.addSubview(signInButton)
        contentView.addSubview(signUpButton)

        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        confirmPasswordLabel.translatesAutoresizingMaskIntoConstraints = false

    }

    // MARK: - setupLayout
    private func setupLayout() {
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
        confirmPasswordLabel.snp.makeConstraints {
            $0.left.equalTo(contentView.snp.left).offset(25)
            $0.top.equalTo(passwordTextField.snp.bottom).offset(20)
        }
        confirmPasswordTextField.snp.makeConstraints {
            $0.left.equalTo(contentView.snp.left).offset(25)
            $0.right.equalTo(contentView.snp.right).offset(-25)
            $0.height.equalTo(52)
            $0.top.equalTo(confirmPasswordLabel.snp.bottom).offset(10)
            $0.centerX.equalTo(emailTextField.snp.centerX)
        }
        signUpButton.snp.makeConstraints {
            $0.left.equalTo(contentView.snp.left).offset(25)
            $0.right.equalTo(contentView.snp.right).offset(-25)
            $0.top.equalTo(confirmPasswordTextField.snp.bottom).offset(30)
            $0.height.equalTo(52)
            $0.centerX.equalTo(contentView.snp.centerX)
        }
        signInButton.snp.makeConstraints {
            $0.left.equalTo(contentView.snp.left).offset(25)
            $0.right.equalTo(contentView.snp.right).offset(-25)
            $0.top.equalTo(signUpButton.snp.bottom).offset(30)
            $0.height.equalTo(52)
            $0.centerX.equalTo(contentView.snp.centerX)
        }
    }
}


extension RegisterModuleViewController: PresenterToViewRegisterModuleProtocol {
    // TODO: Implement View Output Methods

    // MARK: - signUpTapped
    @objc func signUpTapped() {
        presenter?.signUp(emailField: emailTextField.text ?? "", passwordField: passwordTextField.text ?? "", confirmField: confirmPasswordTextField.text ?? "")
    }

    func showAlert(error type: TypesOfAlert) {
        
    }
}
