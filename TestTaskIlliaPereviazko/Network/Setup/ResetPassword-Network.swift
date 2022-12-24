//
//  ResetPassword-Network.swift
//  TestTaskIlliaPereviazko
//
//  Created by Илья Петров on 04.11.2022.
//

import Foundation

extension Network {
    
    func changePassword(oldPassword: String, newPassword: String, repeatPassword: String, completion: @escaping (Bool, String?) -> ()) {
        
        let api = Api.resetPassword
        
        push(api: api, body: nil, headers: [:], type: ResponseData<String?>.self) { result in
            switch result {
            case .success(let model):
                
                guard let message = model.message else {
                    completion(false, "Something went wrong...")
                    return
                }
                
                completion(true, message)
                
            case .failure(let error):
                print(#file, #line)
                print(error?.localizedDescription ?? "")
                completion(false, error?.localizedDescription ?? "Something went wrong...")
            }
        }
    }
}
