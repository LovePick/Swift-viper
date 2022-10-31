//
//  Presenter.swift
//  VIPER
//
//  Created by Supapon Pucknavin on 31/10/2565 BE.
//

import Foundation

// object
// protocol
// ref to interactorm router, view

enum FetchError: Error {
    case failed
}
protocol AnyPresenter {
    var router: AnyRouter? { get set }
    var interactor: AnyInterractor? { get set }
    var view: AnyView? { get set }
    
    func interactorDidFetchUsers(with result: Result<[User], Error>)
}

class UserPresenter: AnyPresenter {
    
    var router: AnyRouter?
    var interactor: AnyInterractor? {
        didSet{
            interactor?.getUsers()
        }
    }
    var view: AnyView?
    
    
    
    
    func interactorDidFetchUsers(with result: Result<[User], Error>) {
        
        switch result {
        case .success(let users):
            view?.update(with: users)
        case .failure:
            view?.update(with: "Something went wrong")
        }
    }
    
    
}
