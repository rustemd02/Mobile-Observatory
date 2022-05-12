//
//  CrewMember.swift
//  Mobile-Observatory
//
//  Created by Рустем on 12.05.2022.
//

import Foundation

struct CrewMember: Codable {
    let name, agency: String
    let image: String
    let wikipedia: String
    let launches: [String]
    let status, id: String
}
