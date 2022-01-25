//
//  EnterEmailViewController.swift
//  Modori_PT_Proto
//
//  Created by 이성주 on 2022/01/25.
//

import UIKit

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
        
    }
}

extension EnterEmailViewController: UITextFieldDelegate {
    
    // 입력 다 하고 리턴 버튼 누르면 키보드 내리기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    // 이메일/비밀번호 입력값이 있는지 확인해서 있으면 비활성화 되었던 다음 버튼 활성화
    func textFieldDidEndEditing(_ textField: UITextField) {
        let isEmailEmpty = emailTextField.text == ""
        let isPasswordEmpty = passwordTextField.text == ""
        
        nextButton.isEnabled = !isEmailEmpty && !isPasswordEmpty
    }
}
