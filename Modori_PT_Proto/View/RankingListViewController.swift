//
//  RankingListViewController.swift
//  Modori_PT_Proto
//
//  Created by Modori on 2022/03/15.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class RankingListViewController: UITableViewController {
    var ref = Database.database().reference()   // firebase realtime database 
    var ExerciseList:[String : Int64] = [:]
    
    //구조체로 데이터 구조틀만 만듬
    var memberDataList: [MemberData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let uid = Auth.auth().currentUser?.uid ?? "UID"
        ref.child("Workout/Users/\(uid)").observe(DataEventType.value, with: { snapshot in
            guard let value = snapshot.value as? [String: Int64] else {
                print(snapshot)
                return
            }
            value.forEach{
                self.ExerciseList[($0).key] = ($0).value
            }
        })
        
        //UITableView Cell Resisger
        let nibName = UINib(nibName: "RankingListCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "RankingListCell")
        
        self.ref = Database.database().reference()
        
        //value -> jsonData -> memberData -> rankingList -> memberdataList
        //아래의 guard let으로 할당한 value 변수 값이 uid 값임
        self.ref.child("Rank/Users").observe(.value) { snapshot in
            guard let value = snapshot.value as? [String: [String: Any]] else { return }
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: value)
                let memberData = try JSONDecoder().decode([String: MemberData].self, from: jsonData)
                let rankingList = Array(memberData.values)
                
                // 각 cell 총점별 정렬
                self.memberDataList = rankingList.sorted { $0.TotalPoint  > $1.TotalPoint
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
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
        
        //순위 탭에서 각 셀에 들어가는 랭킹, 점수, 이름
        cell.rankLabel.text = "\(indexPath.row + 1)위"
        cell.pointsLabel.text = "\(memberDataList[indexPath.row].TotalPoint)점"
        cell.userNameLabel.text = "\(memberDataList[indexPath.row].Name)"
        
        return cell
    }
    
    //cell height
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //상세화면 전달
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let detailViewController = storyboard.instantiateViewController(withIdentifier: "RankingDetailViewController") as? RankingDetailViewController else { return }
        //detail뷰로 내용 전달
        detailViewController.exerciseDetail = memberDataList[indexPath.row].EachPoints
        detailViewController.ExerciseList = ExerciseList
        self.show(detailViewController, sender: nil)
    }
}
