//
//  Actor.swift
//  OperationSnowBomb
//
//  Created by Cicero Nascimento on 11/04/23.
//

import SpriteKit

class Actor: SKSpriteNode, ActorProtocol {
    var waitingTexture: [SKTexture]
    var holdingRawTexture: [SKTexture]
    var holdingRefinedTexture: [SKTexture]
    var state: StateProtocol
    var multiplierForDirection: CGFloat = 0
    var moveDifference = CGPoint(x: 0, y: 0)

    func moveToRight() {
        print(multiplierForDirection)
        print("Right")
    }

    func moveToLeft() {
        print("Left")
    }

    func moveToUp() {
        print("Up")
    }

    func moveToDown() {
        print("Down")
    }

    func drop() {
        print("Drop")
    }

    func hold() {
        print("Hold")
    }

    private func directionLook() {
        if moveDifference.x < 0 {
            multiplierForDirection = -1.0
        } else {
            multiplierForDirection = 1.0
        }
    }

    init(state: StateProtocol = ActorStateEnum.waiting,
         waitingTexture: [SKTexture] = [],
         holdingRawTexture: [SKTexture] = [],
         holdingRefinedTexture: [SKTexture] = []) {
        self.state = state
        self.waitingTexture = waitingTexture
        self.holdingRawTexture = holdingRawTexture
        self.holdingRefinedTexture = holdingRefinedTexture
        super.init(texture: self.waitingTexture[0],
                   color: .clear,
                   size: .zero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
