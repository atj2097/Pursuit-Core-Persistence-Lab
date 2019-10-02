//
//  PersistenceData.swift
//  fileManagerApp
//
//  Created by God on 10/1/19.
//  Copyright © 2019 God. All rights reserved.
//

import Foundation

struct ImagePersistenceHelper {
    static let manager = ImagePersistenceHelper()

    func save(newImage: Hit) throws {
        try persistenceHelper.save(newElement: newImage)
    }

    func getImages() throws -> [Hit] {
        return try persistenceHelper.getObjects()
    }

    private let persistenceHelper = PersistenceHelper<Hit>(fileName: "image.plist")

    private init() {}
}
