import Foundation

public struct VPSection {
    let id: String
    let title: String
    let link: String
    
    init(dto: VPSectionDTO) {
        self.id = dto.id
        self.title = dto.title
        link = dto.href.replacingOccurrences(of: "{?dtg,productsPerPage}", with: "")
    }
}
