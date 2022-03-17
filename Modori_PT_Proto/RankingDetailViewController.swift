//
//  RankingDetailViewController.swift
//  Modori_PT_Proto
//
//  Created by 이성주 on 2022/03/15.
//

import UIKit
import Lottie

class RankingDetailViewController: UIViewController {
    
    var exerciseDetail: ExerciseDetail?
    
    @IBOutlet weak var lottieView: AnimationView!
    @IBOutlet weak var squatPoints: UILabel!
    @IBOutlet weak var lungePoints: UILabel!
    @IBOutlet weak var crunchPoints: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //// Add lottie
//        let animationView = AnimationView(name: "dumbell")
//        lottieView.contentMode = .scaleAspectFit
//        lottieView.addSubview(animationView)
//        animationView.frame = lottieView.bounds
//        animationView.loopMode = .loop
//        animationView.play()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let detail = exerciseDetail else { return }
        
        squatPoints.text = "\(detail.squatPoints)"
        lungePoints.text = "\(detail.lungePoints)"
        crunchPoints.text = "\(detail.crunchPoints)"
    }
}
