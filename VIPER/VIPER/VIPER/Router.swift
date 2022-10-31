//
//  Router.swift
//  VIPER
//
//  Created by Supapon Pucknavin on 31/10/2565 BE.
//

import Foundation
import UIKit

// object
// entry point

typealias EntryPoint = AnyView & UIViewController
protocol AnyRouter {
    var entry: EntryPoint? { get }
    static func start() -> AnyRouter
    
}

class UserRouter: AnyRouter {
    var entry: EntryPoint?
    
    static func start() -> AnyRouter {
        
        var config = Configuration()
        
        let router = UserRouter()
        
        // Assign VIP
        var view: AnyView = UserViewController()
        
        var interactor: AnyInterractor = UserInterRactor(baseURL: config.environment.baseURL)
        
        var presentter: AnyPresenter = UserPresenter()
        
        view.presenter = presentter
        
        interactor.presenter = presentter
        
        presentter.router = router
        presentter.view = view
        presentter.interactor = interactor
        
        router.entry = view as? EntryPoint
        
        return router
    }
    
    
}
