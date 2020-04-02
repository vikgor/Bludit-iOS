//
//  BluditAPI.swift
//  Bludit
//
//  Created by Viktor Gordienko on 4/2/20.
//  Copyright © 2020 Viktor Gordienko. All rights reserved.
//

import Foundation

class BluditAPI {
    
    public static let shared = BluditAPI()
    private let session = URLSession.shared
    private var components = URLComponents()
    private let apiKey = "96284efd0ddf99daf78591a94321917c"
    private let jsonDecoder: JSONDecoder = {
       let jsonDecoder = JSONDecoder()
       jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
       let dateFormatter = DateFormatter()
       dateFormatter.dateFormat = "yyyy-mm-dd"
       jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
       return jsonDecoder
    }()
    
    public init() {
        components.scheme = "https"
        components.host = "8137147.xyz"
        components.queryItems = [
            URLQueryItem(name: "token", value: apiKey),
            //            URLQueryItem(name: "query", value: query)
        ]
    }
    
    /// Generic API request
    private func fetchData<T: Decodable> (url: URL,
                                         username: String,
                                         password: String,
                                         completion: @escaping (T) -> Void ) {
        let url = components.url!
        print(url)
        let session = URLSession(configuration: .ephemeral, delegate: nil, delegateQueue: .main)
        session.dataTask(with: url) { data, response, error in
            if error != nil || data == nil {
                print("Client error!")
                return
            }
            
            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200...299:
                    break
                case 400:
                    print("Bad request, missing inputs")
                case 401:
                    print("The API token or authentication token is missing or is wrong.")
                default:
                    break
                }
            }
            
            do {
                let content = try self.jsonDecoder.decode(T.self, from: data!)
                DispatchQueue.main.async {
                    completion(content)
                }
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    /// List all pages (15 pages by default)
    public func listPages(username: String,
                          password: String) {
        components.path = APIEndpoints.pages.rawValue
        let url = components.url!
        
        fetchData(url: url,
                  username: username,
                  password: password) { (pagesResponse: PagesResponse) in
                    print("tokenResponse is \(pagesResponse)")
                    
        }
    }
    
    /// List all tags
    public func listTags(username: String,
                         password: String) {
        components.path = APIEndpoints.tags.rawValue
        let url = components.url!
        
        fetchData(url: url,
                  username: username,
                  password: password) { (tagsResponse: TagsResponse) in
                    print("tokenResponse is \(tagsResponse)")
                    
        }
    }
    
}

public enum APIEndpoints: String {
    //fix the slashes in host
    case pages = "/1/bludit/api/pages"
    case tags = "/1/bludit/api/tags"
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

