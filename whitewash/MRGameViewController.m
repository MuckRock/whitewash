//
//  MRGameViewController.m
//  Whitewash
//
//  Created by Allan Lasser on 3/9/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import <pop/POP.h>
#import <Tweaks/FBTweak.h>
#import <ZLSwipeableView/ZLSwipeableView.h>

#import "FBTweakInline.h"
#import "MRGame.h"
#import "MRGameViewController.h"
#import "MRRecord.h"

@interface MRGameViewController () <ZLSwipeableViewDataSource, ZLSwipeableViewDelegate>

@property (nonatomic, strong) MRGame *game;

#pragma mark View Properties
@property (weak, nonatomic) IBOutlet ZLSwipeableView *swipeableView;
@property (weak, nonatomic) IBOutlet UILabel *inputCounter;
@property (weak, nonatomic) IBOutlet UILabel *inputLabel;
@property (weak, nonatomic) IBOutlet UIButton *inputAction;
@property (weak, nonatomic) IBOutlet UILabel *outputACounter;
@property (weak, nonatomic) IBOutlet UILabel *outputALabel;
@property (weak, nonatomic) IBOutlet UIButton *outputAAction;
@property (weak, nonatomic) IBOutlet UILabel *outputBCounter;
@property (weak, nonatomic) IBOutlet UILabel *outputBLabel;
@property (weak, nonatomic) IBOutlet UIButton *outputBAction;

@end

@implementation MRGameViewController

@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    _game = [[MRGame alloc] init];
    _swipeableView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"Swipeableview will now appear!");
    _swipeableView.isRotationEnabled = FBTweakValue(@"Game",
                                                    @"Cards",
                                                    @"Rotations",
                                                    YES);
    _swipeableView.pushVelocityMagnitude = FBTweakValue(@"Game",
                                                        @"Cards",
                                                        @"Velocity",
                                                        100.0);
}

- (void)viewDidLayoutSubviews {
    _swipeableView.dataSource = self;
}

#pragma mark - Navigation

- (IBAction)dismiss:(id)sender {
    [self.delegate gameViewController:self didCompleteGame:_game.record];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - View Actions

- (IBAction)swipeRight:(id)sender {
    [_swipeableView swipeTopViewToRight];
}

- (IBAction)swipeLeft:(id)sender {
    [_swipeableView swipeTopViewToLeft];
}

#pragma mark - Animations

- (void)addBounce:(UIView *)view {
    CALayer *layer = view.layer;
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.velocity = [NSValue valueWithCGSize:CGSizeMake(30.f, 30.f)];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    scaleAnimation.springBounciness = 15.0f;
    [layer pop_addAnimation:scaleAnimation forKey:@"layerScaleSpringAnimation"];
}
 
#pragma mark - ZLSwipeableViewDataSource

- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView {
    UIView *view = [[UIView alloc] initWithFrame:swipeableView.bounds];
    view.backgroundColor = ([UIColor colorWithRed:0.945
                                            green:0.945
                                             blue:0.945
                                            alpha:1]);
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOpacity = 0.22;
    view.layer.shadowOffset = CGSizeMake(0, 1.5);
    view.layer.shadowRadius = 4.0;
    view.layer.shouldRasterize = YES;
    view.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    view.autoresizesSubviews = NO;

    // Adds contentView XIB to card, taken from: https://github.com/zhxnlai/ZLSwipeableView/blob/master/ZLSwipeableViewDemo/ZLSwipeableViewDemo/ViewController.m#L142-L167
    
    UIView *contentView =
    [[[NSBundle mainBundle] loadNibNamed:@"CardContentView"
                                   owner:self
                                 options:nil] objectAtIndex:0];
    contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview:contentView];
    
    NSDictionary *metrics = @{
                              @"height" : @(view.bounds.size.height),
                              @"width" : @(view.bounds.size.width)
                              };
    NSDictionary *views = NSDictionaryOfVariableBindings(contentView);
    [view addConstraints:
     [NSLayoutConstraint
      constraintsWithVisualFormat:@"H:|[contentView(width)]"
      options:0
      metrics:metrics
      views:views]];
    [view addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:
                          @"V:|[contentView(height)]"
                          options:0
                          metrics:metrics
                          views:views]];
    
    
    return view;
}

#pragma mark - ZLSwipeableViewDelegate

- (void)swipeableView:(ZLSwipeableView *)swipeableView didSwipeLeft:(UIView *)view {
    [_game takeTurn:@"Left"];
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView didSwipeRight:(UIView *)view {
    [_game takeTurn:@"Right"];
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView didCancelSwipe:(UIView *)view {
    NSLog(@"did cancel swipe");
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView didStartSwipingView:(UIView *)view atLocation:(CGPoint)location {
    NSLog(@"did start swiping at location: x %f, y%f", location.x, location.y);
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView swipingView:(UIView *)view atLocation:(CGPoint)location translation:(CGPoint)translation {
    NSLog(@"swiping at location: x %f, y %f, translation: x %f, y %f", location.x, location.y, translation.x, translation.y);
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView didEndSwipingView:(UIView *)view atLocation:(CGPoint)location {
    NSLog(@"did start swiping at location: x %f, y%f", location.x, location.y);
}

@end
