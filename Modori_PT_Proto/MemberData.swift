//
//  MemberData.swift
//  Modori_PT_Proto
//
//  Created by 이성주 on 2022/03/15.
//

import Foundation

struct MemberData: Codable {
    let id: Int
    let rank: Int
    let name: String
    let exerciseDetail: ExerciseDetail
    let isSelected: Bool?
}

struct ExerciseDetail: Codable {
    let crunchPoints: Int
    let lungePoints: Int
    let squatPoints: Int
}
