//
//  WelcomeViewModel.swift
//  Assignment-clonecoding
//
//  Created by 송여경 on 6/7/24.
//

import Foundation
import RxSwift
import RxCocoa

class WelcomeViewModel {
    // MARK: - Input
    let id: BehaviorRelay<String?>
    
    // MARK: - Output
    let welcomeText: Observable<String>
    
    init(id: String?) {
        self.id = BehaviorRelay(value: id)
        
        welcomeText = self.id
            .map { id in
                let username = id ?? "Guest"
                return "\(username)님 \n반가워요!"
            }
            .asObservable()
    }
}
