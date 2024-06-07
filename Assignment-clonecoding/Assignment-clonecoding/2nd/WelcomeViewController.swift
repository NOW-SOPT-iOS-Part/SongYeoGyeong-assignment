//
//  WelcomeViewController.swift
//  Assignment-clonecoding
//
//  Created by 송여경 on 4/20/24.
//

import UIKit
import RxSwift
import SnapKit

class WelcomeViewController: UIViewController {
    var viewModel: WelcomeViewModel!
    private let disposeBag = DisposeBag()
    
    // MARK: UI
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(.bold, size: 23)
        label.textAlignment = .center
        label.textColor = .gray214
        label.numberOfLines = 2
        return label
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Tiving")
        return imageView
    }()
    
    private lazy var mainButton: UIButton = {
        let button = UIButton()
        button.setTitle("메인으로", for: .normal)
        button.backgroundColor = .gray255
        button.setTitleColor(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1), for: .normal)
        button.titleLabel?.font = .pretendard(.semiBold, size: 18)
        button.addTarget(self, action: #selector(goToMain), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initializer
    init(viewModel: WelcomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        setUpLayout()
        setUpConstraint()
        setupBindings()
    }
    
    // MARK: - setUpLayout
    private func setUpLayout() {
        [logoImageView, welcomeLabel, mainButton].forEach {
            self.view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    // MARK: - setUpConstraint
    private func setUpConstraint() {
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(58)
            make.width.equalTo(375)
            make.height.equalTo(210.94)
        }
        
        welcomeLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(65)
            make.top.equalTo(logoImageView.snp.bottom).offset(67.06)
            make.height.equalTo(74)
        }
        
        mainButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().offset(694)
            make.height.equalTo(52)
        }
    }
    
    // MARK: - setupBindings
    private func setupBindings() {
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.welcomeText
            .bind(to: welcomeLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    @objc private func goToMain() {
        self.navigationController?.popViewController(animated: true)
    }
}
