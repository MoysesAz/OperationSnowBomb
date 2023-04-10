//
//  ActorStateEnum.swift
//  OperationSnowBomb
//
//  Created by João Victor Ipirajá de Alencar on 10/04/23.
//

import Foundation

enum ActorStateEnum: StateProtocol {
    case waiting
    case holding(projectile: ProjectileStateEnum)
}
