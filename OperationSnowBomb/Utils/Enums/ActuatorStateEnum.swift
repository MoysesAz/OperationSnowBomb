//
//  ActuatorStateEnum.swift
//  OperationSnowBomb
//
//  Created by João Victor Ipirajá de Alencar on 10/04/23.
//

import Foundation

enum ActuatorStateEnum: StateProtocol, Equatable {
    case enabled
    case disabled

    static func == (left: ActuatorStateEnum, right: ActuatorStateEnum) -> Bool {
        switch (left, right) {
        case (.enabled, .enabled):
            return true
        case (.disabled, .disabled):
            return true
        default:
            return false
        }
    }
}
