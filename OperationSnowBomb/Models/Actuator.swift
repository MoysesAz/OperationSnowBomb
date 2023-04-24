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
    var state: StateProtocol

    var waitingTexture: [SKTexture]
    var disabledTexture: [SKTexture]
    var enabledTexture: [SKTexture]

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(node: SKSpriteNode = SKSpriteNode(),
         state: StateProtocol = ActuatorStateEnum.disabled,
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

    }

    func turnOff() {

    }
}
