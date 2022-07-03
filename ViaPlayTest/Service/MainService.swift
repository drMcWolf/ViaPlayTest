import Foundation

protocol MainServiceProtocol: AnyObject {
    func obtain(completion: @escaping (Result<[VPSection], Error>) -> Void)
    func obtainDetails(section: VPSection, completion: @escaping (Result<Void, Error>) -> Void)
}

final class MainService {
    private let api: MainApiServiceProtocol
    private let storage: StorageManagerProtocol
    
    init(api: MainApiServiceProtocol, storage: StorageManagerProtocol) {
        self.api = api
        self.storage = storage
    }
}

extension MainService: MainServiceProtocol {
    func obtain(completion: @escaping (Result<[VPSection], Error>) -> Void) {
        api.fetchSections { result in
            switch result {
                case let .success(dto):
                var models: [VPSection] = []
                    
                    dto.forEach { sectionDto in
                        if let section = self.storage.findFirsOrCreate(new: VPSection.self, by: "id", with: sectionDto.id) {
                            section.id = sectionDto.id
                            section.link = sectionDto.href.replacingOccurrences(of: "{?dtg,productsPerPage}", with: "")
                            section.title = sectionDto.title
                            models.append(section)
                        }
                    }
                
                    self.storage.saveContext()
                    completion(.success(models))
                case let .failure(error):
                    let sections = self.storage.find(type: VPSection.self)
                    if !sections.isEmpty {
                        completion(.success(sections))
                    }else {
                        completion(.failure(error))
                    }
            }
        }
    }
    
    func obtainDetails(section: VPSection, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let link = section.link else {
            completion(.failure(ErrorDTO(code: -1, message: "Unable to process the url")))
            return
        }
        api.fetchSectionDetails(link: link) { result in
            switch result {
            case let .success(dto):
                section.sectionDescription = dto.description
                self.storage.saveContext()
                completion(.success(()))
            case let .failure(error):
                if section.sectionDescription != nil {
                    completion(.success(()))
                }else {
                    completion(.failure(error))
                }
            }
        }
    }
}
