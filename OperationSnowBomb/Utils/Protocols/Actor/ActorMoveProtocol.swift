//
//  ActorMoveProtocol.swift
//  OperationSnowBomb
//
//  Created by João Victor Ipirajá de Alencar on 10/04/23.
//

import Foundation

protocol ActorMoveProtocol {
    var multiplierForDirection: CGFloat { get set }
    var moveDifference: CGPoint { get set }
    func moveToRight(location: CGPoint)
    func moveToLeft(location: CGPoint)
    func moveToUpJoystick()
    func moveToDownJoystick()
}
