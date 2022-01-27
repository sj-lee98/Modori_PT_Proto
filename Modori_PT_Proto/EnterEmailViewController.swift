//
//  EnterEmailViewController.swift
//  Modori_PT_Proto
//
//  Created by 이성주 on 2022/01/25.
//

import UIKit
import FirebaseAuth

class EnterEmailViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 초기 뷰 로드시 다음 버튼 비활성화
        // 추후 이메일/비밀번호 입력완료시 활성화
        nextButton.isEnabled = false
        
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        // 뷰 로드시 이메일 칸에 커서 띄우기
        emailTextField.becomeFirstResponder()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Navigaion Bar 보이기
        navigationController?.navigationBar.isHidden = false
    }
    
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        // Firebase 이메일/비밀번호 인증
        let email = emailTextField.text ?? "" // 만일 빈 값일 경우 옵셔널 처리
        let password = passwordTextField.text ?? ""
        
        // Firebase 인증 플랫폼에 전달
        // 신규 사용자 생성
        Auth.auth().createUser(withEmail: email, password: password) {[weak self] authResult, error in guard let self = self else { return }
            
            
            self.showCameraViewController()
        }
    }
    private func showCameraViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let menuTabController = storyboard.instantiateViewController(identifier: "MenuTabController")
        menuTabController.modalPresentationStyle = .fullScreen
        navigationController?.show(menuTabController, sender: nil)
        
    }
}

extension EnterEmailViewController: UITextFieldDelegate {
    
    // 이메일/비밀번호 입력값이 있는지 확인해서 있으면 비활성화 되었던 다음 버튼 활성화
    func textFieldDidEndEditing(_ textField: UITextField) {
        let isEmailEmpty = emailTextField.text == ""
        let isPasswordEmpty = passwordTextField.text == ""
        
        nextButton.isEnabled = !isEmailEmpty && !isPasswordEmpty
    }
    
    
    // 입력 다 하고 리턴 버튼 누르면 키보드 내리기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
}
