//
//  Image.swift
//  PhotoGallery
//
//  Created by Djuro Alfirevic on 12/15/19.
//  Copyright © 2019 Incode Technologies. All rights reserved.
//

import Foundation

struct Image: Codable {
    
    // MARK: - Properties
    let comment: String
    let picture: String
    let id: String
    let publishedAt: String
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title
        case publishedAt
        case picture
        case comment
    }
    
}
