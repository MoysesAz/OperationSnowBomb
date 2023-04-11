//
//  ActorTexturesProtocol.swift
//  OperationSnowBomb
//
//  Created by João Victor Ipirajá de Alencar on 10/04/23.
//

import SpriteKit

protocol ActorTexturesProtocol {
    var waitingTexture: [SKTexture] { get set }
    var holdingRawTexture: [SKTexture] { get set }
    var holdingRefinedTexture: [SKTexture] { get set }
}
