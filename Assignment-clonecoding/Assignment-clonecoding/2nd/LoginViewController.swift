//
//  LoginView.swift
//  Assignment-clonecoding
//
//  Created by 송여경 on 4/20/24.
//

import Foundation
import SnapKit
import UIKit
import RxSwift
import RxCocoa

final class LoginViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    // MARK: UI
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "TIVING ID 로그인"
        label.textColor = .gray214
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = .pretendard(.medium, size: 23)
        return label
    }()
    
    private lazy var idTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .gray156
        textField.font = .pretendard(.semiBold, size: 15)
        textField.backgroundColor = .gray46
        
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white.withAlphaComponent(0.2),
            .font: UIFont.pretendard(.semiBold, size: 15)
        ]
        
        textField.attributedPlaceholder = NSAttributedString(string: "아이디", attributes: placeholderAttributes)
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 22, height: 24))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        let clearButton = UIButton(type: .custom)
        clearButton.setImage(UIImage(named: "X"), for: .normal)
        clearButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        textField.rightView = clearButton
        textField.rightViewMode = .whileEditing
        
        clearButton.rx.tap
            .subscribe(onNext: { [weak self] in
                textField.text = ""
                self?.updateLoginButtonState()
            })
            .disposed(by: disposeBag)
        
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .gray156
        textField.font = .pretendard(.semiBold, size: 15)
        textField.backgroundColor = .gray46
        
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.gray156,
            .font: UIFont.pretendard(.semiBold, size: 15)
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "비밀번호", attributes: placeholderAttributes)
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 22, height: 24))
        textField.leftView = paddingView
        textField.leftViewMode = .always

        let rightViewContainer = UIView()
        textField.rightView = rightViewContainer
        textField.rightViewMode = .whileEditing

        let eyeButton = UIButton(type: .custom)
        eyeButton.setImage(UIImage(named: "EyesO"), for: .normal)
        eyeButton.setImage(UIImage(named: "EyesX"), for: .selected)
        
        eyeButton.rx.tap
            .subscribe(onNext: { [weak self] in
                eyeButton.isSelected.toggle()
                textField.isSecureTextEntry.toggle()
            })
            .disposed(by: disposeBag)

        let clearButton = UIButton(type: .custom)
        clearButton.setImage(UIImage(named: "X"), for: .normal)
        
        clearButton.rx.tap
            .subscribe(onNext: { [weak self] in
                textField.text = ""
                self?.updateLoginButtonState()
            })
            .disposed(by: disposeBag)

        rightViewContainer.addSubview(clearButton)
        rightViewContainer.addSubview(eyeButton)
        
        rightViewContainer.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.width.equalTo(80)
        }
        
        eyeButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
            make.width.height.equalTo(20)
        }
        
        clearButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(eyeButton.snp.right).offset(10)
            make.width.height.equalTo(20)
        }

        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        button.setTitle("로그인하기", for: .normal)
        button.setTitleColor(UIColor(red: 156/255, green: 156/255, blue: 156/255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 18)
        button.layer.borderColor = UIColor(red: 46/255, green: 46/255, blue: 46/255, alpha: 1).cgColor
        button.layer.borderWidth = 1

        button.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.loginButtonDidTap()
            })
            .disposed(by: disposeBag)
        
        return button
    }()
    
    private let findID: UIButton = {
        let button = UIButton()
        button.setTitle("아이디 찾기", for: .normal)
        button.titleLabel?.font = UIFont(name:"Pretendard-Light", size: 14)
        button.setTitleColor(UIColor(red: 156/255, green: 156/255, blue: 156/255, alpha: 1), for: .normal)
        return button
    }()
    
    private let separatorLabel: UILabel = {
        let label = UILabel()
        label.text = "|"
        label.textColor = UIColor(red: 46/255, green: 46/255, blue: 46/255, alpha: 1)
        label.font = UIFont(name: "Pretendard", size: 14)
        label.textAlignment = .center
        return label
    }()

    private let findPW: UIButton = {
        let button = UIButton()
        button.setTitle("비밀번호 찾기", for: .normal)
        button.titleLabel?.font = UIFont(name:"Pretendard-Light", size: 14)
        button.setTitleColor(UIColor(red: 156/255, green: 156/255, blue: 156/255, alpha: 1), for: .normal)
        return button
    }()
    
    private let noAccount: UILabel = {
        let label = UILabel()
        label.text = "아직 계정이 없으신가요?"
        label.font = UIFont(name:"Pretendard-Thin", size: 14)
        label.textColor = UIColor(red: 98/255, green: 98/255, blue: 98/255, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    private let createNickname: UIButton = {
        let button = UIButton()
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Pretendard", size: 14) ?? UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor(red: 156/255, green: 156/255, blue: 156/255, alpha: 1),
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        
        let attributedTitle = NSAttributedString(string: "닉네임 만들러가기", attributes: attributes)
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        return button
    }()
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        setUpLayout()
        setUpConstraint()
        bindTextFields()
        updateLoginButtonState()
    }
    
    private func bindTextFields() {
        let idTextObservable = idTextField.rx.text.orEmpty.asObservable()
        let passwordTextObservable = passwordTextField.rx.text.orEmpty.asObservable()
        
        Observable.combineLatest(idTextObservable, passwordTextObservable)
            .map { id, password in
                return !id.isEmpty && password.count >= 4
            }
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        Observable.combineLatest(idTextObservable, passwordTextObservable)
            .map { id, password in
                return !id.isEmpty && password.count >= 4
            }
            .subscribe(onNext: { [weak self] isEnabled in
                self?.updateLoginButtonAppearance(isEnabled: isEnabled)
            })
            .disposed(by: disposeBag)
    }
    
    private func updateLoginButtonAppearance(isEnabled: Bool) {
        if isEnabled {
            loginButton.backgroundColor = UIColor(red: 255/255, green: 20/255, blue: 60/255, alpha: 1)
            loginButton.setTitleColor(UIColor.white, for: .normal)
        } else {
            loginButton.backgroundColor = UIColor.black
            loginButton.setTitleColor(UIColor(red: 156/255, green: 156/255, blue: 156/255, alpha: 1), for: .normal)
        }
    }
    
    // MARK: - setUpLayout
    private func setUpLayout() {
        [
            titleLabel,
            idTextField,
            passwordTextField,
            loginButton,
            findID,
            findPW,
            separatorLabel,
            noAccount,
            createNickname
        ].forEach {
            self.view.addSubview($0)
        }
    }
    
    // MARK: - setUpConstraint
    private func setUpConstraint() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(90)
            make.left.equalToSuperview().inset(109)
            make.right.equalToSuperview().inset(110)
            make.width.equalTo(156)
            make.height.equalTo(37)
        }
        
        idTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(31)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(52)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(idTextField.snp.bottom).offset(7)
            make.left.right.equalTo(idTextField)
            make.height.equalTo(52)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(21)
            make.left.right.equalTo(idTextField)
            make.height.equalTo(52)
        }
        
        findID.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(31)
            make.left.equalToSuperview().inset(85)
            make.right.equalToSuperview().inset(228)
            make.height.equalTo(22)
        }
        
        findPW.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(31)
            make.left.equalToSuperview().inset(216)
            make.right.equalToSuperview().inset(86)
            make.height.equalTo(22)
        }
        
        noAccount.snp.makeConstraints { make in
            make.top.equalTo(findID.snp.bottom).offset(28)
            make.left.equalToSuperview().inset(51)
            make.right.equalToSuperview().inset(195)
            make.height.equalTo(22)
        }

        createNickname.snp.makeConstraints { make in
            make.top.equalTo(findPW.snp.bottom).offset(28)
            make.left.equalToSuperview().inset(213)
            make.right.equalToSuperview().inset(65)
            make.height.equalTo(22)
        }
        
        separatorLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(378)
            make.left.equalToSuperview().inset(180)
            make.right.equalToSuperview().inset(195)
            make.height.equalTo(12)
        }
    }
    
    private func updateLoginButtonState() {
        let isIdNotEmpty = !(self.idTextField.text?.isEmpty ?? true)
        let isPasswordValid = (self.passwordTextField.text?.count ?? 0) >= 4
        let isEnabled = isIdNotEmpty && isPasswordValid
        self.updateLoginButtonAppearance(isEnabled: isEnabled)
    }

    @objc func loginButtonDidTap() {
        guard let id = idTextField.text, !id.isEmpty else {
            return
        }
        
        let welcomeViewController = WelcomeViewController()
        welcomeViewController.id = id
        if let navigationController = self.navigationController {
            navigationController.pushViewController(welcomeViewController, animated: true)
        } else {

        }
    }
}
