//
//  AppEnvironment.swift
//  VIPER
//
//  Created by Supapon Pucknavin on 31/10/2565 BE.
//

import Foundation


enum Endpoints {
    case allUser
    
    var path: String {
        switch self{
        case .allUser:
            return "/users"
        }
    }
    
}

struct Configuration {
    lazy var environment: AppEnvironment = {
        // READ VALUE FROM ENIVONMENT VARIABLE
        guard let env = ProcessInfo.processInfo.environment["ENV"] else {
            return AppEnvironment.dev
        }
        
        if env == "TEST" {
            return AppEnvironment.test
        }
        
        return AppEnvironment.dev
    }()
}

enum AppEnvironment: String {
    case dev
    case test
    
    var baseURL: URL {
        switch self {
        case .dev:
            return URL(string: "https://jsonplaceholder.typicode.com")!
        case .test:
            return URL(string: "https://jsonplaceholder.typicode.com")!
        }
    }
}
