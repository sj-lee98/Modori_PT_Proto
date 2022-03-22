//
//  RankingListViewController.swift
//  Modori_PT_Proto
//
//  Created by 이성주 on 2022/03/15.
//

import UIKit
import FirebaseDatabase

class RankingListViewController: UITableViewController {
    var ref: DatabaseReference!     // firebase realtime database reference -> db root
    
    var memberDataList: [MemberData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UITableView Cell Resisger
        let nibName = UINib(nibName: "RankingListCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "RankingListCell")
        
        self.ref = Database.database().reference()
        
        self.ref.observe(.value) { snapshot in
            guard let value = snapshot.value as? [String: [String: Any]] else { return }
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: value)
                let memberData = try JSONDecoder().decode([String: MemberData].self, from: jsonData)
                let rankingList = Array(memberData.values)
                
                // 각 cell 총점별 sort
                self.memberDataList = rankingList.sorted { $0.exerciseDetail.squatPoints + $0.exerciseDetail.lungePoints + $0.exerciseDetail.crunchPoints  > $1.exerciseDetail.squatPoints + $1.exerciseDetail.lungePoints + $1.exerciseDetail.crunchPoints
                    
                }
                
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let error {
                print("ERROR JSON parsing \(error.localizedDescription)")
            }
            
        }
        
    }
}
    
 extension RankingListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memberDataList.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RankingListCell", for: indexPath) as? RankingListCell else { return UITableViewCell() }
        
        //cell.rankLabel.text = "\((memberDataList[indexPath.row].id) + 1)위"
        cell.pointsLabel.text = "\(memberDataList[indexPath.row].exerciseDetail.crunchPoints + memberDataList[indexPath.row].exerciseDetail.lungePoints + memberDataList[indexPath.row].exerciseDetail.squatPoints)점"
        cell.userNameLabel.text = "\(memberDataList[indexPath.row].name)"
        
        return cell
    }
    
    // cell height
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
     
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 상세화면 전달
         let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
         guard let detailViewController = storyboard.instantiateViewController(withIdentifier: "RankingDetailViewController") as? RankingDetailViewController else { return }
         
         detailViewController.exerciseDetail = memberDataList[indexPath.row].exerciseDetail
         self.show(detailViewController, sender: nil)
     }
 }

