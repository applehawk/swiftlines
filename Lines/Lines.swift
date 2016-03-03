//
//  LinesGrid.swift
//  Lines
//
//  Created by Hawk on 21/02/16.
//  Copyright © 2016 Hawk. All rights reserved.
//

import Foundation
import SpriteKit

enum ColorBallType : Int {
    case Unknown = 0, Red, Green, Blue, Orange, Grey, Yellow, Violet
    
    private static let _count: ColorBallType.RawValue = {
        // find the maximum enum value
        var maxValue: Int = 0
        while let _ = ColorBallType(rawValue: ++maxValue) { }
        return maxValue
    }()
    
    static func random() -> ColorBallType {
        return ColorBallType(rawValue: Int.random(_count))!
    }
}

class ColorBall : NSObject {
    let colorType : ColorBallType
    var row : Int
    var column : Int
    
    init(color : ColorBallType) {
        row = -1
        column = -1
        colorType = color
        super.init()
    }
    
    convenience init(row : Int, column : Int, color : ColorBallType) {
        self.init(color: color)
        self.row = row
        self.column = column
    }
    
    override var description: String {
        return "type:\(colorType) square:(\(column),\(row))"
    }
}

class LinesBoard : NSObject {
    private var grid : Grid = Grid()
    
    //Help for RandomBalls
    private var emptyCells : Set<GridPoint> = Set<GridPoint>()
    
    let appearCount = 3
    
    //board size
    let rows : Int
    let columns : Int
    
    init( rows : Int, columns : Int ) {
        self.rows = rows
        self.columns = columns
        super.init()
        
        self.updateEmptyCells()
    }
    
    //Return free cells count
    func updateEmptyCells() -> Int {
        for (var row = 0; row<rows; ++row) {
            for (var column = 0; column<columns; ++column) {
                let itPoint = GridPoint(x: row, y: column)
                if grid.objectsAtPosition( itPoint ).isEmpty {
                    emptyCells.insert( itPoint )
                }
            }
        }
        return rows * columns - emptyCells.count
    }
    
    func ballAtColumn(row:Int, column: Int) -> ColorBall? {
        let objects = grid.objectsAtPosition(GridPoint(x: row, y: column))
        
        return objects.first as! ColorBall?
    }
    
    func putBallsToBoard( balls: [ColorBall] ) -> Int {
        var addedCount = 0
        for ball in balls {
            if isFilled() == false {
                grid.addObject(ball, atPosition: GridPoint(x: ball.row, y: ball.column))
                ++addedCount
            }
        }
        return addedCount
    }
    
    func isFilled() -> Bool {
        return emptyCells.count <= 0
    }
    
    func prepareRandomBalls() -> [ColorBall] {
        var colorBalls : [ColorBall] = []
        for (var i = 0; i < appearCount; ++i) {
            
            var row = 0, column = 0;
            if let randomPosition = emptyCells.randomElement() {
                let ball = ColorBall(
                    row: randomPosition.x,
                    column: randomPosition.y,
                    color: ColorBallType.random());
                
                colorBalls.append(ball)
            }
        }
        return colorBalls
    }
}
