//
//  Interactor.swift
//  VIPER
//
//  Created by Supapon Pucknavin on 31/10/2565 BE.
//

import Foundation

// object
// protocol
// ref to presenter
// 

//https://jsonplaceholder.typicode.com/users


protocol AnyInterractor {
    var presenter: AnyPresenter? { get set }
    
    func getUsers()
    
}

enum NetworkError: Error {
    case badRequest
    case decodingError
    case badUrl
}

class UserInterRactor: AnyInterractor {
  
    
    var presenter: AnyPresenter?
    
    private var baseURL: URL
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    func getUsers() {
        
        guard let url = URL(string: Endpoints.allUser.path, relativeTo: baseURL) else {
            return
        }
        print(url.absoluteString)
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                self.presenter?.interactorDidFetchUsers(with: .failure(FetchError.failed))
                return
            }
            
            do {
                let entities = try JSONDecoder().decode([User].self, from: data)
                self.presenter?.interactorDidFetchUsers(with: .success(entities))
            } catch {
                self.presenter?.interactorDidFetchUsers(with: .failure(FetchError.failed))
            }
        }
        task.resume()
        
        
    }

}
