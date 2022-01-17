//
//  Character.swift
//  HeroesMVP
//
//  Created by Daniel Rincon on 19/02/2021.
//

import Foundation

public struct Character: Hashable {
    var characterId: Int
    var name: String
    let description: String
    var thumbnailUrl: String
    var imgData: Data?

    private enum CodingKeys: String, CodingKey {
        case characterId = "id"
        case name
        case thumbnail
        case description
    }

    private enum ThumbnailKeys: String, CodingKey {
        case path
        case ext = "extension"
    }
}

extension Character: Decodable {
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.characterId = try values.decode(Int.self, forKey: .characterId)
        self.name = try values.decode(String.self, forKey: .name)
        self.description = try values.decode(String.self, forKey: .description)

        let thumbnail = try values.nestedContainer(keyedBy: ThumbnailKeys.self, forKey: .thumbnail)
        let path = try thumbnail.decode(String.self, forKey: .path).replacingOccurrences(of: "http", with: "https")
        let ext = try thumbnail.decode(String.self, forKey: .ext)
        self.thumbnailUrl = "\(path).\(ext)"
    }
}
