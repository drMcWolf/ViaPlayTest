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
