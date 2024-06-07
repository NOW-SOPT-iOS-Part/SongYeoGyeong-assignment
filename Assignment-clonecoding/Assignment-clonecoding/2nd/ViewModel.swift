//
//  ViewModel.swift
//  Assignment-clonecoding
//
//  Created by 송여경 on 6/7/24.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel {
    
    // MARK: - Inputs
    let idText = BehaviorRelay<String>(value: "")
    let passwordText = BehaviorRelay<String>(value: "")
    
    // MARK: - Outputs
    let isLoginButtonEnabled: Observable<Bool>
    
    init() {
        isLoginButtonEnabled = Observable.combineLatest(idText, passwordText)
            .map { id, password in
                return !id.isEmpty && password.count >= 4
            }
            .share(replay: 1)
    }
    
    func clearID() {
        idText.accept("")
    }
    
    func clearPassword() {
        passwordText.accept("")
    }
}
