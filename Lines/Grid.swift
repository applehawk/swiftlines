//
//  Grid.swift
//  Lines
//
//  Created by Hawk on 22/02/16.
//  Copyright © 2016 Hawk. All rights reserved.
//

import Foundation

struct GridPoint : Hashable {
    var x: Int
    var y: Int
    
    var hashValue: Int {
        get {
            return x ^ (y << 32)
        }
    }
    
    init(x : Int, y : Int ) {
        self.x = x
        self.y = y
    }
}


func ==(first : GridPoint, second : GridPoint) -> Bool {
    return first.x == second.x && first.y == second.y
}

class Grid : NSObject {
    // The information is stored as a dictionary mapping 
    // GridPoints to arrays of NSObjects
    var contents : [GridPoint : [NSObject]] = [:] //Dictionary GridPoint -> Array(NSObject)
    
    /*var freeCells = Set<GridPoint>()
    var lockCells = Set<GridPoint>()
    
    init() {
        freeCells
    }*/
    
    // Returns the list of objects that occupy the given position
    func objectsAtPosition(position: GridPoint) -> [AnyObject] {
        // If we have a collection of objects at this position, return it
        if let objects = self.contents[position]
        {
            return objects
        } else {
        // Otherwise, create an empty collection
            self.contents[position] = []
        // And return it
            return []
        }
    }
    
    // Returns a GridPoint describing the position of an object, if it exists
    func positionForObject(objectToFind: NSObject) -> GridPoint?
    {
        for (position, objects) in contents {
            if objects.indexOf(objectToFind) != nil {
                return position
            }
        }
        return nil
    }
  /*
    func randomPositionForFreeCell() -> GridPoint? {
        contents.
        
        let cells : [GridPoint] = freeCells.subtract(<#T##sequence: SequenceType##SequenceType#>)
        let randIndex = Int.random( cells.count )
        return cells[randIndex]
    }*/
    
    // Adds or moves the object to a location on the board
    func addObject(object: NSObject, atPosition position: GridPoint) {
        if self.contents[position] == nil
        {
            self.contents[position] = []
        }
        self.contents[position]?.append(object)
        
       // lockCells.insert( position );
    }
    
    // Removes a given object from the board
    func removeObjectFromGrid(objectToRemove : NSObject) {
        var newContents = self.contents
        
        for (position, objects) in contents {
            newContents[position] = newContents[position]?.filter { (item) -> Bool in
                return item != objectToRemove
            }
        }
        self.contents = newContents
    }
    
    // Removes all objects at a given point from the board
    func removeAllObjectsAtPosition(position: GridPoint) {
        self.contents[position] = []
        //self.lockCells.remove( position )
    }
    // Removes all objects from the board.
    func removeAllObjects() {
        self.contents = [:]
       // self.lockCells.removeAll()
    }
}