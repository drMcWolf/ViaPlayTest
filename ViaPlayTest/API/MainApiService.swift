import Foundation

protocol MainApiServiceProtocol {
    func fetchCategories(completion: @escaping (Result<[VPSectionDTO], Error>) -> Void)
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
    func fetchCategories(completion: @escaping (Result<[VPSectionDTO], Error>) -> Void) {
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
}
