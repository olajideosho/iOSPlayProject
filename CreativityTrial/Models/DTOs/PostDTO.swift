//
//  PostDTO.swift
//  CreativityTrial
//
//  Created by Olajide Osho on 03/07/2021.
//

import Foundation

struct PostDTO: Codable {
    let userId: Int?
    let id: Int?
    let title: String?
    let body: String?
}
