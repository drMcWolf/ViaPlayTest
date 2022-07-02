//
//  VPCategory.swift
//  ViaPlayTest
//
//  Created by Ivan Makarov on 02.07.2022.
//

import Foundation

struct VPSection {
    let id: String
    let title: String
    let link: String
    
    init(dto: VPSectionDTO) {
        self.id = dto.id
        self.title = dto.title
        link = dto.href
    }
}
