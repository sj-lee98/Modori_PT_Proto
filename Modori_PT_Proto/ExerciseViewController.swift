//
//  ExersiseViewController.swift
//  Modori_PT_Proto
//
//  Created by 이성주 on 2022/02/03.
//

import UIKit
import SwiftUI


class ExerciseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // viewcontroller 위에 swiftUI 얹기
        let exerciseView = ExersiseView()
        let hostingVC = UIHostingController(rootView: exerciseView)
        self.show(hostingVC, sender: nil)
        
    }
    
   
    
}
