//
//  Actuator.swift
//  OperationSnowBomb
//
//  Created by Cicero Nascimento on 20/04/23.
//

import Foundation
import SpriteKit

class Actuator: SKSpriteNode, ActuatorProtocol {

    private var state: StateProtocol
    var waitingTexture: [SKTexture]
    var disabledTexture: [SKTexture]
    var enabledTexture: [SKTexture]

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(withName name: String,
         state: StateProtocol = ActuatorStateEnum.disabled,
         waitingTexture: SKTextureAtlas,
         disabledTexture: SKTextureAtlas, enabledTexture: SKTextureAtlas ,position: CGPoint, size: CGSize) {

        self.state = state
        self.waitingTexture = waitingTexture.textureNames.map(SKTexture.init(imageNamed:))
        self.disabledTexture = disabledTexture.textureNames.map(SKTexture.init(imageNamed:))
        self.enabledTexture = enabledTexture.textureNames.map(SKTexture.init(imageNamed:))
        print(waitingTexture)
        super.init(texture: self.disabledTexture[0],
                   color: .clear,
                   size: size)

        self.name = name
        self.position = position

    }

    func turnOn() {

    }

    func turnOff() {

    }
}
