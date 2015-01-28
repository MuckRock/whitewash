//
//  MRGamePieceView.h
//  Whitewash
//
//  Created by Allan Lasser on 1/21/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRGamePieceView : UIView

@property (nonatomic) CGPoint currentSnapPoint;

- (void)newSnapPoint:(CGPoint)newPoint;

@end
