//
//  NetworkManager.swift
//  QuestBoardUI
//
//  Created by Yong Jia on 27/4/21.
//

import Foundation

public class NetworkManager {
    static var nToken = ""
    static var nTokenType = ""
    static var nHeaders: [String: String] = [String: String]()
    static let nApi = "https://questboard-api-gateway-pllorhkrga-as.a.run.app/api"
    static var isInitialised = false
    static var nUsername = ""
    
    public static var sharedNetworkManager: NetworkManager = {
        let instance = NetworkManager()
        
        return instance
    }()
    
    init() {}
    
    public static func initToken(token: String) {
        self.nToken = token
        self.nTokenType = "Bearer"
        self.nHeaders["Content-Type"] = "application/json"
        self.nHeaders["Authorization"] = "\(self.nTokenType) \(self.nToken)"
    }
    
    public static func call(url:String, json: [String: Any], Completion block: @escaping(([String: Any]) -> ())) {
        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        // create post request
        let url = URL(string: "\(nApi)\(url)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = nHeaders
        // insert json data to the request
        request.httpBody = jsonData
        
        if !nHeaders.isEmpty && nToken != "" {
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "No data")
                    return
                }
                do {
                    let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                    if let responseJSON = responseJSON as? [String: Any] {
                        print(responseJSON)
                        block(responseJSON)
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            }

            task.resume()
        }
    }
}
