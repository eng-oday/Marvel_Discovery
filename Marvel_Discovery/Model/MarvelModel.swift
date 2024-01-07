//
//  MarvelModel.swift
//  Marvel_Discovery
//
//  Created by eng-oday on 05/01/2024.
//

import Foundation

struct MarvelBase:Codable {
    let code : Int?
    let status : String?
    let copyright : String?
    let attributionText : String?
    let attributionHTML : String?
    let data : MarvelData?
    let etag : String?

    enum CodingKeys: String, CodingKey {

        case code = "code"
        case status = "status"
        case copyright = "copyright"
        case attributionText = "attributionText"
        case attributionHTML = "attributionHTML"
        case data = "data"
        case etag = "etag"
    }
}


struct MarvelData : Codable {
    let offset : Int?
    let limit : Int?
    let total : Int?
    let count : Int?
    let results : [Results]?
    
    enum CodingKeys: String, CodingKey {
        
        case offset = "offset"
        case limit = "limit"
        case total = "total"
        case count = "count"
        case results = "results"
    }
}


struct Results : Codable {
    let id : Int?
    let name : String?
    let description : String?
    let modified : String?
    let resourceURI : String?
    let urls : [Urls]?
    let thumbnail : Thumbnail?
    let comics : Comics?
    let stories : Stories?
    let events : Events?
    let series : Series?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case name = "name"
        case description = "description"
        case modified = "modified"
        case resourceURI = "resourceURI"
        case urls = "urls"
        case thumbnail = "thumbnail"
        case comics = "comics"
        case stories = "stories"
        case events = "events"
        case series = "series"
    }
}

struct Comics : Codable {
    let available : Int?
    let returned : Int?
    let collectionURI : String?
    let items : [Items]?
    
    enum CodingKeys: String, CodingKey {
        
        case available = "available"
        case returned = "returned"
        case collectionURI = "collectionURI"
        case items = "items"
    }
}

struct Events : Codable {
    let available : Int?
    let returned : Int?
    let collectionURI : String?
    let items : [Items]?
    
    enum CodingKeys: String, CodingKey {
        
        case available = "available"
        case returned = "returned"
        case collectionURI = "collectionURI"
        case items = "items"
    }
}

struct Series : Codable {
    let available : Int?
    let returned : Int?
    let collectionURI : String?
    let items : [Items]?
    
    enum CodingKeys: String, CodingKey {
        
        case available = "available"
        case returned = "returned"
        case collectionURI = "collectionURI"
        case items = "items"
    }
}

struct Stories : Codable {
    let available : Int?
    let returned : Int?
    let collectionURI : String?
    let items : [Items]?
    
    enum CodingKeys: String, CodingKey {
        
        case available = "available"
        case returned = "returned"
        case collectionURI = "collectionURI"
        case items = "items"
    }
}

struct Items : Codable {
    let resourceURI : String?
    let name : String?
    
    enum CodingKeys: String, CodingKey {
        
        case resourceURI = "resourceURI"
        case name = "name"
    }
}

struct Thumbnail : Codable {
    let path : String?
    let `extension` : String?
    
    enum CodingKeys: String, CodingKey {
        
        case path = "path"
        case `extension` = "extension"
    }
}



struct Urls : Codable {
    let type : String?
    let url : String?
    
    enum CodingKeys: String, CodingKey {
        
        case type = "type"
        case url = "url"
    }
}
