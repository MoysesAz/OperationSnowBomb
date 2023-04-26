//
//  GameBoard+.swift
//  OperationSnowBomb
//
//  Created by Moyses Miranda do Vale Azevedo on 25/04/23.
//

import SpriteKit

extension GameBoard: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let categoryPlayer: UInt32 = 0b0001
        let categorySnowBox: UInt32 = 0b0010
        let categorySnowMachine: UInt32 = 0b0011
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB

        // Lógica para pegar a o material Bruto
        let playerInSnowBox = (firstBody.categoryBitMask == categoryPlayer &&
                               secondBody.categoryBitMask == categorySnowBox) ||
        (firstBody.categoryBitMask == categorySnowBox &&
         secondBody.categoryBitMask == categoryPlayer)

        if playerInSnowBox && (player.state == .waiting) {
            player.state = ActorStateEnum.holding(projectile: .rawMaterial)
            player.animationActor()
        }

        let playerInSnowMachine = (firstBody.categoryBitMask == categoryPlayer &&
                                   secondBody.categoryBitMask == categorySnowMachine) ||
        (firstBody.categoryBitMask == categorySnowMachine &&
         secondBody.categoryBitMask == categoryPlayer)

        if playerInSnowMachine {
            if snowMachine.state == .disabled && player.state == .holding(projectile: .rawMaterial) {
                player.state = .waiting
                player.animationActor()
                snowMachine.state = .waiting
                snowMachine.turnOn()

            } else if snowMachine.state == .enabled {
                if player.state == .holding(projectile: .rawMaterial) {
                    player.state = .holding(projectile: .refinedMaterial)
                    player.animationActor()
                    snowMachine.state = .waiting
                    snowMachine.turnOn()
                } else if player.state == .waiting {
                    player.state = .holding(projectile: .refinedMaterial)
                    player.animationActor()
                    snowMachine.turnOff()
                    snowMachine.animationActuator()
                }
            }
        }

    }
}
