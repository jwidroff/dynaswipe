//
//  Model.swift
//  DynaSwipe
//
//  Created by Jeffery Widroff on 12/20/23.
//


import Foundation
import UIKit

//TODO: 3 ways to make pieces disappear: 1) Line across the board 2) 7 pieces grouped 3) a group that surrounds pieces

//TODO: Make it that if no pieces can move, the board shakes and nothing happens


//TODO: Make it that if no pieces move on a swipe, no piece is added

//TODO: Make initial text of the game the first time its played say "Swipe in any direction"

//TODO: New issue - When a piece is trapped in another group of pieces, when you swipe in any direction it doesnt move because of the fact that the middle piece cant move (although this may be able to be fixed by the fact that all of those pieces will have been removed anyway

//TODO: Issue regarding the grouping of the pieces together still doesnt seem to be fixed

//TODO: When groups are intertwined, the groups dont seem to move properly. need to perhaps consider identifying these circumstances and then considering them to be one group for that one move and see if all of the pieces can move together (like a "C" shaped pieces around a part thats sticking out from a group of pieces)


//TODO: Put the nextPiece in the center of the board

protocol ModelDelegate {
    func setUpGameViews(board: Board)
    func setUpControlViews()
    func setUpPiecesView()
    func movePieceView(piece: Piece)
    func addPieceView(piece: Piece)
    func removeView(view: UIView)
    func runPopUpView(title: String, message: String)
    func clearPiecesAnimation(view: UIView)
    func removeViews()
    func addSwipeGestureRecognizer(view: UIView)
    func enlargePiece(view: UIView)
//    func setupInstructionsView(instructions: Instructions)
    func setUpNextView(nextPiece: Piece)
    func shrinkPiece(view: UIView)
    func animateGrouping(piece: Piece)
}

class Model {
    
    var board = Board()
    var delegate: ModelDelegate?
    let defaults = UserDefaults.standard
    var colors = PieceColors()
    var piecesMoved = false
    
    var piecesMovedX = false
    var groupsThatHaveMoved = [Int]()
    var groupsThatHaveMovedBack = [Int]()
    var piecesToMoveBack = [Int]()

    var red = PieceColors().colors["red"]!
    var blue = PieceColors().colors["blue"]!
    var green = PieceColors().colors["green"]!
    var purple = PieceColors().colors["purple"]!
    var yellow = PieceColors().colors["yellow"]!
    var orange = PieceColors().colors["orange"]!
    var groupCount = 0
    var nextPiece = Piece()
//    var groups2Rerun = [[Group]]()
    var groups2Return = [Group]()
    var blockeeAndBlockers = [Int: [Int]]()
    var highestID = 0

    
    init(){
        
    }
    
    func setUpGame() {
        
        setLevel()
        
        
//        for group in board.pieceGroups {
//
//            for piece in group.pieces {
//
////                print("piece.id \(piece.id)")
//            }
//
//
//        }
        
        
        setBoard()
        
        
        groupPiecesTogetherX()

        
    }
    
    func setUpControlsAndInstructions() {
        
        delegate?.setUpControlViews()
//        setupInstructions()
        setupNextView()
    }
    
    func setLevel() {
        
        board.heightSpaces = 10
        board.widthSpaces = 10
        
        let piece5 = Piece(indexes: Indexes(x: 0, y: 7), color: red)
        
        let piece1 = Piece(indexes: Indexes(x: 2, y: 6), color: red)
                
        let piece3 = Piece(indexes: Indexes(x: 2, y: 8), color: red)
        
        let piece4 = Piece(indexes: Indexes(x: 0, y: 6), color: red)
        let piece6 = Piece(indexes: Indexes(x: 0, y: 8), color: red)
        let piece7 = Piece(indexes: Indexes(x: 3, y: 8), color: red)
        
        let piece8 = Piece(indexes: Indexes(x: 0, y: 5), color: red)

        let piece9 = Piece(indexes: Indexes(x: 0, y: 4), color: red)

        let piece99 = Piece(indexes: Indexes(x: 2, y: 4), color: red)
        
        let piece98 = Piece(indexes: Indexes(x: 3, y: 6), color: red)
        
        let piece97 = Piece(indexes: Indexes(x: 3, y: 7), color: red)
        
        let piece96 = Piece(indexes: Indexes(x: 1, y: 4), color: red)
        let piece95 = Piece(indexes: Indexes(x: 1, y: 6), color: red)
        let piece94 = Piece(indexes: Indexes(x: 1, y: 8), color: red)
        
        
        
        
        let group1 = Group(pieces: [piece5, piece1, piece3, piece4, piece6, piece7, piece8, piece9, piece99, piece98, piece97, piece96, piece95, piece94])
        
        
        group1.id = 1
        

        
        
        let piece10 = Piece(indexes: Indexes(x: 6, y: 6), color: blue)

//        let piece11 = Piece(indexes: Indexes(x: 6, y: 7), color: blue)

        let piece12 = Piece(indexes: Indexes(x: 5, y: 6), color: blue)
        
        let piece13 = Piece(indexes: Indexes(x: 6, y: 5), color: blue)

        let piece14 = Piece(indexes: Indexes(x: 6, y: 4), color: blue)

        let piece15 = Piece(indexes: Indexes(x: 5, y: 4), color: blue)
        
       
        
        
        let group2 = Group(pieces: [piece12, piece10, piece13, piece14, piece15])


        group2.id = 2
        
        

        let piece20 = Piece(indexes: Indexes(x: 5, y: 5), color: green)

        
        let group3 = Group(pieces: [piece20])//, piece21, piece20, piece23, piece24, piece25])
        
        
        group3.id = 3
        
        
        
        
        let piece30 = Piece(indexes: Indexes(x: 3, y: 5), color: orange)
        let piece31 = Piece(indexes: Indexes(x: 3, y: 4), color: orange)
        let piece32 = Piece(indexes: Indexes(x: 3, y: 3), color: orange)
        let piece33 = Piece(indexes: Indexes(x: 2, y: 2), color: orange)
        let piece34 = Piece(indexes: Indexes(x: 2, y: 5), color: orange)
        let piece35 = Piece(indexes: Indexes(x: 3, y: 2), color: orange)


        let group4 = Group(pieces: [piece30, piece31, piece32, piece33, piece34, piece35])


        group4.id = 4
        
        
        let piece40 = Piece(indexes: Indexes(x: 2, y: 7), color: purple)


        let group5 = Group(pieces: [piece40])


        group5.id = 5
        
//        board.pieces.append(piece15)
        
        
        let piece50 = Piece(indexes: Indexes(x: 2, y: 1), color: yellow)

//        let piece11 = Piece(indexes: Indexes(x: 6, y: 7), color: blue)

        let piece51 = Piece(indexes: Indexes(x: 1, y: 1), color: yellow)
        
        let piece52 = Piece(indexes: Indexes(x: 1, y: 2), color: yellow)

        let piece53 = Piece(indexes: Indexes(x: 1, y: 3), color: yellow)

        let piece54 = Piece(indexes: Indexes(x: 2, y: 3), color: yellow)
        
//        let piece55 = Piece(indexes: Indexes(x: 1, y: 0), color: yellow)
        
        
        
        let group6 = Group(pieces: [piece50, piece51, piece52, piece53, piece54])//, piece55])


        group6.id = 6
        
        
        let piece70 = Piece(indexes: Indexes(x: 2, y: 0), color: green)

        
        let group7 = Group(pieces: [piece70])//, piece21, piece20, piece23, piece24, piece25])
        
        
        group7.id = 7
        
        
        let piece80 = Piece(indexes: Indexes(x: 1, y: 7), color: green)

        
        let group8 = Group(pieces: [piece80])//, piece21, piece20, piece23, piece24, piece25])
        
        
        group8.id = 8
        
        
        
        
//        let piece16 = Piece(indexes: Indexes(x: 0, y: 2), color: red)
////        board.pieces.append(piece16)
//
//
//        let group6 = Group(pieces: [piece16])
//        group6.id = 6
        
        
        
        board.pieceGroups = [group1, group4, group5, group3, group2, group6, group7, group8]
        
        var number = 0
        
        for group in board.pieceGroups {
            
            for piece in group.pieces {
                
                piece.id = number
                piece.groupNumber = group.id
                board.pieces.append(piece)
                number += 1
                
            }
            
        }
        
        highestID = number
        
        
        
        updateBoard()
        

    }
    
    func updateBoard() {
        
        for group in board.pieceGroups {
            
            for piece in group.pieces {
                
                board.locationAndIDs[piece.indexes!] = piece.id
                board.idsAndLocations[piece.id] = piece.indexes
            }
            
        }
        
        
//        print(board.locationAndIDs)
        
        
    }
    
    func setBoard() {
        
        delegate?.setUpGameViews(board: self.board)
        delegate?.setUpPiecesView()
    }
    
    func setupNextView() {
        
        nextPiece = Piece(indexes: Indexes(x: nil, y: nil), color: returnRandomColor())
        delegate?.setUpNextView(nextPiece: nextPiece)
    }
    
    func returnRandomColor() -> UIColor {
        
//        print("returnRandomColor called")
        
        
        var color2Return = UIColor()
        let colors = PieceColors()
        let pieceColors = colors.colors
        let randomColors = ["red","blue","green","purple", "yellow", "orange"]
        let randomIndex = arc4random_uniform(UInt32(randomColors.count))
        color2Return = pieceColors[randomColors[Int(randomIndex)]]!
        return color2Return
    }

    
//    func setupInstructions() {
//
//        if board.instructions == nil {
//            return
//        } else {
//            delegate?.setupInstructionsView(instructions: board.instructions!)
//        }
//    }
    
    func setPieceID(piece: Piece) {
        
        piece.id = highestID
        
        highestID += 1
        
//        print("PIECE ID = \(piece.id)")
    }
    
    private func setPieceIndex(piece: Piece) {

        let index = Indexes(x: Int(arc4random_uniform(UInt32(board.widthSpaces))), y: Int(arc4random_uniform(UInt32(board.heightSpaces))))

        var useIndexes = true
        
        for group in board.pieceGroups {
            
            if group.pieces.contains(where: { (pieceX) -> Bool in
                pieceX.indexes == index
            }){
                
                useIndexes = false
                
            }
            
        }
        
        if useIndexes == true{
            piece.indexes = index
        } else {
            setPieceIndex(piece: piece)
        }
    }
    
    func isNextSpaceBlocked(direction: Direction, indexes: Indexes, pieces: [Piece]) -> Bool {
        
        var bool = true

        switch direction {
        case .up:
            if pieces.contains(where: { (piece) -> Bool in
                piece.indexes == Indexes(x: indexes.x, y: indexes.y! - 1)
            }){
                bool = false
            }
            
        case .down:
            if pieces.contains(where: { (piece) -> Bool in
                piece.indexes == Indexes(x: indexes.x, y: indexes.y! + 1)
            }){
                bool = false
            }
            
        case .left:
            if pieces.contains(where: { (piece) -> Bool in
                piece.indexes == Indexes(x: indexes.x! - 1, y: indexes.y)
            }){
                bool = false
            }
            
        case .right:
            if pieces.contains(where: { (piece) -> Bool in
                piece.indexes == Indexes(x: indexes.x! + 1, y: indexes.y)
            }){
                bool = false
            }
        default:
            break
        }
        return bool
    }
    
    func getPieceInfo(index: Indexes, pieces: [Piece]) -> Piece? {
        
        var piece = Piece()
        
        for pieceX in pieces {
            
            if pieceX.indexes == index {
                
                piece = pieceX
            }
        }
        return piece
    }
    
    func movePiecesHelper(piece: Piece, direction: Direction) {
        
        if let indexes = piece.indexes {
            
            switch direction {
                
            case .up:
                
//                let spaceIsntBlocked = isNextSpaceBlocked(direction: .up, indexes: indexes, pieces: [Piece]())
//
//                if spaceIsntBlocked {
                    
                    if indexes.y != 0 {
                        piece.indexes?.y = (indexes.y)! - 1
                        piecesMoved = true
                    }
//                } else {
//                    return
//                }
                
            case .down:
                
//                let spaceIsntBlocked = isNextSpaceBlocked(direction: .down, indexes: indexes, pieces: board.pieces)
//
//                if spaceIsntBlocked {
                    
                    if indexes.y != board.heightSpaces - 1 {
                        piece.indexes?.y = indexes.y! + 1
                        piecesMoved = true
                    }
//                } else {
//                    return
//                }
                
            case .left:
                
//                let spaceIsntBlocked = isNextSpaceBlocked(direction: .left, indexes: indexes, pieces: board.pieces)
//
//                if spaceIsntBlocked {
                    
                    if indexes.x != 0 {
                        piece.indexes?.x = indexes.x! - 1
                        piecesMoved = true
                    }
//                } else {
//                    return
//                }
                
            case .right:
                
//                let spaceIsntBlocked = isNextSpaceBlocked(direction: .right, indexes: indexes, pieces: board.pieces)
//
//                if spaceIsntBlocked {
                    
                    if indexes.x != board.widthSpaces - 1 {
                        piece.indexes?.x = indexes.x! + 1
                        piecesMoved = true
                    }
                    
//                } else {
//                    return
//                }
                
            default:
                break
            }
        }
    }
    
