//
//  VPContentResponseDTO.swift
//  ViaPlayTest
//
//  Created by Ivan Makarov on 02.07.2022.
//

import Foundation

struct VPContentResponseDTO: Decodable {
    let links: VPLink
    
    enum CodingKeys: String, CodingKey {
        case links = "_links"
    }
    
}

struct VPLink: Decodable {
    let sections: [VPSectionDTO]
    
    enum CodingKeys: String, CodingKey {
        case sections = "viaplay:sections"
    }
    
}
