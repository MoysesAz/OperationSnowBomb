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

    // Mudar
    var multiplierForDirection: CGFloat = 0
    var moveDifference = CGPoint(x: 0, y: 0)
    var actorSpeed: CGFloat = 0
    var distanceToMove: CGFloat = 0

    public func animationActor() {
        switch state {
        case ActorStateEnum.waiting:
            let action = SKAction.animate(with: self.waitingTexture, timePerFrame: 0.1)
            self.run(SKAction.repeatForever(action))
        case ActorStateEnum.holding(projectile: .rawMaterial):
            let action = SKAction.animate(with: self.holdingRawTexture, timePerFrame: 0.1)
            self.run(SKAction.repeatForever(action))
        case ActorStateEnum.holding(projectile: .refinedMaterial):
            let action = SKAction.animate(with: self.holdingRefinedTexture, timePerFrame: 0.1)
            self.run(SKAction.repeatForever(action))
        default:
            print("Problem in state Actor")
        }
    }

    private func moveEnd() {
        self.removeAllActions()
    }

    func moveToRight(location: CGPoint) {
        print("Right")

        print(position)
        let moveAction = SKAction.move(to: location, duration: 1)
        let doneAction = SKAction.run({ [weak self] in
            self?.moveEnd()
        })
        let moveActionWithDone = SKAction.sequence([moveAction, doneAction])
        self.run(moveActionWithDone)
        print(position)
    }

    func moveToLeft(location: CGPoint) {
        print("Left")
        print(position)
        let moveAction = SKAction.move(to: location, duration: 1)
        let doneAction = SKAction.run({ [weak self] in
            self?.moveEnd()
        })
        let moveActionWithDone = SKAction.sequence([moveAction, doneAction])
        self.run(moveActionWithDone)
        print(position)
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
