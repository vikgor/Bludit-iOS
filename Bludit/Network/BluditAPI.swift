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
    private var components = URLComponents()
    private let apiToken = "96284efd0ddf99daf78591a94321917c"
    private let authToken = "ea4348deb60c7638848d6e1888d18e2c"
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
        components.queryItems = [URLQueryItem(name: "token", value: apiToken)]
    }
    
    /// Generic API request
    /// - Parameters:
    ///   - httpMethod: GET/POST/PUT/DELETE
    ///   - url: request url
    ///   - parameters: parameters for the body (POST/PUT)
    ///   - completion: completion
    private func universalRequest<T: Codable> (httpMethod: String,
                                                 url: URL,
                                                 parameters: [String : String],
                                                 completion: @escaping (T) -> Void ) {
        let session = URLSession(configuration: .ephemeral, delegate: nil, delegateQueue: .main)
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        
        switch httpMethod {
        case "POST",
             "PUT":
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters,
                                                              options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
            }
        case "GET":
            break
        default:
            break
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        session.dataTask(with: request) { data, response, error in
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
                // 2 next lines are used for debugging, delete later
//                let json = try JSONSerialization.jsonObject(with: data!, options: [])
//                print(json)
                let content = try self.jsonDecoder.decode(T.self, from: data!)
                DispatchQueue.main.async {
                    completion(content)
                }
            } catch let error {
                print("JSON error: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    /// List all pages (15 pages by default)
    public func listPages(completion: @escaping (ListPagesResponse?) -> Void) {
        components.path = APIEndpoints.pages.rawValue
        let parameters = ["token": apiToken]
        let allowedParameters = [
            URLQueryItem(name: "published", value: "true"),
            URLQueryItem(name: "sticky", value: "false"),
            URLQueryItem(name: "static", value: "false"),
            URLQueryItem(name: "draft", value: "false"),
            URLQueryItem(name: "untagged", value: "false")
        ]
        components.queryItems?.append(contentsOf: allowedParameters)
        let url = components.url!
        
        universalRequest(httpMethod: "GET",
                         url: url,
                         parameters: parameters) { (response: ListPagesResponse) in
                            completion(response)
        }
    }
    
    /// Find a particular page
    /// - Parameter query: <PAGE-KEY> : PageDetails.key
    public func findPage(query: String,
                         completion: @escaping (FindPageResponse?) -> Void) {
        components.path = "\(APIEndpoints.pages.rawValue)/\(query.convertedForTheAPIRequest)"
        let parameters = ["token": apiToken]
        let url = components.url!
        
        universalRequest(httpMethod: "GET",
                         url: url,
                         parameters: parameters) { (response: FindPageResponse) in
                            completion(response)
        }
    }
    
    /// Create new page
    /// - Parameters:
    ///   - title: Page title
    ///   - tags: Page tags, separated by comma
    ///   - content: Page content
    public func createPage(title: String,
                           tags: String,
                           content: String) {
        components.path = APIEndpoints.pages.rawValue
        let url = components.url!
        let parameters = ["token": apiToken,
                          "authentication": authToken,
                          "title": title,
                          "tags": tags,
                          "content": content]
        
        universalRequest(httpMethod: "POST",
                         url: url,
                         parameters: parameters) { (response: NewPageResponse) in
                            print("Response is \(response)")
        }
    }
    
    /// Edit page
    /// - Parameters:
    ///   - query: <PAGE-KEY> : PageDetails.key
    ///   - title: Page title
    ///   - content: Page content
    public func editPage(query: String,
                         title: String,
                         content: String) {
        components.path = "\(APIEndpoints.pages.rawValue)/\(query)"
        let url = components.url!
        let parameters = ["token": apiToken,
                          "authentication": authToken,
                          "title": title,
                          "content": content]
        
        universalRequest(httpMethod: "PUT",
                         url: url,
                         parameters: parameters) { (response: NewPageResponse) in
                            print("Response is \(response)")
        }
    }
    
    /// Delete page
    /// - Parameter query: <PAGE-KEY> : PageDetails.key
    public func deletePage(query: String) {
        components.path = "\(APIEndpoints.pages.rawValue)/\(query)"
        let parameters = ["token": apiToken]
        let allowedParameters = [
            URLQueryItem(name: "authentication", value: authToken)
        ]
        components.queryItems?.append(contentsOf: allowedParameters)
        let url = components.url!
        
        universalRequest(httpMethod: "DELETE",
                         url: url,
                         parameters: parameters) { (response: DeletedPageResponse) in
                            print("Response is \(response)")
        }
    }
    
    /// List all tags
    public func listTags() {
        components.path = APIEndpoints.tags.rawValue
        let url = components.url!
        let parameters = ["token": apiToken]
        
        universalRequest(httpMethod: "GET",
                         url: url,
                         parameters: parameters) { (response: TagsResponse) in
                            print("Response is \(response)")
        }
    }
    
    /// List all categories
       public func listCategories() {
           components.path = APIEndpoints.categories.rawValue
           let url = components.url!
           let parameters = ["token": apiToken]
           
           universalRequest(httpMethod: "GET",
                            url: url,
                            parameters: parameters) { (response: TagsResponse) in
                               print("Response is \(response)")
           }
       }
}
