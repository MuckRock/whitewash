//
//  MRGameBoardView.m
//  Whitewash
//
//  Created by Allan Lasser on 1/20/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import "MRGameBoardView.h"
#import "MRGamePieceView.h"

#define NUM_SNAP_POINTS 4.0

typedef enum { up, down } Direction;

@interface MRGameBoardView ()

@property (nonatomic, strong) NSMutableArray *openSnapPoints;
@property (nonatomic, strong) NSMutableArray *pieces;

@end

@implementation MRGameBoardView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        // Create snap points
        [self generateSnapPoints];
        
        _pieces = [[NSMutableArray alloc] init];
        // Create shape to manipulate
        MRGamePieceView *piece = [[MRGamePieceView alloc] initWithFrame:CGRectMake(10, 50, 300, 100)];
        [piece newSnapPoint:[[_snapPoints objectAtIndex:0] CGPointValue]];
        [_pieces addObject:piece];
        [self addSubview:piece];
        
        // Create a second shape
        piece = [[MRGamePieceView alloc] initWithFrame:CGRectMake(10, 50, 300, 100)];
        [piece newSnapPoint:[[_snapPoints objectAtIndex:1] CGPointValue]];
        [_pieces addObject:piece];
        [self addSubview:piece];
        
        // Create a third shape
        piece = [[MRGamePieceView alloc] initWithFrame:CGRectMake(10, 50, 300, 100)];
        [piece newSnapPoint:[[_snapPoints objectAtIndex:2] CGPointValue]];
        [_pieces addObject:piece];
        [self addSubview:piece];
    }
    return self;
}

- (void)generateSnapPoints {
    // Create array of snap points
    _snapPoints = [[NSMutableArray alloc] init];
    CGRect appFrame = [UIScreen mainScreen].applicationFrame;
    CGFloat appFrameHeight = appFrame.size.height;
    CGFloat appFrameHorizontalCenter = appFrame.size.width/2;
    for (int i = 1; i < (NUM_SNAP_POINTS + 1.0); i++) {
        CGPoint snapPoint;
        snapPoint.x = appFrameHorizontalCenter;
        snapPoint.y = appFrameHeight * (i/(NUM_SNAP_POINTS + 1.0));
        [_snapPoints addObject:[NSValue valueWithCGPoint:snapPoint]];
    }
}

- (void)generateOpenSnapPoints {
    _openSnapPoints = [[NSMutableArray alloc] initWithArray:_snapPoints copyItems:YES];
    for (MRGamePieceView *piece in self.subviews) {
        [_openSnapPoints removeObject:[NSValue valueWithCGPoint:piece.currentSnapPoint]];
    }
}

- (BOOL)movePiece:(MRGamePieceView *)piece toPoint:(CGPoint)point {
    return [self movePiece:piece toPoint:point opDepth:0];
}

- (BOOL)movePiece:(MRGamePieceView *)piece toPoint:(CGPoint)point opDepth:(int)counter {

    CGPoint startingPoint = piece.currentSnapPoint;
    piece.currentSnapPoint = CGPointZero;
    MRGamePieceView *otherPiece = [self getPieceAtPoint:point];
    Direction direction, otherDirection;
    if (startingPoint.y > point.y) {
        direction = up;
        otherDirection = down;
    } else {
        direction = down;
        otherDirection = up;
    }

    if (otherPiece == nil) {
        [piece newSnapPoint:point];
        return YES;
    } else {
        BOOL otherPieceDidMove;
        NSValue *nextPointInThisDirection = [self getPointAdjacentTo:point inDirection:direction];
        if (nextPointInThisDirection != nil) {
            otherPieceDidMove = [self movePiece:otherPiece
                                        toPoint:[nextPointInThisDirection CGPointValue]
                                        opDepth:++counter];
            if (!otherPieceDidMove) {
                NSValue *nextPointInOtherDirection = [self getPointAdjacentTo:point inDirection:otherDirection];
                [self movePiece:otherPiece
                        toPoint:[nextPointInOtherDirection CGPointValue]
                        opDepth:++counter];
            }
            [piece newSnapPoint:point];
            return YES;
        } else {
            if (counter == 0) {
                NSValue *nextPointInOtherDirection = [self getPointAdjacentTo:point inDirection:otherDirection];
                [self movePiece:otherPiece
                        toPoint:[nextPointInOtherDirection CGPointValue]
                        opDepth:++counter];
                [piece newSnapPoint:point];
                return YES;
            } else {
                [piece newSnapPoint:startingPoint];
                return NO;
            }
        }
    }
}

- (NSValue *)getPointAdjacentTo:(CGPoint)point inDirection:(Direction)direction {
    NSUInteger i = [_snapPoints indexOfObject:[NSValue valueWithCGPoint:point]];
    if (direction == up && i > 0) { // get previous point
        return (NSValue *)[_snapPoints objectAtIndex:(i-1)];
    } else if (direction == down && i < ([_snapPoints count] - 1)) { // get next point
        return (NSValue *)[_snapPoints objectAtIndex:(i+1)];
    } else {
        return nil;
    }
}

- (MRGamePieceView *)getPieceAtPoint:(CGPoint)point {
    MRGamePieceView *pieceToReturn = nil;
    for (MRGamePieceView *piece in _pieces) {
        if (piece.currentSnapPoint.x == point.x && piece.currentSnapPoint.y == point.y) {
            pieceToReturn = piece;
        }
    }
    return pieceToReturn;
}

@end
