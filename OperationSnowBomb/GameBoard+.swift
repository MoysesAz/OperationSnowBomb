//
//  GameBoard+.swift
//  OperationSnowBomb
//
//  Created by Moyses Miranda do Vale Azevedo on 25/04/23.
//

import SpriteKit

extension GameBoard: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
//        print((contact.bodyA.node! as! SKSpriteNode).texture, "contacted", (contact.bodyB.node! as! SKSpriteNode).texture)

        let categoryPlayer: UInt32      = 0b0000001
        let categorySnowBox: UInt32     = 0b0000010
        let categorySnowMachine: UInt32 = 0b0000100
        let categoryCannon0: UInt32     = 0b0001000
        let categoryCannon1: UInt32     = 0b0010000
        let categoryCannon2: UInt32     = 0b0100000
        let categoryCannon3: UInt32     = 0b1000000

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

        // ==========================================================================================
        let playerInCannon0 = (firstBody.categoryBitMask == categoryPlayer &&
                               secondBody.categoryBitMask == categoryCannon0) ||
        (firstBody.categoryBitMask == categoryCannon0 &&
         secondBody.categoryBitMask == categoryPlayer)

        if playerInCannon0 {
            if player.state == .holding(projectile: .refinedMaterial) && cannons[0].state == .disabled {
                print("0")
                cannons[0].turnOn()
            }
        }

        // ==========================================================================================
        let playerInCannon1 = (firstBody.categoryBitMask == categoryPlayer &&
                               secondBody.categoryBitMask == categoryCannon1) ||
        (firstBody.categoryBitMask == categoryCannon1 &&
         secondBody.categoryBitMask == categoryPlayer)

        if playerInCannon1 {
            if player.state == .holding(projectile: .refinedMaterial) && cannons[1].state == .disabled {
                print("1")
                cannons[1].turnOn()
            }
        }

        // ==========================================================================================
        let playerInCannon2 = (firstBody.categoryBitMask == categoryPlayer &&
                               secondBody.categoryBitMask == categoryCannon2) ||
        (firstBody.categoryBitMask == categoryCannon2 &&
         secondBody.categoryBitMask == categoryPlayer)

        if playerInCannon2 {
            if player.state == .holding(projectile: .refinedMaterial) && cannons[2].state == .disabled {
                print("2")
                cannons[2].turnOn()
            }
        }

        // ==========================================================================================
        let playerInCannon3 = (firstBody.categoryBitMask == categoryPlayer &&
                               secondBody.categoryBitMask == categoryCannon3) ||
        (firstBody.categoryBitMask == categoryCannon3 &&
         secondBody.categoryBitMask == categoryPlayer)

        if playerInCannon3 {
            if player.state == .holding(projectile: .refinedMaterial) && cannons[3].state == .disabled {
                print("3")
                cannons[3].turnOn()
            }
        }
    }
}
