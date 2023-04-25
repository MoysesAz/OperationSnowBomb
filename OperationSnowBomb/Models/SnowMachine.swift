//
//  SnowMachine.swift
//  OperationSnowBomb
//
//  Created by João Victor Ipirajá de Alencar on 25/04/23.
//

import SpriteKit

class SnowMachine: ActuatorProtocol {
    var node: SKSpriteNode
    var state: ActuatorStateEnum

    var waitingTexture: [SKTexture]
    var disabledTexture: [SKTexture]
    var enabledTexture: [SKTexture]

    required init(node: SKSpriteNode = SKSpriteNode(),
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
            let action = SKAction.animate(
                with: self.disabledTexture,
                timePerFrame: 0.1
            )
            
            self.node.run(SKAction.repeatForever(action))
        case ActuatorStateEnum.enabled:
            
            let enabled = SKAction.animate(
                with: self.enabledTexture,
                timePerFrame: 0.1
            )
            let waiting = SKAction.animate(with: self.waitingTexture, timePerFrame: 0.1)
            let disabled = SKAction.animate(with: self.disabledTexture, timePerFrame: 0.1)
            let delay = SKAction.wait(forDuration: 0.7)
            let action = SKAction.sequence([SKAction.repeat(waiting, count: 6), enabled, delay, disabled])
            self.node.run(action)
        }
    }
}
