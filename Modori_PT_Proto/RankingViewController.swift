//
//  RankingViewController.swift
//  Modori_PT_Proto
//
//  Created by 이성주 on 2022/02/04.
//

import UIKit
import SwiftUI


class RankingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // viewcontroller 위에 swiftUI 얹기
        let rankingView = RankingListContent()
        let hostingVC = UIHostingController(rootView: rankingView)
        self.show(hostingVC, sender: nil)
        
    }
    
   
    
}
