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
        let categoryCannon0: UInt32 = 0b0100
        let categoryCannon1: UInt32 = 0b0101
        let categoryCannon2: UInt32 = 0b0110
        let categoryCannon3: UInt32 = 0b0111

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

        let playerInCannon0 = (firstBody.categoryBitMask == categoryPlayer &&
                               secondBody.categoryBitMask == categoryCannon0) ||
        (firstBody.categoryBitMask == categoryCannon0 &&
         secondBody.categoryBitMask == categoryPlayer)

        if playerInCannon0 {
            if player.state == .holding(projectile: .refinedMaterial) && cannons[0].state == .disabled {
                cannons[0].turnOn()
            }
        }

        let playerInCannon1 = (firstBody.categoryBitMask == categoryPlayer &&
                               secondBody.categoryBitMask == categoryCannon1) ||
        (firstBody.categoryBitMask == categoryCannon1 &&
         secondBody.categoryBitMask == categoryPlayer)

        if playerInCannon0 {
            player.state = .waiting
            player.animationActor()
            if player.state == .holding(projectile: .refinedMaterial) && cannons[1].state == .disabled {
                cannons[1].turnOn()
            }
        }

    }
}
