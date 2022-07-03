//
//  VPSectionDetails.swift
//  ViaPlayTest
//
//  Created by Ivan Makarov on 03.07.2022.
//

import Foundation

struct VPSectionDetails {
    let description: String
    
    init(dto: VPSectionDetailsDTO) {
        self.description = dto.description
    }
}