    func pieceIsPartOfAGroup(piece: Piece, groups: [Group]) -> Bool {
        
        var bool = false
        
        for group in groups {
            if group.pieces.contains(where: { pieceX -> Bool in
                piece.indexes == pieceX.indexes
            }) {
                bool = true
            }
        }
        return bool
    }
    
    
    var groupClusterToRetry = [[Group]]()
    
    var hookedGroups = [Group]()
    
    
//    func movePiece2(direction: Direction, pieces: [Piece]) {
//
//        var groupsToRetry = [Group]()
//        var piecesToRetry = [Piece]()
//        var pieceDidMove = false
//
////        sortPieces(direction: direction)
//
//        for piece in pieces {
//
//            if pieceIsPartOfAGroup(piece: piece, groups: board.pieceGroups) == false {
//
//                let startIndexes = piece.indexes
//
//                movePiecesHelper(piece: piece, direction: direction)
//
//                self.delegate?.movePieceView(piece: piece)
//
//                let endIndexes = piece.indexes
//
//                if startIndexes == endIndexes {
//
//                    piecesToRetry.append(piece)
//                } else {
//                    pieceDidMove = true
//                    piecesMoved = true
//                }
//            }
//        }
//
//        var groupCanMove = true
//
//        for group in board.pieceGroups {
//
//
//
////            print(group.pieces.map({$0.indexes}))
//
//            var groupDidMove = group.didMove
//
//            if group.didMove == false {
//
//
//
//                var piecesIndexes = [Indexes]()
//
//                switch direction {
//
//                case .up:
//
//                    for piece in group.pieces.sorted(by: { (piece1, piece2) -> Bool in
//                        (piece1.indexes?.y!)! < (piece2.indexes?.y!)!
//                    }) {
//
//                        if board.pieces.contains(where: { pieceX -> Bool in
//                            pieceX.indexes == Indexes(x: piece.indexes?.x, y: (piece.indexes?.y!)! - 1)
//                        }) {
//                            if !group.pieces.contains(where: { pieceXX -> Bool in
//                                pieceXX.indexes == Indexes(x: piece.indexes?.x, y: (piece.indexes?.y!)! - 1)
//                            }) {
//                                groupCanMove = false
//                            }
//
//                        } else {
//
//                            if piecesIndexes.contains(where: { indexX -> Bool in
//                                indexX == Indexes(x: piece.indexes?.x, y: (piece.indexes?.y!)! - 1)
//                            }) {
//                                groupCanMove = false
//                            } else {
//
//                                if piece.indexes?.y! != 0 {
//                                    piecesIndexes.append(Indexes(x: piece.indexes?.x, y: (piece.indexes?.y!)! - 1))
//                                } else {
//                                    groupCanMove = false
//                                }
//                            }
//                        }
//                    }
//
//                    if groupCanMove == true {
//
//                        for piece in group.pieces.sorted(by: { (piece1, piece2) -> Bool in
//                            (piece1.indexes?.y!)! < (piece2.indexes?.y!)!
//                        }) {
//
//                            let beforeIndexes = piece.indexes
//
//                            movePiecesHelper(piece: piece, direction: direction)
//                            self.delegate?.movePieceView(piece: piece)
//
//                            let afterIndexes = piece.indexes
//
//                            if beforeIndexes != afterIndexes {
//                                groupDidMove = true
//                                pieceDidMove = true
//                                piecesMoved = true
//                            }
//                        }
//                    }
//
//                case .down:
//
//                    for piece in group.pieces.sorted(by: { (piece1, piece2) -> Bool in
//                        (piece1.indexes?.y!)! > (piece2.indexes?.y!)!
//                    }) {
//
//                        if board.pieces.contains(where: { pieceX -> Bool in
//                            pieceX.indexes == Indexes(x: piece.indexes?.x, y: (piece.indexes?.y!)! + 1)
//                        }) {
//                            if !group.pieces.contains(where: { pieceXX -> Bool in
//                                pieceXX.indexes == Indexes(x: piece.indexes?.x, y: (piece.indexes?.y!)! + 1)
//                            }) {
//                                groupCanMove = false
//                            }
//
//                        } else {
//
//                            if piecesIndexes.contains(where: { indexX -> Bool in
//                                indexX == Indexes(x: piece.indexes?.x, y: (piece.indexes?.y!)! + 1)
//                            }) {
//                                groupCanMove = false
//                            } else {
//
//                                if piece.indexes?.y! != board.heightSpaces - 1 {
//                                    piecesIndexes.append(Indexes(x: piece.indexes?.x, y: (piece.indexes?.y!)! + 1))
//                                } else {
//                                    groupCanMove = false
//                                }
//                            }
//                        }
//                    }
//
//                    if groupCanMove == true {
//
//                        for piece in group.pieces.sorted(by: { (piece1, piece2) -> Bool in
//                            (piece1.indexes?.y!)! > (piece2.indexes?.y!)!
//                        }) {
//
//                            let beforeIndexes = piece.indexes
//
//                            movePiecesHelper(piece: piece, direction: direction)
//                            self.delegate?.movePieceView(piece: piece)
//
//                            let afterIndexes = piece.indexes
//
//                            if beforeIndexes != afterIndexes {
//                                groupDidMove = true
//                                pieceDidMove = true
//                                piecesMoved = true
//                            }
//                        }
//                    }
//
//                case .left:
//
//                    for piece in group.pieces.sorted(by: { (piece1, piece2) -> Bool in
//                        (piece1.indexes?.x!)! < (piece2.indexes?.x!)!
//                    }) {
//
//                        if board.pieces.contains(where: { pieceX -> Bool in
//                            pieceX.indexes == Indexes(x: (piece.indexes?.x!)! - 1, y: piece.indexes?.y)
//                        }) {
//                            if !group.pieces.contains(where: { pieceXX -> Bool in
//                                pieceXX.indexes == Indexes(x: (piece.indexes?.x!)! - 1, y: piece.indexes?.y)
//                            }) {
//                                groupCanMove = false
//                            }
//
//                        } else {
//
//                            if piecesIndexes.contains(where: { indexX -> Bool in
//                                indexX == Indexes(x: (piece.indexes?.x!)! - 1, y: piece.indexes?.y)
//                            }) {
//
//                                groupCanMove = false
//
//                            } else {
//
//                                if piece.indexes?.x! != 0 {
//                                    piecesIndexes.append(Indexes(x: (piece.indexes?.x!)! - 1, y: piece.indexes?.y))
//                                } else {
//                                    groupCanMove = false
//                                }
//                            }
//                        }
//                    }
//
//                    if groupCanMove == true {
//
//                        for piece in group.pieces.sorted(by: { (piece1, piece2) -> Bool in
//                            (piece1.indexes?.x!)! < (piece2.indexes?.x!)!
//                        }) {
//
//                            let beforeIndexes = piece.indexes
//
//                            movePiecesHelper(piece: piece, direction: direction)
//                            self.delegate?.movePieceView(piece: piece)
//
//                            let afterIndexes = piece.indexes
//
//                            if beforeIndexes != afterIndexes {
//                                groupDidMove = true
//                                pieceDidMove = true
//                                piecesMoved = true
//                            }
//                        }
//                    }
//
//                case .right:
//
//                    for piece in group.pieces.sorted(by: { (piece1, piece2) -> Bool in
//                        (piece1.indexes?.x!)! > (piece2.indexes?.x!)!
//                    }) {
//
//                        if board.pieces.contains(where: { pieceX -> Bool in
//                            pieceX.indexes == Indexes(x: (piece.indexes?.x!)! + 1, y: piece.indexes?.y)
//                        }) {
//                            if !group.pieces.contains(where: { pieceXX -> Bool in
//                                pieceXX.indexes == Indexes(x: (piece.indexes?.x!)! + 1, y: piece.indexes?.y)
//                            }) {
//                                groupCanMove = false
//                            }
//
//                        } else {
//
//                            if piecesIndexes.contains(where: { indexX -> Bool in
//                                indexX == Indexes(x: (piece.indexes?.x!)! + 1, y: piece.indexes?.y)
//                            }) {
//
//                                groupCanMove = false
//                            } else {
//
//                                if piece.indexes?.x! != board.widthSpaces - 1 {
//                                    piecesIndexes.append(Indexes(x: (piece.indexes?.x!)! + 1, y: piece.indexes?.y))
//                                } else {
//                                    groupCanMove = false
//                                }
//                            }
//                        }
//                    }
//
//                    if groupCanMove == true {
//
//                        for piece in group.pieces.sorted(by: { (piece1, piece2) -> Bool in
//                            (piece1.indexes?.x!)! > (piece2.indexes?.x!)!
//                        }) {
//
//                            let beforeIndexes = piece.indexes
//
//                            movePiecesHelper(piece: piece, direction: direction)
//                            self.delegate?.movePieceView(piece: piece)
//
//                            let afterIndexes = piece.indexes
//
//                            if beforeIndexes != afterIndexes {
//                                groupDidMove = true
//                                pieceDidMove = true
//                                piecesMoved = true
//                            }
//                        }
//                    }
//
//                default:
//
//                    break
//                }
//            }
//            group.didMove = groupDidMove
//        }
//
//        if pieceDidMove {
//
//            movePiece2(direction: direction, pieces: piecesToRetry)
//        }
//
////        if groupCanMove == false {
////
//////            groupClusterToRetry.append(groupsToRetry)
////            print(groupClusterToRetry.map({$0.map({$0.hookedPieces.map({$0.groupNumber!})})}))
////
////        }
//
//        print(hookedGroups.map({$0.number}))
//
//
//    }
    
    func resetPieces() {
        
        for piece in board.pieces {
            
            
            piece.canMoveOneSpace = true
        }
        
        addPiece = false
        
    }
    
    func initiateMove(direction: Direction) {

        sortGroups(direction: direction)
        
        sortPieces(direction: direction)

//        moveGroups(direction: direction)
        movePieces(direction: direction)
//        let nextPiece = nextPiece
        
//        printVisualDisplay(type: "pieceID")

        
        
       setNextPiece()
        resetPieces()
        groupPiecesTogetherX()
        updateLabels()
        
        
        
    }
    

    func movePieces(direction: Direction) {
        
//        groupsThatHaveMoved = [Int]()

        setPiecesMobility(direction: direction)
        
        
        movePiecesThatShouldMove(direction: direction)
        
        
        
        
//        print("groupsThatHaveMoved = \(groupsThatHaveMoved)")
//
//        if !groupsThatHaveMoved.isEmpty {
//            movePieces(direction: direction)
//        }
        
        

        
//        groupsThatHaveMoved = [Int]()
        
    }
    
    
    
    func setNextPiece() {
        
        if addPiece == true {
            
            setPieceIndex(piece: nextPiece)
            setPieceID(piece: nextPiece)
            board.pieces.append(nextPiece)
            
            let group = Group(pieces: [nextPiece])
            group.id = board.pieceGroups.map({$0.id}).max()! + 1
            nextPiece.groupNumber = group.id
            board.pieceGroups.append(group)
            
            delegate?.addPieceView(piece: nextPiece)
        }
        
        
        
    }

    var addPiece = false
    
    
    func setPiecesMobility(direction: Direction) {
        
        print("")
        print("setPiecesMobility called")

        setIndexes(direction: direction)

//        checkSpaceAhead(direction: direction)
        


        checkForDuplicatesX(direction: direction)

        checkGroup(direction: direction)


        setIndexesX(direction: direction)

        
        printVisualDisplay(type: "canMove")
        
//        var callAgain = false
//
//        for piece in board.pieces {
//
//            if piece.canMoveOneSpace == true {
//
//                callAgain = true
//                addPiece = true
//
//            }
//
//        }
//
//        if callAgain == true {
//
//            setPiecesMobility(direction: direction)
//        }
        

        
    }
    
