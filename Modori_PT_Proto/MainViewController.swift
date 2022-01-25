//
//  MainViewController.swift
//  Modori_PT_Proto
//
//  Created by 이성주 on 2022/01/25.
//

import UIKit

class MainViewController: UIViewController {
    
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
        
    }
    
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        
        // 실제 로그아웃 구현은 아니고 단순한 첫번째 화면으로 돌아가기
        self.navigationController?.popToRootViewController(animated: true)
    }
}
