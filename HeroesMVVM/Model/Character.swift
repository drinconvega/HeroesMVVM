//
//  Character.swift
//  HeroesMVP
//
//  Created by Daniel Rincon on 19/02/2021.
//

import Foundation

// MARK: - Result
struct Character: Codable, Hashable {
    let id: Int
    let name, resultDescription: String
    //let modified: Date
    let thumbnail: Thumbnail
    /*let resourceURI: String
    let comics, series: Comics?
    let stories: Stories?
    let events: Comics?
    let urls: [URLElement]
*/
    enum CodingKeys: String, CodingKey {
        case id, name
        case resultDescription = "description"
        case thumbnail//, modified, resourceURI, comics, series, stories, events, urls
    }
    
    static let previewHeroe = Character(id: 0000, name: "SuperPrueba", resultDescription:"Prueba de texto muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy grande ", thumbnail: Thumbnail(path: "https://cdn-icons-png.flaticon.com/512/1705/1705780", thumbnailExtension: .png))
}

// MARK: - Comics
struct Comics: Codable, Hashable {
    let available: Int
    let collectionURI: String
    let items: [ComicsItem]
    let returned: Int
}

// MARK: - ComicsItem
struct ComicsItem: Codable, Hashable {
    let resourceURI: String
    let name: String
}

// MARK: - Stories
struct Stories: Codable, Hashable {
    let available: Int
    let collectionURI: String
    let items: [StoriesItem]
    let returned: Int
}

// MARK: - StoriesItem
struct StoriesItem: Codable, Hashable {
    let resourceURI: String
    let name: String
    let type: ItemType
}

enum ItemType: String, Codable {
    case cover = "cover"
    case empty = ""
    case interiorStory = "interiorStory"
}

// MARK: - Thumbnail
struct Thumbnail: Codable, Hashable {
    let path: String
    let thumbnailExtension: Extension

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

enum Extension: String, Codable {
    case gif = "gif"
    case jpg = "jpg"
    case png = "png"
}

// MARK: - URLElement
struct URLElement: Codable, Hashable {
    let type: URLType
    let url: String
}

enum URLType: String, Codable {
    case comiclink = "comiclink"
    case detail = "detail"
    case wiki = "wiki"
}
