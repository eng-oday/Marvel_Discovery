//
//  Endpoint.swift
//  Marvel_Discovery
//
//  Created by eng-oday on 05/01/2024.
//

import Foundation
import Alamofire
import CommonCrypto

protocol Endpoint:URLRequestConvertible {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
    var headers: HTTPHeaders? { get }
    func generateMarvelHash(timestamp: String, privateKey: String, publicKey: String) -> String
    func getCurrentTimestamp() -> String
}

enum MarvelEndpoint: Endpoint {
        
    case getMarvelCharacters(limit:Int)

    
    var baseURL:URL {
        return URL(string: MarvelURL.baseUrl)!
    }
    
    var path:String {
        switch self {
        case .getMarvelCharacters:
            return MarvelPath.charactersPath
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getMarvelCharacters:
            return .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getMarvelCharacters(let limit):
            return ["limit":limit,
                    "apikey" : MarvelKeys.publicKey,
                    "ts" : getCurrentTimestamp() ,
                    "hash" : generateMarvelHash(timestamp: getCurrentTimestamp(), privateKey: MarvelKeys.privateKey, publicKey: MarvelKeys.publicKey)
            ]
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .getMarvelCharacters:
            return HTTPHeaders(["Accept":"application/json"])
        }
    }
    
    
     func generateMarvelHash(timestamp: String, privateKey: String, publicKey: String) -> String {
        let hashString = timestamp + privateKey + publicKey
        if let data = hashString.data(using: .utf8) {
            var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
            _ = data.withUnsafeBytes {
                CC_MD5($0.baseAddress, CC_LONG(data.count), &digest)
            }
            return digest.map { String(format: "%02hhx", $0) }.joined()
        }
        return ""
    }
    
     func getCurrentTimestamp() -> String {
        return String(Int(Date().timeIntervalSince1970))
    }
        
    func asURLRequest() throws -> URLRequest {
            let url         = baseURL.appendingPathComponent(path)
            var request     = URLRequest(url: url)
            request.method  = method

        switch self {
        case .getMarvelCharacters:
            request = try URLEncoding.default.encode(request,with: parameters)
        }
        print(request)
            return request
        }
    }
