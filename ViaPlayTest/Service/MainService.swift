import Foundation

protocol MainServiceProtocol: AnyObject {
    func obtain(completion: @escaping (Result<[VPSection], Error>) -> Void)
    func obtainDetails(section: VPSection, completion: @escaping (Result<VPSectionDetails, Error>) -> Void)
}

final class MainService {
    private let api: MainApiServiceProtocol
    
    init(api: MainApiServiceProtocol) {
        self.api = api
    }
}

extension MainService: MainServiceProtocol {
    func obtain(completion: @escaping (Result<[VPSection], Error>) -> Void) {
        api.fetchSections { result in
            switch result {
                case let .success(dto):
                    let models = dto.map { VPSection(dto: $0) }
                    completion(.success(models))
                case let .failure(error):
                    completion(.failure(error))
            }
        }
    }
    
    func obtainDetails(section: VPSection, completion: @escaping (Result<VPSectionDetails, Error>) -> Void) {
        api.fetchSectionDetails(link: section.link) { result in
            switch result {
            case let .success(dto):
                completion(.success(VPSectionDetails(dto: dto)))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
