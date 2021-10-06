//
//  DefaultCompaniesRepository.swift
//  DemoApp
//
//  Created by Hiram Castro Maldonado on 05/10/21.
//

import Foundation

final class DefaultCompaniesRepository {
    
    private let dataTransferService: DataTransferService
    
    init(dataTransferService:DataTransferService) {
        self.dataTransferService = dataTransferService
    }
    
}

extension DefaultCompaniesRepository:CompaniesRepository {
    
    func fetchCampanies(query: SearchQuery, completion: @escaping (Result<CompanyModel, Error>) -> Void) -> Cancellable? {
        
        let task = RepositoryTask()
        let requestDTO = CompaniesRequestDTO(query: query.query)
        
        let endpoint = APIEndpoints.getCompanies(withName: requestDTO.query)
        
        task.networkTask = self.dataTransferService.request(with: endpoint, completion: { result in
            switch result {
            case .success(let companyModel):
                completion(.success(companyModel))
            case .failure(let error):
                completion(.failure(error))
            }
        })
        
        return task
    }
    
    
}
