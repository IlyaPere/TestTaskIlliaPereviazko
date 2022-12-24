//
//  Network.swift
//  TestTaskIlliaPereviazko
//
//  Created by Илья Петров on 04.11.2022.
//

import Foundation

enum Result<Model> {
    case success(model: Model)
    case failure(error: Error?)
}

final class Network {
    static var shared:Network = Network()
    
    internal func push<T: Decodable>(api:Api,
                                     body:Data?,
                                     headers:[String:String]?,
                                     type: T.Type,
                                     completion:@escaping(Result<T>) -> ())
    {
        
        var request = URLRequest(url: URL(string: api.path)!,timeoutInterval: Double.infinity)
        request.httpMethod = api.method
        request.httpBody = body
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let headers = headers {
            headers.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data  else { return completion(Result.failure(error: error)) }
            
            guard let value = try? JSONDecoder().decode(type.self, from: data) else {
                
                print(String(data: data, encoding: .utf8)!)
                return completion(Result.failure(error: error))
            }
            
            return completion(Result.success(model: value))
        }
        
        task.resume()
    }
}
