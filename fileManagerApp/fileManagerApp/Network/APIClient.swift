//
//  APIClient.swift
//  fileManagerApp
//
//  Created by God on 10/1/19.
//  Copyright © 2019 God. All rights reserved.
//


//
import Foundation

class PixabayAPIManager {
    private init() {}

    static let shared = PixabayAPIManager()

    func getImages(searchWord: String, completionHandler: @escaping (Result<[Hit], AppError>) -> Void) {
        let urlStr = "https://pixabay.com/api/?key=13804220-31078e62f469c96f42932130a&q=\(searchWord.replaceSpaces())&image_type=photo"
        guard let url = URL(string: urlStr) else {
            completionHandler(.failure(.badURL))
            return
        }


        NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
            switch result {
            case .failure(let error) :
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let imageInfo = try JSONDecoder().decode(Images.self, from: data)
                    completionHandler(.success(imageInfo.hits!))
                } catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        }
    }
}
//
//    func postImages((elementName)): (insertName), completionHandler: @escaping (Result<Data, AppError>) -> Void) {
//        let (name)Wrapper = (name)Info(results: [(name)])
//        guard let encodedData = try? JSONEncoder().encode((nameWrapper)) else {
//            fatalError("encoder failed")
//        }
//        let urlStr = ""
//        guard let url = URL(string: urlStr) else {
//            completionHandler(.failure(.badURL))
//            return
//        }
//        NetworkHelper.manager.performDataTask(withUrl: url, andHTTPBody: encodedData, andMethod: .post) { (result) in
//            switch result {
//            case .success(let data):
//                completionHandler(.success(data))
//            case .failure(let error) :
//                completionHandler(.failure(error))
//            }
//        }
//
//    }
//
//}
//
//
//
