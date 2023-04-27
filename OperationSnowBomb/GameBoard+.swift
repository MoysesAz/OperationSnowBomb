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

        let categoryCannons = [categoryCannon0, categoryCannon1, categoryCannon2, categoryCannon3]
        var listPlayerInCannons: [Bool] = []

        for categoryCannon in categoryCannons {
            let playerInCannon = (firstBody.categoryBitMask == categoryPlayer &&
                                  secondBody.categoryBitMask == categoryCannon) ||
            (firstBody.categoryBitMask == categoryCannon &&
             secondBody.categoryBitMask == categoryPlayer)
            listPlayerInCannons.append(playerInCannon)
        }

        
        for index in 0..<listPlayerInCannons.count {
            if listPlayerInCannons[index] && player.state == .holding(projectile: .refinedMaterial) &&
                cannons[index].state == .disabled {
                cannons[index].turnOn()

                let snowBall = SKShapeNode(circleOfRadius: 20)
                snowBall.fillColor = .blue
                snowBall.physicsBody = SKPhysicsBody(circleOfRadius: 20)
                snowBall.position = cannons[index].node.position
                snowBall.position.y += frame.width * 0.08
                snowBall.physicsBody?.affectedByGravity = false
                self.addChild(snowBall)
                snowBall.run(SKAction.applyForce(.init(dx: 0, dy: 120), duration: 0.1))
                player.state = .waiting
                player.animationActor()
            }
        }
    }
}
