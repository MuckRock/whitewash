//
//  MRGameView.m
//  Whitewash
//
//  Created by Allan Lasser on 1/20/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import "MRGameView.h"

#define RECT_HEIGHT 84.0
#define RECT_WIDTH  300.0

@interface MRGameView ()

@property (nonatomic, strong) UIColor *rectangleColor;
@property (nonatomic, strong) UIView *shape;
@property (nonatomic) CGPoint snapPoint;

@end

@implementation MRGameView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        CGRect appFrame = [UIScreen mainScreen].applicationFrame;
        _snapPoint = CGPointMake(appFrame.size.width/2, appFrame.size.height/2);
        _shape = [[UIView alloc] initWithFrame:CGRectMake(10, 50, 300, 100)];
        _shape.backgroundColor = [UIColor redColor];
        _shape.center = _snapPoint;
        [self addSubview:_shape];
        
        UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveShape:)];
        [self addGestureRecognizer:panRecognizer];
        
    }
    return self;
}

- (void)moveShape:(UIPanGestureRecognizer *)gr {
    // When the pan recognizer changes its position:
    if (gr.state == UIGestureRecognizerStateChanged) {
        // How far has the pan moved?
        CGPoint translation = [gr translationInView:self];
        CGPoint center = _shape.center;
        // Translate the shape by this point
        center.y += translation.y;
        _shape.center = center;
        // Tare the translation distance
        [gr setTranslation:CGPointZero inView:self];
    } else if (gr.state == UIGestureRecognizerStateEnded) {
        // Get closest snap point
        CGPoint closestSnapPoint = _snapPoint;
        // Set center to snap point
        [UIView animateWithDuration:0.5
                              delay:0.0
             usingSpringWithDamping:0.5
              initialSpringVelocity:2.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{ _shape.center = closestSnapPoint; }
                         completion:nil];
    }
    // Redraw
    [self setNeedsDisplay];
}

@end
