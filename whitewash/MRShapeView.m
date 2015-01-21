//
//  MRShapeView.m
//  Whitewash
//
//  Created by Allan Lasser on 1/21/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import "MRGameView.h"
#import "MRShapeView.h"

#define SHAPE_HEIGHT 84.0
#define SHAPE_WIDTH  300.0

@implementation MRShapeView

- (instancetype)initWithFrame:(CGRect)frame {
    float red = (arc4random() % 100) / 100.0;
    float green = (arc4random() % 100) / 100.0;
    float blue = (arc4random() % 100) / 100.0;
    UIColor *randomColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    self = [self initWithFrame:frame andColor:randomColor];
    return self;
}

// Designated initializer
- (instancetype)initWithFrame:(CGRect)frame andColor:(UIColor *)color {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = color;
        
        // Give the view a face
        UIImageView *face = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"face"]];
        face.center = CGPointMake(self.center.x - 10, self.center.y - 50);
        [self addSubview:face];
        
        
        
        // Register a swipe gesture on the view
        UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(deleteShape:)];
        [self addGestureRecognizer:swipeRecognizer];
        
        // Register a pan gesture on the view
        UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveShape:)];
        [panRecognizer requireGestureRecognizerToFail:swipeRecognizer];
        [self addGestureRecognizer:panRecognizer];
    }
    return self;
}

- (void)moveShape:(UIPanGestureRecognizer *)gr {
    MRGameView *superview = (MRGameView *)[self superview];
    NSMutableArray *snapPoints = [superview snapPoints];
    // When the pan recognizer changes its position:
    if (gr.state == UIGestureRecognizerStateChanged) {
        // How far has the pan moved?
        CGPoint translation = [gr translationInView:self];
        CGPoint center = self.center;
        // Translate the shape by this point
        center.y += translation.y;
        self.center = center;
        // Tare the translation distance
        [gr setTranslation:CGPointZero inView:self];
    } else if (gr.state == UIGestureRecognizerStateEnded) {
        // Get closest snap point
        CGPoint closestSnapPoint = [self findClosestSnapPoint:self.center fromArray:snapPoints];
        // Set center to snap point
        [UIView animateWithDuration:0.35
                              delay:0.0
             usingSpringWithDamping:0.5
              initialSpringVelocity:1.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{ self.center = closestSnapPoint; }
                         completion:nil];
    }
    // Redraw
    [self setNeedsDisplay];
}

- (void)deleteShape:(UISwipeGestureRecognizer *)gr {
    /* This function isn't quite fully baked yet.
    if (gr.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.5
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{ self.center = CGPointMake(1000.0, self.center.y); }
                         completion:nil];
    }
    */
}

- (CGPoint)findClosestSnapPoint:(CGPoint)point fromArray:(NSArray *)snapPoints {
    CGPoint closestSnapPoint = [[snapPoints firstObject] CGPointValue];
    for (NSValue *snapPointValue in snapPoints) {
        CGPoint snapPoint = [snapPointValue CGPointValue];
        CGFloat thisDistance = sqrt((snapPoint.x - point.x)*(snapPoint.x - point.x) + (snapPoint.y - point.y)*(snapPoint.y - point.y));
        CGFloat closestDistance = sqrt((closestSnapPoint.x - point.x)*(closestSnapPoint.x - point.x) + (closestSnapPoint.y - point.y)*(closestSnapPoint.y - point.y));
        if (thisDistance < closestDistance) {
            closestSnapPoint = snapPoint;
        }
    }
    return closestSnapPoint;
}

@end
