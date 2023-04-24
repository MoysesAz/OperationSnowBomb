//
//  Instances.swift
//  OperationSnowBomb
//
//  Created by Moyses Miranda do Vale Azevedo on 24/04/23.
//

import SpriteKit

class Factory {
    init() {}
    func godofredo() -> Actor {
        let waitingTextureAtlas = SKTextureAtlas(named:"GoldofredoWaiting")
        let holdingRawTextureAtlas = SKTextureAtlas(named: "GoldofredoHoldingRaw")
        let holdingRefinedTextureAtlas = SKTextureAtlas(named: "GoldofredohHoldingRefined")
        let waitingTexture = waitingTextureAtlas.textureNames.map(SKTexture.init(imageNamed:))
        let holdingRawTexture = holdingRawTextureAtlas.textureNames.map(SKTexture.init(imageNamed:))
        let holdingRefinedTexture = holdingRefinedTextureAtlas.textureNames.map(SKTexture.init(imageNamed:))
        let godofredo = Actor(waitingTexture: waitingTexture,
                              holdingRawTexture: holdingRawTexture,
                              holdingRefinedTexture: holdingRefinedTexture)
        let node = SKSpriteNode(texture: waitingTexture[0])
        godofredo.node = node
        return godofredo
    }

    func snowBox() -> Accessories {
        let node = SKSpriteNode(imageNamed: "SnowBox")
        let snowBox = Accessories(node: node, state: AccesoriesStateEnum.idle)
        return snowBox
    }

    

}