    func setIndexesX(direction: Direction) {
        
        
        //MARK: NEED TO SET FOR ALL DIRECTIONS
        
        print("Set indexes called")
        
        switch direction {
            
        case .up:
            
            for piece in board.pieces.sorted(by: { (piece1, piece2) in
                (piece1.indexes?.y!)! < (piece2.indexes?.y!)!
            }) {
                
                print("piece with piece ID of \(piece.id)")
                
                if piece.canMoveOneSpace == true {
                    
                    print("Can Move")
                    
                    piece.indexes = piece.nextIndexes
                    
                    
                } else {
                    
                    
                    
                    print("Cant Move")
                }
            }
            
        case .down:
            
            for piece in board.pieces.sorted(by: { (piece1, piece2) in
                (piece1.indexes?.y!)! > (piece2.indexes?.y!)!
            }) {
                
                print("piece with piece ID of \(piece.id)")
                
                if piece.canMoveOneSpace == true {
                    
                    print("Can Move")
                    
                    piece.indexes = piece.nextIndexes
                } else {
                    
                    print("Cant Move")
                }
            }
            
            
        case .left:
            
            for piece in board.pieces.sorted(by: { (piece1, piece2) in
                (piece1.indexes?.x!)! < (piece2.indexes?.x!)!
            }) {
                
                print("piece with piece ID of \(piece.id)")
                
                if piece.canMoveOneSpace == true {
                    
                    print("Can Move")
                    
                    piece.indexes = piece.nextIndexes
                } else {
                    
                    print("Cant Move")
                }
            }
            
            
        case .right:
            
            for piece in board.pieces.sorted(by: { (piece1, piece2) in
                (piece1.indexes?.x!)! > (piece2.indexes?.x!)!
            }) {
                
                print("piece with piece ID of \(piece.id)")
                
                if piece.canMoveOneSpace == true {
                    
                    print("Can Move")
                    
                    piece.indexes = piece.nextIndexes
                } else {
                    
                    
                    print("Cant Move")
                }
            }
            
        default:
            
            break
            
            
        }
        
        
        
        for pieceX in board.pieces {
            
            for pieceY in board.pieces {
                
                if pieceX.indexes == pieceY.indexes && pieceX.id != pieceY.id {
                    
                    
                    switch direction {
                        
                    case .up:
                        
                        if (pieceX.nextIndexes?.y)! < (pieceY.nextIndexes?.y)! {
                            
                            pieceY.indexes = pieceY.previousIndex
                            pieceY.canMoveOneSpace = false
                        } else {
                            
                            pieceX.indexes = pieceX.previousIndex
                            pieceX.canMoveOneSpace = false
                        }
                        
                    case .down:
                        
                        if (pieceX.nextIndexes?.y)! > (pieceY.nextIndexes?.y)! {
                            
                            pieceY.indexes = pieceY.previousIndex
                            pieceY.canMoveOneSpace = false
                        } else {
                            
                            pieceX.indexes = pieceX.previousIndex
                            pieceX.canMoveOneSpace = false
                        }

                        
                    case .left:
                        
                        if (pieceX.nextIndexes?.x)! < (pieceY.nextIndexes?.x)! {
                            
                            pieceY.indexes = pieceY.previousIndex
                            pieceY.canMoveOneSpace = false
                        } else {
                            
                            pieceX.indexes = pieceX.previousIndex
                            pieceX.canMoveOneSpace = false
                        }

                    case .right:
                    
                        if (pieceX.nextIndexes?.x)! > (pieceY.nextIndexes?.x)! {
                            
                            pieceY.indexes = pieceY.previousIndex
                            pieceY.canMoveOneSpace = false
                        } else {
                            
                            pieceX.indexes = pieceX.previousIndex
                            pieceX.canMoveOneSpace = false
                        }
                        
                        
                    default:
                        
                        break
                        
                        
                        
                        
                        
                        
                        
                        
                    }
                    
                    
                    
                    print("PIECE X \(pieceX.id)")
                    print("PIECE Y \(pieceY.id)")

                    
                }
                
            }
            
            
        }
        
        
        board.locationAndIDs = [Indexes: Int]()
        
        for piece in board.pieces {
            
            board.locationAndIDs[piece.indexes!] = piece.id
        }
        
        
    }
    

    func movePiecesBack() {
        
        for int in piecesToMoveBack {
            
            let piece = returnPiecesFromID(id: int)
            
            piece.canMoveOneSpace = false
        }
                
        
    }
    
    
    
    
    
    func printVisualDisplay(type: String) {
        

        var verticalLine = [(Int, Int)]()
        var chart = [verticalLine]
        
        for x in 0...board.widthSpaces - 1 {
            
            
            for y in 0...board.heightSpaces - 1 {
                
                verticalLine.append((x, y))
                
                
                
            }
            
            chart.append(verticalLine)
            
            verticalLine = [(Int, Int)]()
            
            
            
        }
        
        
        switch type {
            
            
        case "canMove":
            
            for row in chart {
                
                var rowToPrint = [String]()

                
                
                for indexesX in row {
                    

                    if let pieceID = board.locationAndIDs[Indexes(x:indexesX.1 ,y:indexesX.0)] {
                        
                        
                        if returnPiecesFromID(id: pieceID).canMoveOneSpace == true {
                            
                            rowToPrint.append("Y")
                        } else {
                            rowToPrint.append("N")

                        }
                        
                        
                        
                    } else {
                        rowToPrint.append(" ")
                    }
                    
                    
                    
                    
                    
                    
                }
                
                
                
                print(rowToPrint)

                rowToPrint = [String]()
                                
            }
            
            
        case "boardPieceID":
            
    
            for row in chart {
                
                var rowToPrint = [String]()

                
                for indexesX in row {
                    
                    if let pieceID = board.locationAndIDs[Indexes(x:indexesX.1 ,y:indexesX.0)] {
                        
                        
                        if pieceID > 9 {
                            rowToPrint.append(String(pieceID))
                        } else {
                            rowToPrint.append(String(" \(pieceID)"))
                        }
                        
                        
                    } else {
                        rowToPrint.append("  ")
                    }
                    
                }
                
                print(rowToPrint)
                rowToPrint = [String]()
                
            }
            
            
            
        case "pieceID":
            
            for row in chart {
                
                var rowToPrint = [String]()

                for indexesX in row {
                    
                    if let groupID = board.locationAndIDs[Indexes(x: indexesX.1, y:indexesX.0)] {
                        
                        
                        
                        if String(groupID).count == 1 {
                            
                            let newString = " \(String(groupID))"
                            
                            rowToPrint.append(newString)

                            
                        } else {
                            
                            rowToPrint.append(String(groupID))

                            
                        }
                        
                        
                    } else {
                        
                        
                        rowToPrint.append("  ")
                        
                    }
                    
                    
                   
                    
                    
                }
                
                
                
                print(rowToPrint)

                                
            }
            
            
            
        default:
            
            
            
            

            
            for row in chart {
                
                print(row)
                
            }
        }
        
        
        
        
        
    }
    
    
    
    func returnPiecesFromIndex(indexes: Indexes) -> [Piece] {
        
        var piecesToReturn = [Piece]()
        
        for piece in board.pieces {
            
            if piece.indexes == indexes {
                
                
                piecesToReturn.append(piece)
            }
            
            
        }
        
        
        return piecesToReturn
        
        
    }
    
    func returnPiecesFromID(id: Int) -> Piece {
        
        var pieceToReturn = Piece()
        
        for piece in board.pieces {
            
            if piece.id == id {
                
                
                pieceToReturn = piece
            }
            
            
        }
        
        
        return pieceToReturn
        
        
    }
    
    
    func movePiecesThatShouldMove(direction: Direction) {
        
        piecesMovedX = false
        
        for piece in board.pieces {
            
            if piece.canMoveOneSpace == true {
                
//                piecesMovedX = true
                
                delegate?.movePieceView(piece: piece)
                
//                piece.canMoveOneSpace = true
            }
            
            
            
        }
        
    }
    
    
    
    
    func groupCanMoveX(group: Group, direction: Direction) -> Bool {
        
        //MARK: MAKE SURE THIS IS WORKING CORRECTLY FOR RIGHT AND LEFT
        
        var boolToReturn = true
        
        switch direction {
            
        case .up:
            
            for piece in group.pieces{
                
//                    print()
//                    print(piece.indexes!)
                
                if piece.indexes?.y != 0 {
                    
                    for groupX in board.pieceGroups {
                        
                        for pieceX in groupX.pieces {
                            
                            if pieceX.indexes == Indexes(x: piece.indexes!.x, y: piece.indexes!.y! - 1) {
                                
//                                    print("There is a piece in front")
                                
                                if !group.pieces.contains(where: { (piece3) in
                                    piece3.indexes == Indexes(x: piece.indexes!.x, y: piece.indexes!.y! - 1)
                                    
                                }) {
                                    boolToReturn = false
//                                        print("Piece is from this group group")

                                } else {
//                                        print("Piece is from another group")
                                    
                                    
                                }
                            }
                        }
                    }
                } else {
                    
                    boolToReturn = false
                }
                
//                    print(groupCanMove)
            }
            
        case .down:
            
            for piece in group.pieces {
                
//                    print()
//                    print(piece.indexes!)
                
                if piece.indexes?.y != board.heightSpaces - 1{
                    
                    for groupX in board.pieceGroups {
                        
                        for pieceX in groupX.pieces {
                            
                            if pieceX.indexes == Indexes(x: piece.indexes!.x, y: piece.indexes!.y! + 1) {
                                
//                                    print("There is a piece in front")
                                
                                if !group.pieces.contains(where: { (piece3) in
                                    piece3.indexes == Indexes(x: piece.indexes!.x, y: piece.indexes!.y! + 1)
                                    
                                }) {
                                    
                                    boolToReturn = false
//                                        print("Piece is from this group group")

                                } else {
//                                        print("Piece is from another group")
                                    
                                    
                                }
                            }
                        }
                    }
                } else {
                    
                    boolToReturn = false
                }
                
//                    print(groupCanMove)
            }
            
        case .left:
            
            for piece in group.pieces{
                
//                    print()
//                    print(piece.indexes!)
                
                if piece.indexes?.x != 0 {
                    
                    for groupX in board.pieceGroups {
                        
                        for pieceX in groupX.pieces {
                            
                            if pieceX.indexes == Indexes(x: piece.indexes!.x! - 1, y: piece.indexes!.y) {
                                
//                                    print("There is a piece in front")
                                
                                if !group.pieces.contains(where: { (piece3) in
                                    piece3.indexes == Indexes(x: piece.indexes!.x! - 1, y: piece.indexes!.y)
                                    
                                }) {
                                    boolToReturn = false
//                                        print("Piece is from this group group")

                                } else {
//                                        print("Piece is from another group")
                                    
                                    
                                }
                            }
                        }
                    }
                } else {
                    
                    boolToReturn = false
                }
                
//                    print(groupCanMove)
            }

            
        case .right:
            
            for piece in group.pieces{
                
//                    print()
//                    print(piece.indexes!)
                
                if piece.indexes?.x != board.widthSpaces - 1 {
                    
                    for groupX in board.pieceGroups {
                        
                        for pieceX in groupX.pieces {
                            
                            if pieceX.indexes == Indexes(x: piece.indexes!.x! + 1, y: piece.indexes!.y) {
                                
//                                    print("There is a piece in front")
                                
                                if !group.pieces.contains(where: { (piece3) in
                                    piece3.indexes == Indexes(x: piece.indexes!.x! + 1, y: piece.indexes!.y)
                                    
                                }) {
                                    
                                    boolToReturn = false
//                                        print("Piece is from this group group")

                                } else {
//                                        print("Piece is from another group")
                                   
                                    
                                }
                            }
                        }
                    }
                } else {
                    
                    boolToReturn = false
                }
                
//                    print(groupCanMove)
            }


            
        default:
            
            break
            
        }
        
        
        
        return boolToReturn
    }
   
    func moveAllGrpPcs(group: Group, direction: Direction) {
        
        switch direction{
            
        case .up:
            
            for piece in group.pieces.sorted(by: { (piece1, piece2) in
                piece1.indexes!.y! < piece2.indexes!.y!
            }) {
                movePiecesHelper(piece: piece, direction: direction)
                self.delegate?.movePieceView(piece: piece)
            }
            
        case .down:
            
            for piece in group.pieces.sorted(by: { (piece1, piece2) in
                piece1.indexes!.y! > piece2.indexes!.y!
            }) {
                movePiecesHelper(piece: piece, direction: direction)
                self.delegate?.movePieceView(piece: piece)
            }
            
        case .left:
            
            for piece in group.pieces.sorted(by: { (piece1, piece2) in
                piece1.indexes!.x! < piece2.indexes!.x!
            }) {
                movePiecesHelper(piece: piece, direction: direction)
                self.delegate?.movePieceView(piece: piece)
            }
            
        case .right:
            
            for piece in group.pieces.sorted(by: { (piece1, piece2) in
                piece1.indexes!.x! > piece2.indexes!.x!
            }) {
                movePiecesHelper(piece: piece, direction: direction)
                self.delegate?.movePieceView(piece: piece)
            }
            
        default:
            
            break
            
        }
        
    }
    
    

