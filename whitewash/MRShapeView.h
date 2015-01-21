//
//  MRShapeView.h
//  Whitewash
//
//  Created by Allan Lasser on 1/21/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRShapeView : UIView

@property (nonatomic) CGPoint currentSnapPoint;

- (void)setSnapPoint:(CGPoint)newPoint;

@end
