//
//  NetworkManager.swift
//  Marvel_Discovery
//
//  Created by eng-oday on 05/01/2024.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire


protocol NetworkService {
    func request<T: Decodable>(_ endpoint: Endpoint) -> Single<T>
}

extension NetworkService {
    func request<T: Decodable>(_ endpoint: Endpoint) -> Single<T>
    {
        return Single.create { single in
                let request = AF.request(endpoint)
                   .responseDecodable(of:T.self){ response in
                       switch response.result {
                       case .success(let data):
                           print(data)
                           single(.success(data))
                       case .failure(let error):
                           print(error)
                           single(.failure(error))
                       }
            }
            return Disposables.create()
        }

    }
}

