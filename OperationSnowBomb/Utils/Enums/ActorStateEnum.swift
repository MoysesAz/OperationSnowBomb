//
//  ActorStateEnum.swift
//  OperationSnowBomb
//
//  Created by João Victor Ipirajá de Alencar on 10/04/23.
//

import Foundation

enum ActorStateEnum: StateProtocol, Equatable {
    case waiting
    case holding(projectile: ProjectileStateEnum)

    static func == (left: ActorStateEnum, right: ActorStateEnum) -> Bool {
        switch (left, right) {
        case (.waiting, .waiting):
            return true
        case let (.holding(projectileA), .holding(projectileB)):
            return projectileA == projectileB
        default:
            return false
        }
    }
}
