//
//  CUUFeature.swift
//  CUU
//
//  Created by Lara Marie Reimer on 18.06.18.
//

import Foundation

struct CUUFeature : Decodable {
    let name: String
    let id: Int
    let steps: [String]
}
