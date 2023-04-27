//
//  Actor.swift
//  OperationSnowBomb
//
//  Created by Cicero Nascimento on 11/04/23.
//

import SpriteKit

class Actor: ActorProtocol {
    var state: ActorStateEnum
    var node: SKSpriteNode

    var waitingTexture: [SKTexture]
    var holdingRawTexture: [SKTexture]
    var holdingRefinedTexture: [SKTexture]

    // Mudar
    var multiplierForDirection: CGFloat = 0
    var moveDifference = CGPoint(x: 0, y: 0)
    var actorSpeed: CGFloat = 0
    var distanceToMove: CGFloat = 0

    init(node: SKSpriteNode = SKSpriteNode(),
         state: ActorStateEnum = .waiting,
         waitingTexture: [SKTexture] = [],
         holdingRawTexture: [SKTexture] = [],
         holdingRefinedTexture: [SKTexture] = []) {

        self.node = node
        self.state = state
        self.waitingTexture = waitingTexture
        self.holdingRawTexture = holdingRawTexture
        self.holdingRefinedTexture = holdingRefinedTexture
    }

    public func animationActor() {
        switch state {
        case ActorStateEnum.waiting:
            let action = SKAction.animate(with: self.waitingTexture, timePerFrame: 0.1)
            self.node.run(SKAction.repeatForever(action))
        case ActorStateEnum.holding(projectile: .rawMaterial):
            let action = SKAction.animate(with: self.holdingRawTexture, timePerFrame: 0.1)
            self.node.run(SKAction.repeatForever(action))
        case ActorStateEnum.holding(projectile: .refinedMaterial):
            let action = SKAction.animate(with: self.holdingRefinedTexture, timePerFrame: 0.1)
            self.node.run(SKAction.repeatForever(action))
        default:
            print("Problem in state Actor")
        }
    }

    func moveEnd() {
        self.node.removeAllActions()
    }

    func moveToRight(location: CGPoint) {
            let currentPosition = self.node.position
            let diffVector = CGVector(dx: location.x - currentPosition.x, dy: location.y - currentPosition.y)
            let moveAction = SKAction.move(by: diffVector, duration: 1)
            let doneAction = SKAction.run({ [weak self] in
                self?.moveEnd()
            })
            let moveActionWithDone = SKAction.sequence([moveAction, doneAction])
            self.node.run(moveActionWithDone)
        }

    func moveToLeftJoystick() {
//        let diffVector = CGVector(dx: -100,
//                                  dy: 0)
//        let moveAction = SKAction.move(by: diffVector, duration: 0.2)
        let playerSpeed: CGFloat = 100.0
        let moveAction = SKAction.moveBy(x: -playerSpeed, y: 0, duration: 0.2)

        let doneAction = SKAction.run({ [weak self] in
            self?.moveEnd()
        })

//        let moveActionWithDone = SKAction.sequence([moveAction, doneAction])
//        self.node.run(moveActionWithDone)
        self.node.run(SKAction.repeatForever(moveAction))
    }



    func moveToRightJoystick() {
        let playerSpeed: CGFloat = 100.0
        let moveAction = SKAction.moveBy(x: playerSpeed, y: 0, duration: 0.2)

        let doneAction = SKAction.run({ [weak self] in
            self?.moveEnd()
        })

//        let moveActionWithDone = SKAction.sequence([moveAction, doneAction])
//        self.node.run(moveActionWithDone)
        self.node.run(SKAction.repeatForever(moveAction))
    }

    func moveToLeft(location: CGPoint) {
        let currentPosition = self.node.position
        let diffVector = CGVector(dx: location.x - currentPosition.x, dy: location.y - currentPosition.y)
        let moveAction = SKAction.move(by: diffVector, duration: 1)
        let doneAction = SKAction.run({ [weak self] in
            self?.moveEnd()
        })
        let moveActionWithDone = SKAction.sequence([moveAction, doneAction])
        self.node.run(moveActionWithDone)
    }

    func moveToUpJoystick() {
        let playerSpeed: CGFloat = 100.0
        let moveAction = SKAction.moveBy(x: 0, y: playerSpeed, duration: 0.2)

        let doneAction = SKAction.run({ [weak self] in
            self?.moveEnd()
        })

//        let moveActionWithDone = SKAction.sequence([moveAction, doneAction])
//        self.node.run(moveActionWithDone)
        self.node.run(SKAction.repeatForever(moveAction))
    }

    func moveToDownJoystick() {
        let playerSpeed: CGFloat = 100.0
        let moveAction = SKAction.moveBy(x: 0, y: -playerSpeed, duration: 0.2)

        let doneAction = SKAction.run({ [weak self] in
            self?.moveEnd()
        })

//        let moveActionWithDone = SKAction.sequence([moveAction, doneAction])
//        self.node.run(moveActionWithDone)
        self.node.run(SKAction.repeatForever(moveAction))
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
}
