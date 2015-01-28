//
//  MRGameBoardView.h
//  Whitewash
//
//  Created by Allan Lasser on 1/20/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MRGamePieceView.h"

@interface MRGameBoardView : UIView

@property (nonatomic, strong) NSMutableArray *snapPoints;

- (void)generateOpenSnapPoints;
- (BOOL)movePiece:(MRGamePieceView *)piece toPoint:(CGPoint)point;

@end
