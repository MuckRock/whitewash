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
#import "MRGameDispatcher.h"
#import "MRGameViewController.h"

@interface MRGameViewController () <ZLSwipeableViewDataSource, ZLSwipeableViewDelegate>

# pragma -
@property (nonatomic) NSUInteger turns;
@property (nonatomic) NSUInteger turnsTaken;
@property (nonatomic) NSUInteger turnsLeft;
@property (nonatomic) NSUInteger turnsRight;
@property (nonatomic, strong) NSMutableArray *viewDataMapping;
@property (nonatomic) NSUInteger cardsRendered;
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
# pragma mark Private Methods
- (void)updateCounters;
- (void)endGame;

@end

@implementation MRGameViewController {
    enum direction { left, right };
}

@synthesize game;
@synthesize multiplier;
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];

    // 1. Set multiplier
    self.game.ruleset.pointMultiplier = self.multiplier;

    // 2. Set delegate
    self.swipeableView.delegate = self;

    // 3. Set counters
    self.turns = [self.game.store.data count];
    self.turnsTaken = 0;
    self.turnsLeft = 0;
    self.turnsRight = 0;
    self.cardsRendered = 0;

    // 4. Create a mapping between card views and game data
    _viewDataMapping = [[NSMutableArray alloc] init];

    NSString *input = @"Remaining";
    _inputLabel.text = input;
    [_inputAction setTitle:@"Pass" forState:UIControlStateNormal];

    // 5. Set labels based on rules
    NSString *outputA = self.game.ruleset.rules[0];
    _outputALabel.text = outputA;
    [_outputAAction setTitle:outputA forState:UIControlStateNormal];
    NSString *outputB = self.game.ruleset.rules[1];
    _outputBLabel.text = outputB;
    [_outputBAction setTitle:outputB forState:UIControlStateNormal];

    // 6. Update counters
    [self updateCounters];
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

#pragma mark - Animations

- (void)addBounce:(UIView *)view {
    CALayer *layer = view.layer;
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.velocity = [NSValue valueWithCGSize:CGSizeMake(30.f, 30.f)];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    scaleAnimation.springBounciness = 15.0f;
    [layer pop_addAnimation:scaleAnimation forKey:@"layerScaleSpringAnimation"];
}

# pragma mark - Gameplay Handlers

- (void)takeTurn:(enum direction)swipe forView:(UIView *)view {
    // TODO: update game data store based on turn
    BOOL isSpam = NO;
    switch (swipe) {
        case left:
            [self.game takeTurnWithMove:self.game.ruleset.rules[0]];
            _turnsLeft += 1;
            [self addBounce:_outputACounter];
            [self addBounce:_outputAAction];
            isSpam = YES;
            break;
        case right:
            [self.game takeTurnWithMove:self.game.ruleset.rules[1]];
            _turnsRight += 1;
            [self addBounce:_outputBCounter];
            [self addBounce:_outputBAction];
            break;
    }
    _turnsTaken += 1;
    [self updateCounters];
    if (_turnsTaken == _turns) {
        [self endGame];
    }
}

- (void)updateCounters {
    _inputCounter.text = [NSString stringWithFormat:@"%lu", self.turns - self.turnsTaken];
    _outputACounter.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.turnsLeft];
    _outputBCounter.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.turnsRight];
}

- (void)endGame {
    [self.game.store pushData];
    [self.delegate gameViewController:self didCompleteGame:self.game.record];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - View Actions

- (IBAction)swipeRight:(id)sender {
    [_swipeableView swipeTopViewToRight];
}

- (IBAction)swipeLeft:(id)sender {
    [_swipeableView swipeTopViewToLeft];
}

- (IBAction)passTurn:(id)sender {
    [_swipeableView swipeTopViewToUp];
    // taking a turn with a nil move is the same as passing that turn
    [self.game takeTurnWithMove:nil];
}

#pragma mark - ZLSwipeableViewDataSource

- (UIView *)getTutorialCard {
    UIView *card = [[[NSBundle mainBundle] loadNibNamed:@"TutorialCard"
                                                  owner:self
                                                options:nil] objectAtIndex:0];
    card.translatesAutoresizingMaskIntoConstraints = NO;
    return card;
}

- (UIView *)getCard {
    UIView *card = [[[NSBundle mainBundle] loadNibNamed:self.game.ruleset.nibName
                                                  owner:self
                                                options:nil] objectAtIndex:0];
    card.translatesAutoresizingMaskIntoConstraints = NO;
    return card;
}

- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView {

    // test the base case where the input data store is empty
    if ([self.game.store.data count] < 1) {
        return nil;
    }

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

    // If no turns played, render tutorial card. Otherwise, render game card.
    UIView *contentView;
    if (self.cardsRendered == 0) {
        contentView = [self getTutorialCard];
    } else {
        contentView = [self getCard];
    }
    self.cardsRendered += 1;
    [view addSubview:contentView];

    NSDictionary *metrics = @{@"height" : @(view.bounds.size.height),
                              @"width" : @(view.bounds.size.width)};
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

#pragma mark ZLSwipeableViewDelegate

- (void)swipeableView:(ZLSwipeableView *)swipeableView didSwipeLeft:(UIView *)view {
    [self takeTurn:left forView:view];
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView didSwipeRight:(UIView *)view {
    [self takeTurn:right forView:view];
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
