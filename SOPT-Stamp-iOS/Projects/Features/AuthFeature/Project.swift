//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 김영인 on 2023/03/16.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "AuthFeature",
    targets: [.unitTest, .staticFramework, .demo, .interface],
    internalDependencies: [
        .Features.Stamp.Interface,
        //.Features.Main.Interface
    ],
    interfaceDependencies: [
        .Features.BaseFeatureDependency
    ]
)