    var masterGroupOfGroupsX = [[Int]]()

    
    func moveGroups(direction: Direction) {
        
        var tempGroupIDs = [Int: [Int]]()
        
        piecesMoved = false
        
        for group in board.pieceGroups {
            
//            print("group number = \(group.id)")
            
            if groupCanMoveX(group: group, direction: direction) == true {
                
                moveAllGrpPcs(group: group, direction: direction)
                
            } else {
                
                tempGroupIDs = returnGroupHookGroups(group: group, direction: direction)
                
                
//                print("tempGroups \(tempGroupIDs)")
            }
        }
        
        
//        print("tempGroupIDs =  \(tempGroupIDs)")
        
        var groupedGroups = [[Int]]()
        var currentSetToCheck = [Int]()
        
        for (hook, hookies) in tempGroupIDs {
            currentSetToCheck.append(hook)
            for hookie in hookies {
                currentSetToCheck.append(hookie)
            }
            groupedGroups.append(currentSetToCheck)
            currentSetToCheck = [Int]()
        }
        
        
//        print("groupedGroups \(groupedGroups)")
        
        
        for groupX in groupedGroups.sorted(by: { (group1, group2) in
            group1.count > group2.count
        }) {
            
            var addWholeGroup = false
            
            if masterGroupOfGroupsX.isEmpty {
                
//                print("masterGroupOfGroups is empty")
                masterGroupOfGroupsX.append(groupX)
                
            } else {
                
                //IF ANY GROUPS INCLUDE ANY OF THE NUMBERS, ADD ALL NUMBERS TO THAT GROUP AND STOP THE FUNC
                
                var counter = 0
                var index2AddTo = Int()
                
                for masterGroup in masterGroupOfGroupsX {
                    
                    for numX in groupX {
                        
                        for numY in masterGroup {
                            
                            if numX == numY {
                                
                                index2AddTo = counter
                                addWholeGroup = true
//                                print("This entire group should be added to this mastergroup")
                                
                            }
                        }
                    }
                    counter += 1
                }
                
                
                if addWholeGroup == true {
                    
                    addWholeGroup = false
                    
                    for number in groupX {
                        
                        if !masterGroupOfGroupsX[index2AddTo].contains(where: { (IntXXX) in
                            IntXXX == number
                        }) {
                            masterGroupOfGroupsX[index2AddTo].append(number)
                            
                        }
                    }
                    
                } else {
                    
//                    print("appending the entire group")
                    masterGroupOfGroupsX.append(groupX)
                    
                    
                }
            }
        }
        
        print("masterGroupOfGroupsX \(masterGroupOfGroupsX)")
        
        
        
        for masterGroup in masterGroupOfGroupsX {
            
            if masterGroup.count > 1 {
                moveHooks(arrayOfInts: masterGroup, direction: direction)

            }
            
        }
        
        masterGroupOfGroupsX = [[Int]]()
        
        
        if piecesMoved == true {
            
//            sortGroups(direction: direction)
            moveGroups(direction: direction)
            
        } else {
            
            updateBoard()
            
            
        }
    
    }
    
    
    func moveHooks (arrayOfInts: [Int], direction: Direction) {
        
        //MARK: NEED TO MAKE SURE THAT THIS WORKS FOR LEFT & RIGHT
        
//        print("")
//
//        print("hooksCanMove")
        
        
        var bool = true
        
        var piecesY = [Piece]()
        
        for number in arrayOfInts {
            
            let group = returnGroup(groupNumber: number)
            
            let piecesX = group.pieces
            
            for pieceX in piecesX {
                
                
                piecesY.append(pieceX)
            }
            
        }
        
        for pieceY in piecesY {
            
                switch direction {
                    
                    
                case .up:
                    
                    if (pieceY.indexes?.y)! == 0 {
                        
                        bool = false
                        
                        
                    } else {
                        
                        
                        for group in board.pieceGroups {
                            
                            for piece in group.pieces {
                                
                                if piece.indexes?.x == pieceY.indexes?.x && piece.indexes?.y == (pieceY.indexes?.y)! - 1 {
                                    
                                    
                                    if !arrayOfInts.contains(where: { (numX) in
                                        numX == piece.groupNumber
                                    }) {
                                        bool = false
                                    }
                                    
                                    
                                }
                                
                            }
                            
                        }
                    }
                case .down:
                    
                    if (pieceY.indexes?.y)! == board.heightSpaces - 1 {
                        
                        bool = false
                        
                        
                    } else {
                        
                        
                        for group in board.pieceGroups {
                            
                            for piece in group.pieces {
                                
                                if piece.indexes?.x == pieceY.indexes?.x && piece.indexes?.y == (pieceY.indexes?.y)! + 1 {
                                    
                                    
                                    if !arrayOfInts.contains(where: { (numX) in
                                        numX == piece.groupNumber
                                    }) {
                                        bool = false
                                    }
                                    
                                    
                                }
                                
                            }
                            
                        }
                    }

                case .left:
                    
                    if (pieceY.indexes?.x)! == 0 {
                        
                        bool = false
                        
                        
                    } else {
                        
                        
                        for group in board.pieceGroups {
                            
                            for piece in group.pieces {
                                
                                if piece.indexes?.x == (pieceY.indexes?.x)! - 1 && piece.indexes?.y == (pieceY.indexes?.y) {
                                    
                                    
                                    if !arrayOfInts.contains(where: { (numX) in
                                        numX == piece.groupNumber
                                    }) {
                                        bool = false
                                    }
                                    
                                    
                                }
                                
                            }
                            
                        }
                    }

                case .right:
                    
                    if (pieceY.indexes?.x)! == board.widthSpaces - 1 {
                        
                        bool = false
                        
                        
                    } else {
                        
                        
                        for group in board.pieceGroups {
                            
                            for piece in group.pieces {
                                
                                if piece.indexes?.x == (pieceY.indexes?.x)! + 1 && piece.indexes?.y == (pieceY.indexes?.y) {
                                    
                                    
                                    if !arrayOfInts.contains(where: { (numX) in
                                        numX == piece.groupNumber
                                    }) {
                                        bool = false
                                    }
                                    
                                    
                                }
                                
                            }
                            
                        }
                    }
                    
                default:
                    
                    break
                }
                
        }
        
        if bool == true {
            
            switch direction {
                
            case .up:

                for pieceZ in piecesY.sorted(by: { (piece1, piece2) in
                    (piece1.indexes?.y)! < (piece2.indexes?.y)!
                }) {
                    
                    pieceZ.indexes?.y! -= 1
                    
                    delegate?.movePieceView(piece: pieceZ)
                    
                }
                
            case .down:
                
                for pieceZ in piecesY.sorted(by: { (piece1, piece2) in
                    (piece1.indexes?.y)! > (piece2.indexes?.y)!
                }) {
                    
                    pieceZ.indexes?.y! += 1
                    
                    delegate?.movePieceView(piece: pieceZ)
                    
                }
                
                
            case .left:
                
                for pieceZ in piecesY.sorted(by: { (piece1, piece2) in
                    (piece1.indexes?.x)! < (piece2.indexes?.x)!
                }) {
                    
                    pieceZ.indexes?.x! -= 1
                    
                    delegate?.movePieceView(piece: pieceZ)
                    
                }
            case .right:
                
                for pieceZ in piecesY.sorted(by: { (piece1, piece2) in
                    (piece1.indexes?.x)! > (piece2.indexes?.x)!
                }) {
                    
                    pieceZ.indexes?.x! += 1
                    
                    delegate?.movePieceView(piece: pieceZ)
                    
                }
            default:
                break
                
                
                
            }
            
            
            
            
            
            
            
            
            
            piecesMoved = true
        } else {
            
            
        }
        
        
        
        
        
//        print("bool = \(bool)")
        
        
    }
    
    
    
