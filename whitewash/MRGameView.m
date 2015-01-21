//
//  MRGameView.m
//  Whitewash
//
//  Created by Allan Lasser on 1/20/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import "MRGameView.h"
#import "MRShapeView.h"

#define NUM_SNAP_POINTS 4.0

@interface MRGameView ()

@property (nonatomic, strong) NSMutableArray *snapPoints;

@end

@implementation MRGameView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        // Create snap points
        [self generateSnapPoints];

        
        // Create shape to manipulate
        MRShapeView *shape = [[MRShapeView alloc] initWithFrame:CGRectMake(10, 50, 300, 100)];
        [shape setSnapPoint:[[_snapPoints objectAtIndex:0] CGPointValue]];
        [self addSubview:shape];
        
        // Create a second shape
        shape = [[MRShapeView alloc] initWithFrame:CGRectMake(10, 50, 300, 100)];
        [shape setSnapPoint:[[_snapPoints objectAtIndex:1] CGPointValue]];
        [self addSubview:shape];
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
    for (MRShapeView *subview in self.subviews) {
        [_openSnapPoints removeObject:[NSValue valueWithCGPoint:subview.currentSnapPoint]];
    }
}

@end
