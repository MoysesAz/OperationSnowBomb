//
//  Actuator.swift
//  OperationSnowBomb
//
//  Created by Cicero Nascimento on 20/04/23.
//

import Foundation
import SpriteKit

class Actuator: ActuatorProtocol {
    var node: SKSpriteNode
    var state: ActuatorStateEnum

    var waitingTexture: [SKTexture]
    var disabledTexture: [SKTexture]
    var enabledTexture: [SKTexture]

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(node: SKSpriteNode = SKSpriteNode(),
         state: ActuatorStateEnum = .disabled,
         waitingTexture: [SKTexture] = [],
         disabledTexture: [SKTexture] = [],
         enabledTexture: [SKTexture] = []) {

        self.node = node
        self.state = state
        self.waitingTexture = waitingTexture
        self.disabledTexture = disabledTexture
        self.enabledTexture = enabledTexture

    }

    func turnOn() {
        state = ActuatorStateEnum.enabled
        animationActuator()

    }

    func turnOff() {
        state = ActuatorStateEnum.disabled
        animationActuator()
    }

    public func animationActuator() {
        switch state {
        case ActuatorStateEnum.disabled:
            let action = SKAction.animate(with: self.waitingTexture, timePerFrame: 0.1)
            self.node.run(SKAction.repeatForever(action))
        case ActuatorStateEnum.enabled:
            let enabled = SKAction.animate(with: self.enabledTexture, timePerFrame: 0.1)
            let waiting = SKAction.animate(with: self.waitingTexture, timePerFrame: 0.1)
            let action = SKAction.sequence([SKAction.repeat(waiting, count: 6), enabled])
            self.node.run(action)
        default:
            print("Problem in state Actor")
        }
    }
}
