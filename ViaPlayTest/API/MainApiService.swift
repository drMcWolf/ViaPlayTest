import Foundation

protocol MainApiServiceProtocol {
    func fetchSections(completion: @escaping (Result<[VPSectionDTO], Error>) -> Void)
    func fetchSectionDetails(link: String, completion: @escaping (Result<VPSectionDetailsDTO, Error>) -> Void)
}

final class MainApiService {
    private struct Constants {
        static let categoriesUrl = "https://content.viaplay.se/ios-se"
    }
    private let decoder: JSONDecoder = .init()
    private let networkLayer: NetworkLayerProtocol
    
    init(networkLayer: NetworkLayerProtocol) {
        self.networkLayer = networkLayer
    }
}

extension MainApiService: MainApiServiceProtocol {
    func fetchSections(completion: @escaping (Result<[VPSectionDTO], Error>) -> Void) {
        networkLayer.get(url: Constants.categoriesUrl) { result in
            switch result {
            case let .success(data):
                do {
                    let response = try self.decoder.decode(VPContentResponseDTO.self, from: data)
                    completion(.success(response.links.sections))
                }catch {
                    completion(.failure(error))
                }
            case  let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchSectionDetails(link: String, completion: @escaping (Result<VPSectionDetailsDTO, Error>) -> Void) {
        networkLayer.get(url: link) { result in
            switch result {
            case let .success(data):
                do {
                    let dto = try self.decoder.decode(VPSectionDetailsDTO.self, from: data)
                    completion(.success(dto))
                }catch {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
}
