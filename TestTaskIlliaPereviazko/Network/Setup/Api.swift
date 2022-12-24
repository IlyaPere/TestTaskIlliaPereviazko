//
//  Api.swift
//  TestTaskIlliaPereviazko
//
//  Created by Илья Петров on 04.11.2022.
//

import Foundation

enum Api {
    
    //MARK: - CASE
    case profile
    case updateProfile
    case resetPassword
    
    //MARK: - METHOD
    var method: String {
        switch self {
        case .resetPassword, .updateProfile:
            return HTTPMethod.post.rawValue
        default:
            return HTTPMethod.get.rawValue
        }
    }
    
    //MARK: - PATH
    var path:String {
        var url:String{return "https://api.foo.com/"}
        
        switch self {
        case .profile:          return url + "profiles/mine"
        case .resetPassword:    return url + "profiles/update"
        case .updateProfile:    return url + "profiles/update"
        }
    }
}

enum HTTPMethod: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case delate = "DELETE"
}
