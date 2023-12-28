//
//  Piece.swift
//  DynaSwipe
//
//  Created by Jeffery Widroff on 12/20/23.
//


import Foundation
import UIKit


class Piece {
    
    var indexes: Indexes?
    var nextIndexes: Indexes?
    var previousIndex: Indexes?
    var blockedByWall = false
    var view = ShapeView()
    var color = UIColor()
    var center = CGPoint()
    var groupNumber = Int()
    var id = Int()
    var canMoveOneSpace = true
//    var groupNumber:Int?
//    var textLabel = UILabel()

    init(){
        
    }
    
    init(indexes: Indexes?, color: UIColor) {
        
        
        
        self.indexes = indexes
        self.color = color
        
         
    }
}




class Group {
    
    var hookedPieces = [Piece]()
    var pieces = [Piece]()
    var didMove = false
    var colorBackground = UIColor()
    var id = Int()
    var canMove = true
    
    init(pieces: [Piece]) {
        self.pieces = pieces
    }
}

class Hook {
    
    var groupsHookedTogether = [Group]()
    
    
    
    
}

enum Direction {
    
    case up
    case down
    case left
    case right
    case none
}


