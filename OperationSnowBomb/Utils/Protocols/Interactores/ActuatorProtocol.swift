//
//  ActuatorProtocol.swift
//  OperationSnowBomb
//
//  Created by João Victor Ipirajá de Alencar on 10/04/23.
//

import SpriteKit

protocol ActuatorProtocol: InteractProtocol {
    var node: SKSpriteNode {get set}
    var waitingTexture: [SKTexture] { get set }
    var disabledTexture: [SKTexture] { get set }
    var enabledTexture: [SKTexture] { get set }
    init(node: SKSpriteNode ,
         state: ActuatorStateEnum,
         waitingTexture: [SKTexture],
         disabledTexture: [SKTexture],
         enabledTexture: [SKTexture])
    func turnOn()
    func turnOff()
    func animationActuator()
}
