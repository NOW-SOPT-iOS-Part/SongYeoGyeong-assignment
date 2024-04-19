//
//  LoginView.swift
//  Assignment-clonecoding
//
//  Created by 송여경 on 4/20/24.
//

import Foundation
import SnapKit
import UIKit

final class LoginView: UIViewController, UITextFieldDelegate {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "TIVING ID 로그인"
        label.textColor = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1.0)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = UIFont(name:"Pretendard-Medium", size: 23)
        return label
    }()
    
    private let idTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor(red: 156/255, green: 156/255, blue: 156/255, alpha: 1)
        textField.font = UIFont(name:"Pretendard-SemiBold", size: 15)
        textField.backgroundColor = UIColor(red: 46/255, green: 46/255, blue: 46/255, alpha: 1)
        
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white.withAlphaComponent(0.2),
            .font: UIFont(name: "Pretendard-SemiBold", size: 15) ?? UIFont.systemFont(ofSize: 15)
        ]
        
        textField.attributedPlaceholder = NSAttributedString(string: "아이디", attributes: placeholderAttributes)
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 22, height: 24))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        return textField
    }()

    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor(red: 156/255, green: 156/255, blue: 156/255, alpha: 1)
        textField.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        textField.backgroundColor = UIColor(red: 46/255, green: 46/255, blue: 46/255, alpha: 1)
        
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white.withAlphaComponent(0.2),
            .font: UIFont(name: "Pretendard-SemiBold", size: 15) ?? UIFont.systemFont(ofSize: 15)
        ]
        
        textField.attributedPlaceholder = NSAttributedString(string: "비밀번호", attributes: placeholderAttributes)
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 22, height: 24))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
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
        button.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    
    @objc func loginButtonDidTap(){
        //        presentToWelcomeVC()
        pushToWelcomeVC()
    }
    
    
    private func pushToWelcomeVC(){
        let welcomeViewController = WelcomeViewController()
        //        welcomeViewController.id = idTextField.text
        //        welcomeViewController.setLabelText(id: idTextField.text)
        self.navigationController?
            .pushViewController(welcomeViewController, animated: true)
    }
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        idTextField.delegate = self
        passwordTextField.delegate = self
        
        self.view.backgroundColor = .black
        setLayout()
        updateLoginButtonState()
    }
    
    private func setLayout() {
        [titleLabel, idTextField, passwordTextField, loginButton, findID, findPW, separatorLabel, noAccount, createNickname].forEach {
            self.view.addSubview($0)
        }
        
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

        DispatchQueue.main.async {
            self.updateLoginButtonState()
        }

        return true
    }


    
    private func updateLoginButtonState() {
        DispatchQueue.main.async {
            let isIdNotEmpty = !(self.idTextField.text?.isEmpty ?? true)
            let isPasswordValid = (self.passwordTextField.text?.count ?? 0) >= 4
            let isEnabled = isIdNotEmpty && isPasswordValid
            self.loginButton.isEnabled = isEnabled
            if isEnabled {
                self.loginButton.backgroundColor = UIColor(red: 255/255, green: 20/255, blue: 60/255, alpha: 1)
                self.loginButton.setTitleColor(UIColor.white, for: .normal)
            } else {
                self.loginButton.backgroundColor = UIColor.black
                self.loginButton.setTitleColor(UIColor(red: 156/255, green: 156/255, blue: 156/255, alpha: 1), for: .normal)
            }
        }
    }




    func textFieldDidEndEditing(_ textField: UITextField) {
        updateLoginButtonState()
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        DispatchQueue.main.async {
            self.updateLoginButtonState()
        }
        return true
    }

}

