//
//  LoginViewController.swift
//  Modori_PT_Proto
//
//  Created by 이성주 on 2022/01/25.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailLoginButton: UIButton!
    @IBOutlet weak var appleLoginButton: UIButton!
    @IBOutlet weak var googleLoginButton: UIButton!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        // 네비게이션 컨트롤러가 네비게이션바를 가지고 있고 그것을 숨김.
        navigationController?.navigationBar.isHidden = true
        
    }
    
    
    
    @IBAction func appleLoginButtonTapped(_ sender: UIButton) {
        // Firebase 인증
    }
    @IBAction func googleLoginButtonTapped(_ sender: UIButton) {
        // Firebase 인증
    }
    
    
}
