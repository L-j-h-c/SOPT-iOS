//
//  ApplicationCoordinator.swift
//  SOPT-iOS
//
//  Created by Junho Lee on 2023/06/20.
//  Copyright © 2023 SOPT-iOS. All rights reserved.
//

import UIKit

import Core
import BaseFeatureDependency
import SplashFeature
import AuthFeature
import MainFeature

final class ApplicationCoordinator: BaseCoordinator {
    
    //  private let coordinatorFactory: CoordinatorFactory
    private let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    override func start(with option: DeepLinkOption?) {
        runSplashFlow()
    }
    
    private func runSplashFlow() {
        let coordinator = SplashCoordinator(router: router, factory: SplashBuilder())
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.runSignInFlow(by: .modal)
            self?.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    private func checkDidSignIn() {
        let needAuth = UserDefaultKeyList.Auth.appAccessToken == nil
        needAuth ? runSignInFlow(by: .modal) : runMainFlow()
    }
    
    private func runSignInFlow(by style: CoordinatorStartingOption) {
        let coordinator = AuthCoordinator(router: router, factory: AuthBuilder())
        coordinator.finishFlow = { [weak self, weak coordinator] userType in
            self?.runMainFlow(type: userType)
            self?.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start(by: style)
    }
    
    private func runMainFlow(type: UserType? = nil) {
        let userType = type ?? UserDefaultKeyList.Auth.getUserType()
        let coordinator = MainCoordinator(router: router, factory: MainBuilder(), userType: userType)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.runMainFlow()
            self?.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start()
    }
}
