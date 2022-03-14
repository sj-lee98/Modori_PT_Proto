//
//  MainViewController.swift
//  Modori_PT_Proto
//
//  Created by 이성주 on 2022/01/25.
//

import UIKit
import FirebaseAuth

class SettingViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 네이게이션 뒤로가기 버튼 비활성화 (로그인 후 메인 화면에서 뒤로가기 하면 ?? 어색)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 네비게이션 바 숨기기
        navigationController?.navigationBar.isHidden = true
        
        // Firebase 이메일 가져와서 출력 없으면 고객
        let email = Auth.auth().currentUser?.email ?? "고객"
        welcomeLabel.text = """
        환영합니다.
        \(email)님
        """
        
    }
    
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
            self.navigationController?.popToRootViewController(animated: true)
        } catch let sighOutError as NSError {
            print("LogOut 중에 Error 발생 : \(sighOutError.localizedDescription)")
        }
        
        self.LoginViewController()
    }
    
    
    private func LoginViewController() {
    
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let loginViewController = storyboard.instantiateViewController(identifier: "InitialView")

        loginViewController.modalPresentationStyle = .fullScreen
        loginViewController.modalTransitionStyle = .flipHorizontal

        navigationController?.show(loginViewController, sender: nil)
        
    }
}
