//
//  Auth-Network.swift
//  TestTaskIlliaPereviazko
//
//  Created by Илья Петров on 04.11.2022.
//

import Foundation

struct ResponseData<T: Decodable>: Decodable {
    let code: String?
    let message: String?
    let data: T?
}

struct Profile: Decodable {
    let firstName: String?
    let userName: String?
    let lastName: String?
}

extension Network {
    
    func getProfile(token: String, completion: @escaping (Profile?, String?) -> ()) {
        
        let api = Api.profile
        
        push(api: api, body: nil, headers: [:], type: ResponseData<Profile>.self) { result in
            switch result {
            case .success(let model):
                completion(model.data, model.message)
                
            case .failure(let error):
                print(#file, #line)
                print(error?.localizedDescription ?? "")
                completion(nil, error?.localizedDescription)
            }
        }
    }
    
    func editProfile(firstName: String?, lastName: String?, completion: @escaping (Profile?, String?) -> ()) {
        
        let api = Api.updateProfile
        
        push(api: api, body: nil, headers: [:], type: ResponseData<Profile>.self) { result in
            switch result {
            case .success(let model):
                completion(model.data, model.message)
                
            case .failure(let error):
                print(#file, #line)
                print(error?.localizedDescription ?? "")
                completion(nil, error?.localizedDescription)
            }
        }
    }
}
