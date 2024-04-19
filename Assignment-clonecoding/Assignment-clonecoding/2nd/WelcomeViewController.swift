//
//  WelcomeViewController.swift
//  Assignment-clonecoding
//
//  Created by 송여경 on 4/20/24.
//

import Foundation
import UIKit

class WelcomeViewController: UIViewController {
    var id : String?
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Bold", size: 23)
        label.textAlignment = .center
        label.textColor = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1)
        label.numberOfLines = 2
        return label
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Tiving")
        return imageView
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        setLayout()
        updateWelcomeText()
    }
    
    
    private lazy var mainButton: UIButton = {
        let button = UIButton()
        button.setTitle("메인으로", for: .normal)
        button.backgroundColor = UIColor(red: 255/255, green: 20/255, blue: 60/255, alpha: 1)
        button.setTitleColor(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 18)
        button.addTarget(self, action: #selector(goToMain), for: .touchUpInside)
        return button
    }()
    
    private func setLayout() {
        [logoImageView,welcomeLabel,mainButton].forEach {
            self.view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(58)
            make.width.equalTo(375)
            make.height.equalTo(210.94)
        }
        
        welcomeLabel.snp.makeConstraints{make in
            make.left.right.equalToSuperview().inset(65)
            make.top.equalTo(logoImageView.snp.bottom).offset(67.06)
            make.height.equalTo(74)
            
        }
        
        mainButton.snp.makeConstraints{make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalToSuperview().offset(694)
            make.height.equalTo(52)
            
        }
        
    }
    
    @objc private func goToMain() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func updateWelcomeText() {
        let username = id ?? "Guest"
        welcomeLabel.text = "\(username)님 \n반가워요!"
    }
}