    func returnGroup(groupNumber: Int) -> Group {
            
            
            let pieces = [Piece]()
            var group2Return = Group(pieces: pieces)
            
            for group in board.pieceGroups {
                
                if group.id == groupNumber {
                    
                    group2Return = group
                    
                }
                
            }
            
            return group2Return
        }
    

    
    func returnGroupHookPieces(group: Group, direction: Direction) -> [Piece] {
        
        //MARK: NEED TO MAKE SURE THAT THIS WORKS FOR LEFT & RIGHT //CORRECTION - THIS ISNT USED
        
//        print("returnGroupHookPieces")
        
        var pieces2Return = [Piece]()
        
        
        var currentGroupHookedPieces = [Piece]()
        
        var tempIntArray = [Int]()

        switch direction {
            
        case .up:
            
            for piece in group.pieces.sorted(by: { (piece1, piece2) in
                piece1.indexes!.y! > piece2.indexes!.y!
            }) {
                

                
                //first check to see if there are pieces next to it, if there arent, skip
                if group.pieces.contains(where: { piece3 in
                    (piece3.indexes!.y! == piece.indexes!.y! && piece3.indexes!.x! < piece.indexes!.x!) || (piece3.indexes!.y! == piece.indexes!.y! && piece3.indexes!.x! > piece.indexes!.x!)
                }) {
                    
                    //Now that we know that there is a piece next to it, lets see if there is a piece infront of it, otherwise its not a hook
                    
                    if group.pieces.contains(where: { piece3 in
                        (piece3.indexes!.y! == piece.indexes!.y! - 1 && piece3.indexes!.x! == piece.indexes!.x!)
                    }) {
                        
//                        print("There is a hook!")

                        //Now need to save the "hook" pieces and see what pieces may be above them (these pieces would be the pieces with the same Y axis but different x axis's

                        currentGroupHookedPieces = group.pieces.filter { piece1 in
                            piece1.indexes!.y! == piece.indexes!.y! && piece1.indexes!.x! != piece.indexes!.x!
                        }
                        
                        //Now need to add all pieces to the left and the right

                        for pieceHook in currentGroupHookedPieces {
                            
                            for groupXXX in board.pieceGroups {
                                
                                if groupXXX.id != group.id {
                                    
                                    for pieceX in groupXXX.pieces {
                                        
                                        if pieceX.indexes == Indexes(x: pieceHook.indexes?.x, y: (pieceHook.indexes?.y)! - 1) {
                                            
                                            
//                                            print("Group that is hooking = \(piece.groupNumber)")
//
//                                            print("Group that is hooked = \(pieceX.groupNumber)")
                                            
                                            
                                            tempIntArray.append(pieceX.groupNumber)
                                            
                                            
                                            
                                            
                                            if !groups2Return.contains(where: { (groupA) in
                                                groupA.id == piece.groupNumber
                                            }) {
                                                
                                                
                                                
                                                groups2Return.append(group)
                                                
//                                                print("Groups to return A = \(groups2Return.map({$0.id}))")
                                                
                                            }
                                            
                                            if !groups2Return.contains(where: { (groupA) in
                                                groupA.id == pieceX.groupNumber
                                            }) {
                                                
                                                groups2Return.append(groupXXX)
                                                
//                                                print("Groups to return B = \(groups2Return.map({$0.id}))")
                                                
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
                
                
            }
            
//            blockeeAndBlockers[group.id] = tempIntArray
//            print(blockeeAndBlockers)
            
            //break
            
        case .down:
            
            for piece in group.pieces.sorted(by: { (piece1, piece2) in
                piece1.indexes!.y! < piece2.indexes!.y! //CHANGE ARROW
            }) {
                
                //first check to see if there are pieces next to it, if there arent, skip
                if group.pieces.contains(where: { piece3 in
                    (piece3.indexes!.y! == piece.indexes!.y! && piece3.indexes!.x! < piece.indexes!.x!) || (piece3.indexes!.y! == piece.indexes!.y! && piece3.indexes!.x! > piece.indexes!.x!) //LEFT ALONE
                }) {
                    
                    //Now that we know that there is a piece next to it, lets see if there is a piece infront of it, otherwise its not a hook
                    
                    if group.pieces.contains(where: { piece3 in
                        (piece3.indexes!.y! == piece.indexes!.y! + 1 && piece3.indexes!.x! == piece.indexes!.x!) //CHANGED TO PLUS ONE
                    }) {
                        
//                        print("There is a hook!")

                        //Now need to save the "hook" pieces and see what pieces may be above them (these pieces would be the pieces with the same Y axis but different x axis's

                        currentGroupHookedPieces = group.pieces.filter { piece1 in
                            piece1.indexes!.y! == piece.indexes!.y! && piece1.indexes!.x! != piece.indexes!.x!
                        }
                        
                        //Now need to add all pieces to the left and the right

                        for pieceHook in currentGroupHookedPieces {
                            
                            for groupXXX in board.pieceGroups {
                                
                                if groupXXX.id != group.id {
                                    
                                    for pieceX in groupXXX.pieces {
                                        
                                        if pieceX.indexes == Indexes(x: pieceHook.indexes?.x, y: (pieceHook.indexes?.y)! + 1) { //CHANGED TO PLUS
                                            
                                            
//                                            print("Group that is hooking = \(piece.groupNumber)")
                                            
//                                            print("Group that is hooked = \(pieceX.groupNumber)")
                                            
                                            
                                            if !groups2Return.contains(where: { (groupA) in
                                                groupA.id == piece.groupNumber
                                            }) {
                                                
                                                
                                                
                                                groups2Return.append(group)
                                                
//                                                print("Groups to return A = \(groups2Return.map({$0.id}))")
                                                
                                            }
                                            
                                            if !groups2Return.contains(where: { (groupA) in
                                                groupA.id == pieceX.groupNumber
                                            }) {
                                                
                                                groups2Return.append(groupXXX)
                                                
//                                                print("Groups to return B = \(groups2Return.map({$0.id}))")
                                                
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            break
            
//            break

            
        case .left:
            
            break

            
        case .right:
            
            break

        default:
            
            
            break
            
            
        }
        
        for groupAA in groups2Return {
            
            for pieceAA in groupAA.pieces {
                
                
                pieces2Return.append(pieceAA)
                
            }
            
        }
        
        
        
//        print(pieces2Return.map({$0.indexes}))
        return pieces2Return
        
        
    }
    
    func returnGroupHookGroups(group: Group, direction: Direction) -> [Int: [Int]] {
        
        //MARK: NEED TO MAKE SURE THAT THIS WORKS FOR LEFT & RIGHT
        
//        print("returnGroupHookPieces")
        
        var set2Return = [Int: [Int]]()
        
        
        var currentGroupHookedPieces = [Piece]()
        
        var tempIntArray = [Int]()

        switch direction {
            
        case .up:
            
            
            for piece in group.pieces.sorted(by: { (piece1, piece2) in
                piece1.indexes!.y! < piece2.indexes!.y!
            }) {
                

                
                //first check to see if there are pieces next to it, if there arent, skip
                if group.pieces.contains(where: { piece3 in
                    (piece3.indexes!.y! == piece.indexes!.y! && piece3.indexes!.x! < piece.indexes!.x!) || (piece3.indexes!.y! == piece.indexes!.y! && piece3.indexes!.x! > piece.indexes!.x!)
                }) {
                    
                    //Now that we know that there is a piece next to it, lets see if there is a piece infront of it, otherwise its not a hook
                    
                    if group.pieces.contains(where: { piece3 in
                        (piece3.indexes!.y! == piece.indexes!.y! - 1 && piece3.indexes!.x! == piece.indexes!.x!)
                    }) {
                        
//                        print("There is a hook!")

                        //Now need to save the "hook" pieces and see what pieces may be above them (these pieces would be the pieces with the same Y axis but different x axis's

                        currentGroupHookedPieces = group.pieces.filter { piece1 in
                            piece1.indexes!.y! == piece.indexes!.y! && piece1.indexes!.x! != piece.indexes!.x!
                        }
                        
                        //Now need to add all pieces to the left and the right

                        for pieceHook in currentGroupHookedPieces {
                            
//                            print("Piece Hook \(pieceHook.indexes)")
                            
                            for groupXXX in board.pieceGroups {
                                
                                if groupXXX.id != group.id {
                                    
                                    for pieceX in groupXXX.pieces {
                                        
                                        if pieceX.indexes == Indexes(x: pieceHook.indexes?.x, y: (pieceHook.indexes?.y)! - 1) {
                                            
                                            
//                                            print("Group that is hooking = \(piece.groupNumber)")
//
//                                            print("Group that is hooked = \(pieceX.groupNumber)")
                                            
                                            if !tempIntArray.contains(where: { number in
                                                number == pieceX.groupNumber
                                            }) {
                                                tempIntArray.append(pieceX.groupNumber)

                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
//            print(blockeeAndBlockers)
            
            
            //break
            
        case .down:
            
            for piece in group.pieces.sorted(by: { (piece1, piece2) in
                piece1.indexes!.y! > piece2.indexes!.y! //CHANGE ARROW
            }) {
                
                //first check to see if there are pieces next to it, if there arent, skip
                if group.pieces.contains(where: { piece3 in
                    (piece3.indexes!.y! == piece.indexes!.y! && piece3.indexes!.x! < piece.indexes!.x!) || (piece3.indexes!.y! == piece.indexes!.y! && piece3.indexes!.x! > piece.indexes!.x!) //LEFT ALONE
                }) {
                    
                    //Now that we know that there is a piece next to it, lets see if there is a piece infront of it, otherwise its not a hook
                    
                    if group.pieces.contains(where: { piece3 in
                        (piece3.indexes!.y! == piece.indexes!.y! + 1 && piece3.indexes!.x! == piece.indexes!.x!) //CHANGED TO PLUS ONE
                    }) {
                        
//                        print("There is a hook!")

                        //Now need to save the "hook" pieces and see what pieces may be above them (these pieces would be the pieces with the same Y axis but different x axis's

                        currentGroupHookedPieces = group.pieces.filter { piece1 in
                            piece1.indexes!.y! == piece.indexes!.y! && piece1.indexes!.x! != piece.indexes!.x!
                        }
                        
                        //Now need to add all pieces to the left and the right

                        for pieceHook in currentGroupHookedPieces {
                            
                            for groupXXX in board.pieceGroups {
                                
                                if groupXXX.id != group.id {
                                    
                                    for pieceX in groupXXX.pieces {
                                        
                                        if pieceX.indexes == Indexes(x: pieceHook.indexes?.x, y: (pieceHook.indexes?.y)! + 1) { //CHANGED TO PLUS
                                            
                                            
//                                            print("Group that is hooking = \(piece.groupNumber)")
//
//                                            print("Group that is hooked = \(pieceX.groupNumber)")
                                            
                                            if !tempIntArray.contains(where: { number in
                                                number == pieceX.groupNumber
                                            }) {
                                                tempIntArray.append(pieceX.groupNumber)

                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
//            break
            
//            break

            
        case .left:
            
            for piece in group.pieces.sorted(by: { (piece1, piece2) in
                piece1.indexes!.x! < piece2.indexes!.x!
            }) {
                

                
                //first check to see if there are pieces next to it, if there arent, skip
                if group.pieces.contains(where: { piece3 in
                    (piece3.indexes!.y! < piece.indexes!.y! && piece3.indexes!.x! == piece.indexes!.x!) || (piece3.indexes!.y! > piece.indexes!.y! && piece3.indexes!.x! == piece.indexes!.x!)
                }) {
                    
                    //Now that we know that there is a piece next to it, lets see if there is a piece infront of it, otherwise its not a hook
                    
                    if group.pieces.contains(where: { piece3 in
                        (piece3.indexes!.y! == piece.indexes!.y! && piece3.indexes!.x! == piece.indexes!.x! - 1)
                    }) {
                        
//                        print("There is a hook!")

                        //Now need to save the "hook" pieces and see what pieces may be above them (these pieces would be the pieces with the same Y axis but different x axis's

                        currentGroupHookedPieces = group.pieces.filter { piece1 in
                            piece1.indexes!.y! != piece.indexes!.y! && piece1.indexes!.x! == piece.indexes!.x!
                        }
                        
                        //Now need to add all pieces to the left and the right

                        for pieceHook in currentGroupHookedPieces {
                            
//                            print("Piece Hook \(pieceHook.indexes)")
                            
                            for groupXXX in board.pieceGroups {
                                
                                if groupXXX.id != group.id {
                                    
                                    for pieceX in groupXXX.pieces {
                                        
                                        if pieceX.indexes == Indexes(x: (pieceHook.indexes?.x)! - 1, y: (pieceHook.indexes?.y)!) {
                                            
                                            
//                                            print("Group that is hooking = \(piece.groupNumber)")
//
//                                            print("Group that is hooked = \(pieceX.groupNumber)")
                                            
                                            if !tempIntArray.contains(where: { number in
                                                number == pieceX.groupNumber
                                            }) {
                                                tempIntArray.append(pieceX.groupNumber)

                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            
//            break

            
        case .right:
            
            
            for piece in group.pieces.sorted(by: { (piece1, piece2) in
                piece1.indexes!.x! > piece2.indexes!.x! //CHANGE ARROW
            }) {
                
                //first check to see if there are pieces next to it, if there arent, skip
                if group.pieces.contains(where: { piece3 in
                    (piece3.indexes!.y! < piece.indexes!.y! && piece3.indexes!.x! == piece.indexes!.x!) || (piece3.indexes!.y! < piece.indexes!.y! && piece3.indexes!.x! == piece.indexes!.x!) //LEFT ALONE
                }) {
                    
                    //Now that we know that there is a piece next to it, lets see if there is a piece infront of it, otherwise its not a hook
                    
                    if group.pieces.contains(where: { piece3 in
                        (piece3.indexes!.y! == piece.indexes!.y! && piece3.indexes!.x! == piece.indexes!.x! + 1) //CHANGED TO PLUS ONE
                    }) {
                        
//                        print("There is a hook!")

                        //Now need to save the "hook" pieces and see what pieces may be above them (these pieces would be the pieces with the same Y axis but different x axis's

                        currentGroupHookedPieces = group.pieces.filter { piece1 in
                            piece1.indexes!.y! != piece.indexes!.y! && piece1.indexes!.x! == piece.indexes!.x!
                        }
                        
                        //Now need to add all pieces to the left and the right

                        for pieceHook in currentGroupHookedPieces {
                            
                            for groupXXX in board.pieceGroups {
                                
                                if groupXXX.id != group.id {
                                    
                                    for pieceX in groupXXX.pieces {
                                        
                                        if pieceX.indexes == Indexes(x: (pieceHook.indexes?.x)! + 1, y: (pieceHook.indexes?.y)!) { //CHANGED TO PLUS
                                            
                                            
//                                            print("Group that is hooking = \(piece.groupNumber)")
//
//                                            print("Group that is hooked = \(pieceX.groupNumber)")
                                            
                                            if !tempIntArray.contains(where: { number in
                                                number == pieceX.groupNumber
                                            }) {
                                                tempIntArray.append(pieceX.groupNumber)

                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            
            
            
            
//            break

        default:
            
            
            break
            
            
        }
        
//        for groupAA in groups2Return {
//
//            for pieceAA in groupAA.pieces {
//
//
//                set2Return.append(pieceAA)
//
//            }
//
//        }
        
//        set2Return[group.id] = tempIntArray

//        print("set to return \(set2Return)")
        
        blockeeAndBlockers[group.id] = tempIntArray
        
        set2Return = blockeeAndBlockers
        
//        set2Return = blockeeAndBlockers
//        print(pieces2Return.map({$0.indexes}))
        return set2Return
        
        
    }
    
    
    
    func groupPiecesTogetherX() {
        
        //MARK: SOMETHING ISNT RIGHT ABOUT THIS. AS OF RIGHT NOW THERE WAS A TIME THAT PIECES OF THE SAME COLOR DIDNT GROUP TOGETHER
        
        var pieces2Skip = [Piece]()

        for group in board.pieceGroups{
            
//            print("Group ID = \(group.id)")
            
            for piece in group.pieces {
                
//                print("Skip contains \(pieces2Skip)")

                
                if pieces2Skip.contains(where: { (pieceX) in
                    pieceX.indexes! == piece.indexes!
                }) {
                    
//                    print("THIS IS TRUE - RETURNING")
                    return
                }
                
                let index1 = Indexes(x:piece.indexes?.x, y: (piece.indexes?.y)! - 1)
                let index2 = Indexes(x:piece.indexes?.x, y: (piece.indexes?.y)! + 1)
                let index3 = Indexes(x:(piece.indexes?.x)! - 1, y: piece.indexes?.y)
                
                let index4 = Indexes(x:(piece.indexes?.x)! + 1, y: piece.indexes?.y)
                
                
                var indexes2Check = [index1, index2, index3, index4]
                

                indexes2Check.removeAll { (indexX) in
                    indexX.x! < 0 || indexX.y! < 0 || indexX.x! > board.widthSpaces - 1 || indexX.y! > board.heightSpaces - 1
                }
                
//                print(piece.indexes!)
//                print(indexes2Check)
//
                
                //UP TO HERE
                
                for indexX in indexes2Check {
                    
                    
                    if group.pieces.contains(where: { (pieceX) in
                        pieceX.indexes == indexX
                    }) {
                        break
                    } else {
                        
                        for groupX in board.pieceGroups {
                            
                            if groupX.id != group.id {
                                
                                if groupX.pieces.contains(where: { (pieceXX) in
                                    pieceXX.indexes == indexX && pieceXX.color == piece.color
                                }) {
//                                    print("These groups should be added together!")
                                    
                                    let groupIdToBeDeleted = groupX.id
                                    
//                                    delegate?.animateGrouping(piece: piece)
                                    
                                    for pieceXXX in groupX.pieces {
                                        
                                        group.pieces.append(pieceXXX)
                                        pieceXXX.groupNumber = group.id
                                        pieces2Skip.append(pieceXXX)
                                        
                                        
                                    }
                                    
                                    for pieceXXXXX in group.pieces {
                                        delegate?.animateGrouping(piece: pieceXXXXX)

                                    }
                                    
                                    board.pieceGroups.removeAll { (group) in
                                        group.id == groupIdToBeDeleted
                                    }
                                    
                                    
//                                    for groupXXXX in board.pieceGroups {
//
//                                        print("group.id = \(groupXXXX.id)")
//
//                                        for pieceXXXX in groupXXXX.pieces {
//
//                                            print("piece indexes = \(pieceXXXX.indexes)")
//
//                                        }
//
//
//
//                                    }
                                    
                                    
                                    
                                } else {
//                                    print("This is False")
                                }
                                
                            }
                            
                            
                        }
                        
                        
                        
                        
                    }
                    
                    
                }

                
            }
            
            
            
        }
        

    }
    
    
    
//    func groupPiecesTogether() { //MARK: Need to change - When grouping 2 groups together, the group number should be the group that has more pieces
//
//        board.pieceGroups = []
//
//        let tempBoardPieces = board.pieces //TODO: May want to consider taking pieces out of here after they've been added to a group because of another piece
//
//
//
//
////        tempBoardPieces.sort { (piece1, piece2) in
////            piece1.indexes!.x! < piece2.indexes!.x!
////        }
////
////        tempBoardPieces.sort { (piece1, piece2) in
////            piece1.indexes!.y! < piece2.indexes!.y!
////        }
//
//        for piece in tempBoardPieces.sorted(by: { (piece1, piece2) in
//            piece1.indexes!.x! < piece2.indexes!.x!
//        }).sorted(by: { piece1, piece2 in
//            piece1.indexes!.y! < piece2.indexes!.y!
//        }) {
//
//            for pieceX in board.pieces {
//
//                if piece.indexes!.y! == pieceX.indexes!.y! - 1 && piece.indexes!.x! == pieceX.indexes!.x! && piece.color == pieceX.color{
//
//                    if piece.groupNumber == nil && pieceX.groupNumber == nil {
//
//                        piece.groupNumber = groupCount + 1
//                        pieceX.groupNumber = groupCount + 1
//                        groupCount += 1
//                        animation4GroupingPieces(pieces: [piece, pieceX])
//
//                    } else if pieceX.groupNumber != nil && piece.groupNumber == nil {
//
//                        piece.groupNumber = pieceX.groupNumber
//                        animation4GroupingPieces(pieces: [piece, pieceX])
//
//                    } else if pieceX.groupNumber == nil && piece.groupNumber != nil {
//
//                        pieceX.groupNumber = piece.groupNumber
//                        animation4GroupingPieces(pieces: [piece, pieceX])
//
//                    } else if pieceX.groupNumber != nil && piece.groupNumber != nil {
//
//                        if piece.groupNumber != pieceX.groupNumber {
//
//                            for pieceXX in board.pieces {
//
//                                if pieceXX.groupNumber == pieceX.groupNumber {
//
//                                    pieceX.groupNumber = piece.groupNumber
//                                    animation4GroupingPieces(pieces: [piece, pieceX])
//                                }
//                            }
//                        }
//                    }
//                }
//
//                else if piece.indexes!.y! == pieceX.indexes!.y! && piece.indexes!.x! == pieceX.indexes!.x! - 1 && piece.color == pieceX.color{
//
//                    if piece.groupNumber == nil && pieceX.groupNumber == nil {
//
//                        piece.groupNumber = groupCount + 1
//                        pieceX.groupNumber = groupCount + 1
//                        groupCount += 1
//                        animation4GroupingPieces(pieces: [piece, pieceX])
//
//                    } else if pieceX.groupNumber != nil && piece.groupNumber == nil {
//
//                        piece.groupNumber = pieceX.groupNumber
//                        animation4GroupingPieces(pieces: [piece, pieceX])
//
//                    } else if pieceX.groupNumber == nil && piece.groupNumber != nil {
//
//                        pieceX.groupNumber = piece.groupNumber
//                        animation4GroupingPieces(pieces: [piece, pieceX])
//
//                    } else if pieceX.groupNumber != nil && piece.groupNumber != nil {
//
//                        if piece.groupNumber != pieceX.groupNumber {
//
//                            for pieceXX in board.pieces {
//
//                                if pieceXX.groupNumber == pieceX.groupNumber {
//
//                                    pieceX.groupNumber = piece.groupNumber
//                                    animation4GroupingPieces(pieces: [piece, pieceX])
//                                }
//                            }
//                        }
//                    }
//                }
//                else if piece.indexes!.y! == pieceX.indexes!.y! + 1 && piece.indexes!.x! == pieceX.indexes!.x! && piece.color == pieceX.color{
//
//                    if piece.groupNumber == nil && pieceX.groupNumber == nil {
//
//                        piece.groupNumber = groupCount + 1
//                        pieceX.groupNumber = groupCount + 1
//                        groupCount += 1
//                        animation4GroupingPieces(pieces: [piece, pieceX])
//
//                    } else if pieceX.groupNumber != nil && piece.groupNumber == nil {
//
//                        piece.groupNumber = pieceX.groupNumber
//                        animation4GroupingPieces(pieces: [piece, pieceX])
//
//                    } else if pieceX.groupNumber == nil && piece.groupNumber != nil {
//
//                        pieceX.groupNumber = piece.groupNumber
//                        animation4GroupingPieces(pieces: [piece, pieceX])
//
//                    } else if pieceX.groupNumber != nil && piece.groupNumber != nil {
//
//                        if piece.groupNumber != pieceX.groupNumber {
//
//                            for pieceXX in board.pieces {
//
//                                if pieceXX.groupNumber == pieceX.groupNumber {
//
//                                    pieceX.groupNumber = piece.groupNumber
//                                    animation4GroupingPieces(pieces: [piece, pieceX])
//                                }
//                            }
//                        }
//                    }
//                }
//
//
//                else if piece.indexes!.y! == pieceX.indexes!.y! && piece.indexes!.x! == pieceX.indexes!.x! + 1 && piece.color == pieceX.color{
//
//                    if piece.groupNumber == nil && pieceX.groupNumber == nil {
//
//                        piece.groupNumber = groupCount + 1
//                        pieceX.groupNumber = groupCount + 1
//                        groupCount += 1
//                        animation4GroupingPieces(pieces: [piece, pieceX])
//
//                    } else if pieceX.groupNumber != nil && piece.groupNumber == nil {
//
//                        piece.groupNumber = pieceX.groupNumber
//                        animation4GroupingPieces(pieces: [piece, pieceX])
//
//                    } else if pieceX.groupNumber == nil && piece.groupNumber != nil {
//
//                        pieceX.groupNumber = piece.groupNumber
//                        animation4GroupingPieces(pieces: [piece, pieceX])
//
//                    } else if pieceX.groupNumber != nil && piece.groupNumber != nil {
//
//                        if piece.groupNumber != pieceX.groupNumber {
//
//                            for pieceXX in board.pieces {
//
//                                if pieceXX.groupNumber == pieceX.groupNumber {
//
//                                    pieceX.groupNumber = piece.groupNumber
//                                    animation4GroupingPieces(pieces: [piece, pieceX])
//                                }
//                            }
//                        }
//                    }
//                }
//
//
//
//            }
//        }
//
//    }
    
    func updateLabels() {
        
//        print("update labels called")
        
        for group in board.pieceGroups {
            
            for piece in group.pieces {
                
                
//                piece.view.label.text = "\(group.pieces.count)"
                
                piece.view.label.font = UIFont.boldSystemFont(ofSize: 8.0)
                
                piece.view.label.text = "\(piece.id)" //MARK: Take this out

//                piece.view.label.text = "\(piece.groupNumber)" //MARK: Take this out

                
                
            }
            
            
            
        }
        
        
        
        
    }
    
    func animation4GroupingPieces(pieces: [Piece]) {
        
        for piece in pieces {
            
            
            UIView.animate(withDuration: 0.25) {

                self.delegate?.enlargePiece(view: piece.view)

            } completion: { (true) in

                self.delegate?.shrinkPiece(view: piece.view)
            }
        }
    }
    
//    func addBoardGroups() {
//
//        for number in 0..<groupCount {
//
//            var groupPieces = [Piece]()
//
//            for piece in board.pieces {
//
//                if let groupNum = piece.groupNumber {
//
//                    if groupNum == number + 1 {
//
//                        groupPieces.append(piece)
//                    }
//                }
//            }
//            let group = Group(pieces: groupPieces)
//            group.number = number
//            board.pieceGroups.append(group)
//        }
//    }

    func sortPieces(direction: Direction) {

        switch direction {

        case .up:

            board.pieces.sort { (piece1, piece2) -> Bool in
                (piece1.indexes?.y!)! < (piece2.indexes?.y!)!
            }

        case .down:

            board.pieces.sort { (piece1, piece2) -> Bool in
                (piece1.indexes?.y!)! > (piece2.indexes?.y!)!
            }

        case .left:

            board.pieces.sort { (piece1, piece2) -> Bool in
                (piece1.indexes?.x!)! < (piece2.indexes?.x!)!
            }

        case .right:

            board.pieces.sort { (piece1, piece2) -> Bool in
                (piece1.indexes?.x!)! > (piece2.indexes?.x!)!
            }

        default:
            break
        }
        
//        print(board.pieces.map({$0.indexes!}))
        
    }
    
//    func setNextIndexesX(direction: Direction) {
//
//        for piece in board.pieces {
//
////            piece.blockedByWall = true
//
//            switch direction {
//
//            case .up:
//
//                if piece.indexes?.y! != 0 {
//
//                    piece.nextIndexes = Indexes(x: (piece.indexes?.x)!, y: (piece.indexes?.y)! - 1)
//                    piece.blockedByWall = true
//                } else {
//                    piece.blockedByWall = false
//                }
//
//            case .down:
//
//                if piece.indexes?.y! != board.heightSpaces - 1 {
//
//                    piece.nextIndexes = Indexes(x: (piece.indexes?.x)!, y: (piece.indexes?.y)! + 1)
//                    piece.blockedByWall = true
//
//                } else {
//                    piece.blockedByWall = false
//                }
//
//            case .left:
//
//                if piece.indexes?.x! != 0 {
//
//                    piece.nextIndexes = Indexes(x: (piece.indexes?.x)! - 1, y: (piece.indexes?.y)!)
//                    piece.blockedByWall = true
//
//                } else {
//                    piece.blockedByWall = false
//                }
//
//            case .right:
//
//                if piece.indexes?.x! != board.widthSpaces - 1 {
//
//                    piece.nextIndexes = Indexes(x: (piece.indexes?.x)! + 1, y: (piece.indexes?.y)!)
//                    piece.blockedByWall = true
//
//                } else {
//                    piece.blockedByWall = false
//                }
//
//            default:
//
//                break
//            }
//        }
//    }
    
    
    func setNextIndexes(direction: Direction) {
       
        for piece in board.pieces {
            
            piece.canMoveOneSpace = true
            
//            piece.blockedByWall = true
            
            switch direction {
                
            case .up:
                
                if piece.indexes?.y! != 0 {
                    
                    piece.nextIndexes = Indexes(x: (piece.indexes?.x)!, y: (piece.indexes?.y)! - 1)
//                    piece.canMoveOneSpace = true
                } else {
                    piece.canMoveOneSpace = false
                }
                
            case .down:
                
                if piece.indexes?.y! != board.heightSpaces - 1 {
                    
                    piece.nextIndexes = Indexes(x: (piece.indexes?.x)!, y: (piece.indexes?.y)! + 1)
//                    piece.canMoveOneSpace = true
                    
                } else {
                    piece.canMoveOneSpace = false
                }
                
            case .left:
                
                if piece.indexes?.x! != 0 {
                    
                    piece.nextIndexes = Indexes(x: (piece.indexes?.x)! - 1, y: (piece.indexes?.y)!)
//                    piece.canMoveOneSpace = true
                    
                } else {
                    piece.canMoveOneSpace = false
                }
                
            case .right:
                
                if piece.indexes?.x! != board.widthSpaces - 1 {
                    
                    piece.nextIndexes = Indexes(x: (piece.indexes?.x)! + 1, y: (piece.indexes?.y)!)
//                    piece.canMoveOneSpace = true
                    
                } else {
                    piece.canMoveOneSpace = false
                }
                
            default:
                
                break
            }
        }
    }
    
    
    func setIndexes(direction: Direction) {
        
        //MARK: Set other directions
        
        switch direction{
            
        case .up:
            
            for piece in board.pieces {
                
                if piece.indexes?.y != 0 {
                    
                    
                    piece.previousIndex = piece.indexes
                    piece.nextIndexes = Indexes(x: (piece.indexes?.x!)! , y: (piece.indexes?.y)! - 1)
                    
                    
                    if board.locationAndIDs[piece.nextIndexes!] == nil {
                        board.locationAndIDs[piece.nextIndexes!] = piece.id
                        board.locationAndIDs[piece.indexes!] = nil
                    } else {

                        piece.canMoveOneSpace = false

                    }
                    
                } else {
                    piece.canMoveOneSpace = false
                }

            }
        case .down:
            
            for piece in board.pieces {
                
                if piece.indexes?.y != board.heightSpaces - 1 {
                    
                    
                    piece.previousIndex = piece.indexes
                    piece.nextIndexes = Indexes(x: (piece.indexes?.x!)! , y: (piece.indexes?.y)! + 1)
                    
                    
                    if board.locationAndIDs[piece.nextIndexes!] == nil {
                        board.locationAndIDs[piece.nextIndexes!] = piece.id
                        board.locationAndIDs[piece.indexes!] = nil
                    } else {

                        piece.canMoveOneSpace = false

                    }
                    
                }  else {
                    piece.canMoveOneSpace = false
                }

            }
            
        case .left:
            

            for piece in board.pieces {
                
                if piece.indexes?.x != 0 {
                    
                    
                    piece.previousIndex = piece.indexes
                    piece.nextIndexes = Indexes(x: (piece.indexes?.x!)! - 1, y: piece.indexes?.y)
                    
                    
                    if board.locationAndIDs[piece.nextIndexes!] == nil {
                        board.locationAndIDs[piece.nextIndexes!] = piece.id
                        board.locationAndIDs[piece.indexes!] = nil
                    } else {

                        piece.canMoveOneSpace = false

                    }
                    
                }  else {
                    piece.canMoveOneSpace = false
                }

            }
            
        case .right:

            
        for piece in board.pieces {
            
            if piece.indexes?.x != board.widthSpaces - 1 {
                
                
                piece.previousIndex = piece.indexes
                piece.nextIndexes = Indexes(x: (piece.indexes?.x!)! + 1, y: piece.indexes?.y)
                
                
                if board.locationAndIDs[piece.nextIndexes!] == nil {
                    board.locationAndIDs[piece.nextIndexes!] = piece.id
                    board.locationAndIDs[piece.indexes!] = nil
                } else {

                    piece.canMoveOneSpace = false

                }
                
            } else {
                piece.canMoveOneSpace = false
            }

        }
            
            
        default:
            
            
            break
            
            
        }
        
    }

    
    
    func checkForDuplicatesX(direction: Direction) {
        
        //MARK: May need to make this have recursion
        
        
//        for pieceX in board.pieces {
//
//            for pieceY in board.pieces {
//
//                if pieceX.nextIndexes == pieceY.indexes && pieceX.id != pieceY.id && pieceY.canMoveOneSpace == false{
//
//                    if pieceX.canMoveOneSpace == true {
//                        pieceX.canMoveOneSpace = false
//
//                        print("PIECE X is \(pieceX.id)")
//
//                        print("PIECE Y is \(pieceY.id)")
//
//                    }
//                }
//            }
//        }
        
        for group in board.pieceGroups {
            
            var groupCanMove = true
            
            for pieceX in group.pieces {
                
                if pieceX.canMoveOneSpace == false {
                    groupCanMove = false
                }
                
            }
            
            if groupCanMove == false {
                
                for piece in group.pieces {
                    
                    piece.canMoveOneSpace = false
                }
                
            }
            
            
        }
        
        
        
    }
    
    func checkForDuplicates(direction: Direction) {
        
//        printVisualDisplay(type: "canMove")
        
        
        for piece in board.pieces {

            for pieceQ in board.pieces {

                if pieceQ.nextIndexes == piece.indexes && pieceQ.id != piece.id {

                    print("We have 2 pieces in \(piece.indexes)")
                    print("the correct piece to be here is \(board.locationAndIDs[piece.indexes!])")

                    print("We have 2 pieces in \(pieceQ.indexes)")
                    print("the correct piece to be here is \(board.locationAndIDs[pieceQ.nextIndexes!])")


                    if board.locationAndIDs[piece.nextIndexes!] == piece.id {

                        for pieceR in board.pieces {

                            if pieceR.indexes == piece.indexes && pieceR.id != piece.id {

                                for pieceG in returnGroup(groupNumber: pieceR.groupNumber).pieces {
                                    print("A")
                                    print(pieceG.canMoveOneSpace)
                                    print(pieceG.id)
                                    print(pieceG.previousIndex)
                                    print(pieceG.indexes)
                                    print(pieceG.nextIndexes)

                                    pieceG.indexes = pieceG.previousIndex


                                    pieceG.canMoveOneSpace = false
    //                                pieceG.indexes = pieceG.previousIndex
                                }


                            }
                        }



                        //MARK UP THAT THIS ENTIRE GROUP MUST MOVE BACK

                    } else {

                        for pieceW in returnGroup(groupNumber: piece.groupNumber).pieces {
                            print("B")
                            print(pieceW.canMoveOneSpace)

                            print(pieceW.id)
                            print(pieceW.previousIndex)
                            print(pieceW.indexes)
                            print(pieceW.nextIndexes)



                            
                            pieceW.canMoveOneSpace = false
    //                        pieceW.indexes = pieceW.previousIndex
                        }


                        //MARK UP THAT THIS ENTIRE GROUP MUST MOVE BACK

                    }


                }


            }

        }

    }
    
    func checkGroup(direction: Direction) {
        
        print("Check Group Called")
        
        for group in board.pieceGroups {
            
            print("Group number \(group.id)")
            
            var canMove = true
            
            for piece in group.pieces {
                
                if piece.canMoveOneSpace == false {
                    
                    canMove = false
                    
                    
                    
                }
            }
            
            if canMove == true {
                
                for pieceX in group.pieces {
                    
                    print("\(pieceX.id) was \(pieceX.indexes)")
                    
                    
                    //MARK: Uncomment to not have pieces slide like before
//                    pieceX.indexes = pieceX.nextIndexes
                    
                    print("\(pieceX.id) is now \(pieceX.indexes)")

//                    pieceX.canMoveOneSpace = true
                }
            } else {
                
                for pieceX in group.pieces {
                    
                    pieceX.canMoveOneSpace = false
//                    pieceX.indexes = pieceX.previousIndex
                    
                }
            }
        }
    }
    
    func checkGroup2(direction: Direction) {
        
        for group in board.pieceGroups {
            
            for piece in group.pieces {
                
                if board.locationAndIDs[piece.nextIndexes!] == piece.id {
                    
                    print("Piece \(piece.id) is able to move because the piece in front is its ID")
                    
//                    piece.indexes = piece.nextIndexes
//                    piece.canMoveOneSpace = true
                    
                } else {
                    
                    print("Piece \(piece.id) is not able to move because the piece in front is not its ID")
                    
                    for piece in returnGroup(groupNumber: piece.groupNumber).pieces {
                        
                        piece.canMoveOneSpace = false
//                        piece.indexes = piece.previousIndex
                        
                        
                    }

                }
                
                
            }
            
            
            
        }
        
        
        
    }
    
    func checkSpaceAhead(direction: Direction) {
        
        //MARK: Need to set for all directions. This is only right direction
        
        
        for piece in board.pieces.sorted(by: { (piece1, piece2) in
            (piece1.indexes?.x!)! > (piece2.indexes?.x!)!
        }) {
            if board.locationAndIDs[piece.nextIndexes!] == piece.id {
                
                print("ITS TRUE")
                
//                piece.canMoveOneSpace = true
//                piece.indexes = piece.nextIndexes
                
            } else {
                print("ITS NOT TRUE")

                piece.canMoveOneSpace = false
//                piece.indexes = piece.previousIndex

            }
            
            
        }
        
        
        
//        for piece in board.pieces.sorted(by: { (piece1, piece2) in
//            (piece1.indexes?.x!)! > (piece2.indexes?.x!)!
//        }) {
//
//            if board.pieces.contains(where: { (p1) in
//                p1.indexes == piece.indexes && p1.id != piece.id
//            }) {
//
//                for p2 in board.pieces.sorted(by: { (piece1, piece2) in
//                    (piece1.indexes?.x!)! > (piece2.indexes?.x!)!
//                }) {
//
//                    if p2.indexes == piece.indexes && p2.id != piece.id {
//
////                        print(" p2.previousIndex \(p2.previousIndex)")
////                        print(" p2.id \(p2.id)")
////                        print(" piece.previousIndex \(piece.previousIndex)")
////                        print(" piece.id \(piece.id)")
//                        if board.locationAndIDs[piece.indexes!] == piece.id {
//
//                            p2.indexes = p2.previousIndex
//                            p2.previousIndex = Indexes(x: (p2.indexes?.x!)! + 1, y: p2.indexes?.y)
//
//                            p2.canMoveOneSpace = false
//
//                            print("1piece.id with id of \(piece.id) is the proper piece")
//
//                        } else if board.locationAndIDs[piece.indexes!] == p2.id {
//
//                            piece.indexes = piece.previousIndex
//                            piece.previousIndex = Indexes(x: (piece.indexes?.x!)! + 1, y: piece.indexes?.y)
//
////                            piece.nextIndexes = piece.indexes
//
//                            piece.canMoveOneSpace = false
//                            print("2piece.id with id of \(p2.id) is the proper piece")
//                        }
//
//                    }
//
//                }
//            }
//
//
//        }
//        for groupX in board.pieceGroups {
//
//
//            for pieceX in groupX.pieces {
//
//                if board.pieces.contains(where: { (pieceABC) in
//                    pieceABC.indexes == pieceX.indexes && pieceABC.id != pieceX.id
//                }) {
//
//
//
//
//                }
//
//
//
//            }
//
//
//        }
        
    }
    
    
    
    func checkIfGroupCanMove(direction: Direction) {
        
        print("")

        print("Here We Go")
        
        
        
        
        
        switch direction{
            
            
            
        case .up:
            
            for piece in board.pieces.sorted(by: { (piece1, piece2) in
                (piece1.indexes?.y!)! < (piece2.indexes?.y!)!
            }) {
                
                print("PIECE ID = \(piece.id)")
                print("PIECE prev Index = \(piece.previousIndex)")
                print("PIECE Current Index = \(piece.indexes)")
                print("PIECE next Index = \(piece.nextIndexes)")

                
                if piece.canMoveOneSpace == true {
                    
                    if board.locationAndIDs[piece.nextIndexes!] == nil {
                        
                        print("Board does not show anything infront")

                        
//                        if piece.canMoveOneSpace == true {
                            
                            print("Since there is not a wall infront of the piece, we will move it one")
                            
                            
                            
                            board.locationAndIDs[piece.nextIndexes!] = piece.id
                            board.locationAndIDs[piece.indexes!] = nil
                            
                            board.idsAndLocations[piece.id] = piece.nextIndexes!
                            piece.previousIndex = piece.indexes
                            piece.indexes = piece.nextIndexes
                            piece.nextIndexes = nil
                            
                            if !groupsThatHaveMoved.contains(where: { (int) in
                                int == piece.groupNumber
                            }) {
                                groupsThatHaveMoved.append(piece.groupNumber)
                            }
//                        }
                        
                    } else {
                        
                        board.locationAndIDs[piece.indexes!] = piece.id
                        
                        board.idsAndLocations[piece.id] = piece.indexes!
//                        piece.previousIndex = piece.indexes
//                        piece.indexes = piece.nextIndexes
//                        piece.nextIndexes = nil
                        
                        if !groupsThatHaveMoved.contains(where: { (int) in
                            int == piece.groupNumber
                        }) {
                            groupsThatHaveMoved.append(piece.groupNumber)
                        }
                        
                        
                        piece.canMoveOneSpace = false
                    }
                }
            }
            
        case .down:
            
            for piece in board.pieces.sorted(by: { (piece1, piece2) in
                (piece1.indexes?.y!)! > (piece2.indexes?.y!)!
            }) {
                
                if piece.canMoveOneSpace == true {
                    
                    if board.locationAndIDs[piece.nextIndexes!] == nil {
                        
//                        if piece.canMoveOneSpace == true {
                            
                            board.locationAndIDs[piece.nextIndexes!] = piece.id
                            board.locationAndIDs[piece.indexes!] = nil
                            
                            board.idsAndLocations[piece.id] = piece.nextIndexes!
                            piece.previousIndex = piece.indexes
                            piece.indexes = piece.nextIndexes
                            piece.nextIndexes = nil
                            
                            if !groupsThatHaveMoved.contains(where: { (int) in
                                int == piece.groupNumber
                            }) {
                                groupsThatHaveMoved.append(piece.groupNumber)
                            }
//                        }
                        
                    } else {
                        
                        board.locationAndIDs[piece.indexes!] = piece.id
                        
                        board.idsAndLocations[piece.id] = piece.indexes!
//                        piece.previousIndex = piece.indexes
//                        piece.indexes = piece.nextIndexes
//                        piece.nextIndexes = nil
                        
                        if !groupsThatHaveMoved.contains(where: { (int) in
                            int == piece.groupNumber
                        }) {
                            groupsThatHaveMoved.append(piece.groupNumber)
                        }
                        
                        piece.canMoveOneSpace = false
                    }
                }
            }
            
        case .left:
            
            for piece in board.pieces.sorted(by: { (piece1, piece2) in
                (piece1.indexes?.x!)! < (piece2.indexes?.x!)!
            }) {
                
                if piece.canMoveOneSpace == true {
                    
                    if board.locationAndIDs[piece.nextIndexes!] == nil {
                        
//                        if piece.canMoveOneSpace == true {
                            
                            board.locationAndIDs[piece.nextIndexes!] = piece.id
                            board.locationAndIDs[piece.indexes!] = nil
                            
                            board.idsAndLocations[piece.id] = piece.nextIndexes!
                            piece.previousIndex = piece.indexes
                            piece.indexes = piece.nextIndexes
                            piece.nextIndexes = nil
                            
                            if !groupsThatHaveMoved.contains(where: { (int) in
                                int == piece.groupNumber
                            }) {
                                groupsThatHaveMoved.append(piece.groupNumber)
                            }
//                        }
                        
                    } else {
                        
                        board.locationAndIDs[piece.indexes!] = piece.id
                        
                        board.idsAndLocations[piece.id] = piece.indexes!
//                        piece.previousIndex = piece.indexes
//                        piece.indexes = piece.nextIndexes
//                        piece.nextIndexes = nil
                        
                        if !groupsThatHaveMoved.contains(where: { (int) in
                            int == piece.groupNumber
                        }) {
                            groupsThatHaveMoved.append(piece.groupNumber)
                        }
                        
                        piece.canMoveOneSpace = false
                    }
                }
            }
            
            
        case .right:
            
            for piece in board.pieces.sorted(by: { (piece1, piece2) in
                (piece1.indexes?.x!)! > (piece2.indexes?.x!)!
            }) {
                
                if piece.canMoveOneSpace == true {
                    
                    if board.locationAndIDs[piece.nextIndexes!] == nil {
                        
//                        if piece.canMoveOneSpace == true {
                            
                            board.locationAndIDs[piece.nextIndexes!] = piece.id
                            board.locationAndIDs[piece.indexes!] = nil
                            
                            board.idsAndLocations[piece.id] = piece.nextIndexes!
                            piece.previousIndex = piece.indexes
                            piece.indexes = piece.nextIndexes
                            piece.nextIndexes = nil
                            
                            if !groupsThatHaveMoved.contains(where: { (int) in
                                int == piece.groupNumber
                            }) {
                                groupsThatHaveMoved.append(piece.groupNumber)
                            }
//                        }
                        
                    } else {
                        
//                        board.locationAndIDs[piece.nextIndexes!] = piece.id
                        board.locationAndIDs[piece.indexes!] = piece.id
                        
                        board.idsAndLocations[piece.id] = piece.indexes!
//                        piece.previousIndex = piece.indexes
//                        piece.indexes = piece.nextIndexes
//                        piece.nextIndexes = nil
                        
                        if !groupsThatHaveMoved.contains(where: { (int) in
                            int == piece.groupNumber
                        }) {
                            groupsThatHaveMoved.append(piece.groupNumber)
                        }
                        piece.canMoveOneSpace = false
                    }
                }
            }
            
            
            
            
        default:
            
            
            break
            
            
            
            
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    
    
    func stopGroupIfAllPiecesCantMoveX(direction: Direction) {
        
        print("Groups that have moved \(groupsThatHaveMoved)")
        
        
        for groupX in board.pieceGroups {
            
            
            for pieces in groupX.pieces {
                
//                if piece
                
                
                
                
                
            }
            
            
            
            
            
            
            if groupX.pieces.contains(where: { pieceXXX in
                pieceXXX.canMoveOneSpace == false
            }) {
                
                for piece in groupX.pieces {
                    
                    print("Can Move piece.id = \(piece.id)")
                    
                    if piece.canMoveOneSpace {
                        
                        piece.canMoveOneSpace = false
                        
                        
//                        board.locationAndIDs[piece.previousIndex!] = piece.id
////                        board.locationAndIDs[piece.indexes!] = nil
//
//                        board.idsAndLocations[piece.id] = piece.previousIndex!
//
//
//
//                        piece.indexes = piece.previousIndex
//                        piece.previousIndex = nil
                        
                        
                        
                    }
                    
                    
                }
                
                
            } else {
                
//                print("Cant Move piece.id = \(piece.id)")

                for piece in groupX.pieces {
                    print("Addiing \(piece.id)")
                    piecesToMoveBack.append(piece.id)
                }
            }
            
            
        }
        
    }
        
        
    func stopGroupIfAllPiecesCantMove(direction: Direction) {
        
        for groupX in board.pieceGroups {
            
            if groupX.pieces.count > 1 {
                
                //                print("Group \(groupX.id)")
                
                var trueX = false
                var falseX = false
                
                for piece in groupX.pieces {
                    
                                        print("Piece \(piece.id)")
                    
                    if piece.canMoveOneSpace == true {
                                                print("True equals True")
                        trueX = true
                    }
                    if piece.canMoveOneSpace == false {
                                                print("False equals True")
                        
                        falseX = true
                    }
                    
                }
                
                if trueX == true && falseX == true {
                    
                    print("Its true that in one group a piece moved and a piece didnt move. Group number \(groupX.id)")
                    
                    
                    
                    switch direction {
                        
                    case .up:
                        
                        
                        
                        
                        for piece in groupX.pieces.sorted(by: { (piece1, piece2) in
                            (piece1.indexes?.y!)! > (piece2.indexes?.y!)!
                        }) {
                            
                            print("PIECE NUMBER = \(piece.id)")
                            
                            if piece.canMoveOneSpace == true {
                                
                                
                                //Move it back
                                
                                
                                board.locationAndIDs[piece.previousIndex!] = piece.id
                                board.locationAndIDs[piece.indexes!] = nil
                                
                                board.idsAndLocations[piece.id] = piece.previousIndex!
                                //                        piece.previousIndex = piece.indexes
                                piece.indexes = piece.previousIndex
                                piece.previousIndex = nil
                                
                                groupsThatHaveMoved.removeAll { (int) in
                                    int == piece.groupNumber
                                }
                                //                        groupsThatHaveMovedBack.append(piece.groupNumber)
                                
                                if !groupsThatHaveMovedBack.contains(where: { (int) in
                                    int == piece.groupNumber
                                }) {
                                    groupsThatHaveMovedBack.append(piece.groupNumber)
                                }
                                
                            } else {

                                //MARK: STILL NEED TO SET THE LOCATIONS THAT THE PIECES ARE IN EVENTHOUGH THEY

                                print("HERE IS AN ISSUE")

                            }
                        }
                        
                    case .down:
                                                
                        
                        for piece in groupX.pieces.sorted(by: { (piece1, piece2) in
                            (piece1.indexes?.y!)! < (piece2.indexes?.y!)!
                        }) {
                            
//                            print("PIECE NUMBER = \(piece.id)")
                            
                            if piece.canMoveOneSpace == true {
                                

                                //Move it back
                                
                                
                                board.locationAndIDs[piece.previousIndex!] = piece.id
                                board.locationAndIDs[piece.indexes!] = nil
                                
                                board.idsAndLocations[piece.id] = piece.previousIndex!
                                //                        piece.previousIndex = piece.indexes
                                piece.indexes = piece.previousIndex
                                piece.previousIndex = nil
                                
                                groupsThatHaveMoved.removeAll { (int) in
                                    int == piece.groupNumber
                                }
                                //                        groupsThatHaveMovedBack.append(piece.groupNumber)
                                
                                if !groupsThatHaveMovedBack.contains(where: { (int) in
                                    int == piece.groupNumber
                                }) {
                                    groupsThatHaveMovedBack.append(piece.groupNumber)
                                }
                                
                            } else {
                                
                                //MARK: STILL NEED TO SET THE LOCATIONS THAT THE PIECES ARE IN EVENTHOUGH THEY
     
                                
                                
                            }
                        }
                        
                    case .left:
                        
                        
                        
                        for piece in groupX.pieces.sorted(by: { (piece1, piece2) in
                            (piece1.indexes?.x!)! > (piece2.indexes?.x!)!
                        }) {
                            
//                            print("PIECE NUMBER = \(piece.id)")
                            
                            if piece.canMoveOneSpace == true {
                                

                                //Move it back
                                
                                
                                board.locationAndIDs[piece.previousIndex!] = piece.id
                                board.locationAndIDs[piece.indexes!] = nil
                                
                                board.idsAndLocations[piece.id] = piece.previousIndex!
                                //                        piece.previousIndex = piece.indexes
                                piece.indexes = piece.previousIndex
                                piece.previousIndex = nil
                                
                                groupsThatHaveMoved.removeAll { (int) in
                                    int == piece.groupNumber
                                }
                                //                        groupsThatHaveMovedBack.append(piece.groupNumber)
                                
                                if !groupsThatHaveMovedBack.contains(where: { (int) in
                                    int == piece.groupNumber
                                }) {
                                    groupsThatHaveMovedBack.append(piece.groupNumber)
                                }
                                
                            } else {
                                
                                //MARK: STILL NEED TO SET THE LOCATIONS THAT THE PIECES ARE IN EVENTHOUGH THEY
     
                                
                                
                            }
                        }
                        
                    case .right:
                                                
                        
                        for piece in groupX.pieces.sorted(by: { (piece1, piece2) in
                            (piece1.indexes?.x!)! < (piece2.indexes?.x!)!
                        }) {
                            
//                            print("PIECE NUMBER = \(piece.id)")
                            
                            if piece.canMoveOneSpace == true {
                                

                                //Move it back
                                
                                
                                board.locationAndIDs[piece.previousIndex!] = piece.id
                                board.locationAndIDs[piece.indexes!] = nil
                                
                                board.idsAndLocations[piece.id] = piece.previousIndex!
                                //                        piece.previousIndex = piece.indexes
                                piece.indexes = piece.previousIndex
                                piece.previousIndex = nil
                                
                                groupsThatHaveMoved.removeAll { (int) in
                                    int == piece.groupNumber
                                }
                                //                        groupsThatHaveMovedBack.append(piece.groupNumber)
                                
                                if !groupsThatHaveMovedBack.contains(where: { (int) in
                                    int == piece.groupNumber
                                }) {
                                    groupsThatHaveMovedBack.append(piece.groupNumber)
                                }
                                
                            } else {
                                
                                //MARK: STILL NEED TO SET THE LOCATIONS THAT THE PIECES ARE IN EVENTHOUGH THEY
     
                                
                                
                            }
                        }
                        
                    default:
                        
                        break
                        
                        
                    }
                    
                    
                }
            } else if groupX.pieces.count == 1 {
                
                
                print("NEED TO ACCOUNT FOR A SINGLE PIECE HERE")
                
            }
            
            
        }
        
        
        
    }
    
    func accountForSinglePieceGroups(direction: Direction) {
        
        for groupX in board.pieceGroups {
            
            if groupX.pieces.count == 1 {
                
                
                for piece in groupX.pieces {
                    
                    if board.locationAndIDs[piece.indexes!] != piece.id {
                        
                        print("WE NEED TO MOVE PIECE \(piece.id) BACK")
                        print("Piece NextIndexes \(piece.nextIndexes)")
                        print("Piece Indexes \(piece.indexes)")
                        print("Piece PrevIndexes \(piece.previousIndex)")
                        
                        piece.canMoveOneSpace = true
//                        piece.indexes = Indexes(x: (piece.indexes?.x!)! - 1, y: piece.indexes?.y!)
                        groupsThatHaveMovedBack.append(piece.groupNumber)
                        
                    }
                    
                    
                }
                
                
            }
            
            
            
        }
        
        
        
    }
    
    
    func moveGroupsBack(direction: Direction) {
        
        
//        accountForSinglePieceGroups(direction: direction)
        
        var newGroupsThatHaveMovedBack = [Int]()
        
        for int in groupsThatHaveMovedBack { //THIS DOESNT INCLUDE GROUPS WITH SINGLE PIECES
            
            print("Group number \(int)")
            
            for pieceX in returnGroup(groupNumber: int).pieces {
                
                
                if board.pieces.contains(where: { (piece1) in
                    piece1.indexes == pieceX.indexes && piece1.groupNumber != pieceX.groupNumber
                }) {
                    
                    
                    print()
                    print("HERE is where there are 2 pieces on top of eachother \(pieceX.id)")
                    
                    for pieceXX in returnPiecesFromIndex(indexes: pieceX.indexes!) {
                        
                        if pieceXX.id != pieceX.id {
                            
                            
//                            print("MOVE PIECE WITH PIECE ID OF \(pieceX.id) BACK")
//
//                            print("Piece NextIndexes \(pieceX.nextIndexes)")
//                            print("Piece Indexes \(pieceX.indexes)")
//                            print("Piece PrevIndexes \(pieceX.previousIndex)")

                            
                            if pieceX.nextIndexes != nil {
                                
                                if !newGroupsThatHaveMovedBack.contains(where: { (intXXX) in
                                    intXXX == pieceX.groupNumber
                                }) {
                                    
                                    newGroupsThatHaveMovedBack.append(pieceX.groupNumber)
                                    
                                }
                                
                                
                            }
                            
                            
                        }
                    }
                }
            }
        }
        
        groupsThatHaveMovedBack = newGroupsThatHaveMovedBack
        
        for int in newGroupsThatHaveMovedBack {

            for pieceXXX in returnGroup(groupNumber: int).pieces {

//                print("HI")
//                print(pieceXXX.id)
//                print(pieceXXX.previousIndex)
//                print(pieceXXX.indexes)
//                print(pieceXXX.nextIndexes)

                
                switch direction{
                    
                    
                case .up:
                    
                    if pieceXXX.previousIndex == nil {
                        
                        pieceXXX.indexes = Indexes(x: (pieceXXX.indexes?.x!)!, y: (pieceXXX.indexes?.y!)! + 1)
                        
                    } else {
                        
                        pieceXXX.canMoveOneSpace = true
    //
                        pieceXXX.indexes = pieceXXX.previousIndex
                        
                    }
                    
                    
                    
                case .down:
                    
                    if pieceXXX.previousIndex == nil {
                        
                        pieceXXX.indexes = Indexes(x: (pieceXXX.indexes?.x!)!, y: (pieceXXX.indexes?.y!)! - 1)
                        
                    } else {
                        
                        pieceXXX.canMoveOneSpace = true
    //
                        pieceXXX.indexes = pieceXXX.previousIndex
                        
                    }
                    
                    
                    
                case .left:
                    
                    if pieceXXX.previousIndex == nil {
                        
                        pieceXXX.indexes = Indexes(x: (pieceXXX.indexes?.x!)! + 1, y: pieceXXX.indexes?.y!)
                        
                    } else {
                        
                        pieceXXX.canMoveOneSpace = true
    //
                        pieceXXX.indexes = pieceXXX.previousIndex
                        
                    }
                    
                    
                    
                case .right:
                    
                    if pieceXXX.previousIndex == nil {
                        
                        pieceXXX.canMoveOneSpace = true

                        pieceXXX.indexes = Indexes(x: (pieceXXX.indexes?.x!)! - 1, y: pieceXXX.indexes?.y!)
                        
                    } else {
                        
                        pieceXXX.canMoveOneSpace = true
    //
                        pieceXXX.indexes = pieceXXX.previousIndex
                        
                    }
                    
                    
                default:
                    
                    break
                }
                
                
                
                
                
                
                
                
//                pieceXXX.indexes = pieceXXX.previousIndex
//                pieceXXX.previousIndex = nil

            }
        }
        
        
        
        
        
        
        
//        if !groupsThatHaveMovedBack.isEmpty {
//
//            moveGroupsBack(direction: direction)
//        }
        
        
    }
    
    
    
    func sortGroups(direction: Direction) {
        
        switch direction {
            
        case .up:
            
            
            
            board.pieceGroups = board.pieceGroups.sorted(by: { (group1, group2) in
                group1.pieces.map({($0.indexes?.y)!}).min()! < group2.pieces.map({($0.indexes?.y)!}).min()!
            })

        case .down:
            
            board.pieceGroups = board.pieceGroups.sorted(by: { (group1, group2) in
                group1.pieces.map({($0.indexes?.y)!}).max()! < group2.pieces.map({($0.indexes?.y)!}).max()!
            })
            
        case .left:
            
            board.pieceGroups = board.pieceGroups.sorted(by: { (group1, group2) in
                group1.pieces.map({($0.indexes?.x)!}).min()! < group2.pieces.map({($0.indexes?.x)!}).min()!
            })
            
        case .right:
            
            board.pieceGroups = board.pieceGroups.sorted(by: { (group1, group2) in
                group1.pieces.map({($0.indexes?.x)!}).min()! > group2.pieces.map({($0.indexes?.x)!}).min()!
            })

        default:
            break
        }
        
//        print("sorted groups = \(board.pieceGroups.map({$0.id}))")

    }
    
 
    func resetGame() {
                
//        for piece in board.pieces {
//            delegate?.clearPiecesAnimation(view: piece.view)
//        }
//        board.pieces.removeAll()
    }
}
