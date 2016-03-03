//
//  GameScene.swift
//  Lines
//
//  Created by Hawk on 21/02/16.
//  Copyright (c) 2016 Hawk. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let gameBoard = LinesBoard(rows: 7, columns: 7)
    
    override init(size: CGSize) {
        super.init(size: size)
        
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        let background = SKSpriteNode(imageNamed: "wooden")
        self.addChild(background)
        
        let balls = gameBoard.prepareRandomBalls()
        gameBoard.putBallsToBoard(balls)
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func didMoveToView(view: SKView) {
        for(var row = 0; row<10; ++row) {
            for(var column = 0; column<10; ++column) {
                let cellSprite = SKSpriteNode(imageNamed: "tile")
                
                addChild(cellSprite)
            }
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
