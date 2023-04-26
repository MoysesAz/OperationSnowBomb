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

    func snowMachine() -> SnowMachine {
        let waitingTextureAtlas = SKTextureAtlas(named:"SnowMachineWaiting")
        let disabledTextureAtlas = SKTextureAtlas(named: "SnowMachineDisabled")
        let enabledTextureAtlas = SKTextureAtlas(named: "SnowMachineEnabled")

        let waitingTexture = waitingTextureAtlas.textureNames
            .sorted()
            .map(SKTexture.init(imageNamed:))
        let disabledTexture = disabledTextureAtlas.textureNames
            .sorted()
            .map(SKTexture.init(imageNamed:))
        let enabledTexture = enabledTextureAtlas.textureNames
            .sorted()
            .map(SKTexture.init(imageNamed:))
        let node = SKSpriteNode(texture: disabledTexture[0])

        let snowMachine = SnowMachine(node: node,
                                   state: ActuatorStateEnum.disabled,
                                   waitingTexture: waitingTexture,
                                   disabledTexture: disabledTexture,
                                   enabledTexture: enabledTexture)

        return snowMachine
    }

    func cannon() -> Cannon {
        let waitingTextureAtlas = SKTextureAtlas(named:"CannonWaiting")
        let disabledTextureAtlas = SKTextureAtlas(named: "CannonDisabled")
        let enabledTextureAtlas = SKTextureAtlas(named: "CannonEnabled")

        let waitingTexture = waitingTextureAtlas.textureNames
            .sorted()
            .map(SKTexture.init(imageNamed:))
        let disabledTexture = disabledTextureAtlas.textureNames
            .sorted()
            .map(SKTexture.init(imageNamed:))
        let enabledTexture = enabledTextureAtlas.textureNames
            .sorted()
            .map(SKTexture.init(imageNamed:))
        let node = SKSpriteNode(texture: disabledTexture[0])

        let cannon = Cannon(node: node,
                                   state: ActuatorStateEnum.disabled,
                                   waitingTexture: waitingTexture,
                                   disabledTexture: disabledTexture,
                                   enabledTexture: enabledTexture)

        return cannon
    }
}
