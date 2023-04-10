//
//  ActorSpriteNodeProtocol.swift
//  OperationSnowBomb
//
//  Created by João Victor Ipirajá de Alencar on 10/04/23.
//

import SpriteKit

protocol ActorSpriteNodeProtocol {
    var waitingTexture: [SKTextureAtlas] { get set }
    var holdingRawTexture: [SKTextureAtlas] { get set }
    var holdingRefinedTexture: [SKTextureAtlas] { get set }
}
