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
#import "MRGameData.h"
#import "MRGameViewController.h"
#import "MRRecord.h"

@interface MRGameViewController () <ZLSwipeableViewDataSource, ZLSwipeableViewDelegate>

# pragma -

@property (nonatomic, strong) MRGame *game;
@property (nonatomic) NSUInteger turns;
@property (nonatomic) NSUInteger turnsTaken;

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
# pragma mark Card Properties
@property (weak, nonatomic) IBOutlet UILabel *cardName;
@property (weak, nonatomic) IBOutlet UITextView *cardBody;
@property (weak, nonatomic) IBOutlet UILabel *cardFiles;

- (void)endTurn;

@end

@implementation MRGameViewController

@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    _game = [[MRGame alloc] init];
    _swipeableView.delegate = self;
    [_game populateInputDataStore];
    _turns = [_game.inputData.data count];
    _turnsTaken = 0;

    NSString *input = @"Remaining";
    _inputLabel.text = input;
    [_inputAction setTitle:@"Info" forState:UIControlStateNormal];
    _inputCounter.text = [NSString stringWithFormat:@"%lu", _turns - _turnsTaken];
    
    NSString *outputA = @"Spam";
    NSString *outputB = @"Legit";

    _outputALabel.text = outputA;
    _outputACounter.text = @"0";
    [_outputAAction setTitle:outputA forState:UIControlStateNormal];
    _outputBLabel.text = outputB;
    _outputBCounter.text = @"0";
    [_outputBAction setTitle:outputB forState:UIControlStateNormal];
    
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

// TODO: Pass turn into endTurn function
- (void)endTurn {
    _turnsTaken += 1;
    // TODO: update game data store based on turn
    if (_turnsTaken == _turns) {
        [self.delegate gameViewController:self didCompleteGame:_game.record];
        [self dismiss];
    }
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - View Actions

- (IBAction)swipeRight:(id)sender {
    [_swipeableView swipeTopViewToRight];
    [self endTurn];
}

- (IBAction)swipeLeft:(id)sender {
    [_swipeableView swipeTopViewToLeft];
    [self endTurn];
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
    
    // test the base case where the input data store is empty
    if ([_game.inputData.data count] < 1) {
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
    
    UIView *contentView =
    [[[NSBundle mainBundle] loadNibNamed:@"CardContentView"
                                   owner:self
                                 options:nil] objectAtIndex:0];
    contentView.translatesAutoresizingMaskIntoConstraints = NO;
    
    /* Pop data from input store and apply to card */
    MRGameData *data = [_game.inputData popData];
    _cardName.text = data.name;
    _cardBody.text = data.body;
    _cardFiles.text = [NSString stringWithFormat:@"%li Files", [data.files count]];
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
    [self endTurn];
}

@end
