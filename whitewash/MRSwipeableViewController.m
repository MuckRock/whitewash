//
//  MRSwipeableViewController.m
//  Whitewash
//
//  Created by Allan Lasser on 2/12/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import "MRSwipeableViewController.h"
#import <pop/POP.h>

#import "FBTweakInline.h"
#import "MRCommunication.h"
#import "MRCommunicationStore.h"
#import "ZLSwipeableView.h"


#define TOKEN ba90eded37a56d5dfc1e8d191fe4e1728ca6ba10

@interface MRSwipeableViewController () <NSURLSessionDataDelegate, ZLSwipeableViewDataSource, ZLSwipeableViewDelegate>

@property (strong, nonatomic) NSMutableArray *communications;
@property (strong, nonatomic) NSMutableArray *spam;
@property (strong, nonatomic) NSMutableArray *legit;
@property (strong, nonatomic) NSMutableDictionary *commViewMapping;
@property (nonatomic) NSUInteger remainingCount; // need remaining count because ZLSwipeableView will pop multiple communications from the array at once
/* NSURLSession */
@property (strong, nonatomic) NSURLSession *session;
/* ZLSwipeableView */
@property (weak, nonatomic) IBOutlet ZLSwipeableView *swipeableView;
/* CardContentView */
@property (weak, nonatomic) IBOutlet UILabel *communicationFrom;
@property (weak, nonatomic) IBOutlet UILabel *communicationAttachmentCount;
@property (weak, nonatomic) IBOutlet UITextView *communicationBody;
@property (weak, nonatomic) IBOutlet UILabel *spamCounter;
@property (weak, nonatomic) IBOutlet UILabel *legitCounter;
@property (weak, nonatomic) IBOutlet UILabel *remainingCounter;

@end

@implementation MRSwipeableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _swipeableView.delegate = self;
    _communications = [[NSMutableArray alloc] init];
    _spam = [[NSMutableArray alloc] init];
    _legit = [[NSMutableArray alloc] init];
    _commViewMapping = [[NSMutableDictionary alloc] init];
    [self fetchCommunications];
    [_communications addObjectsFromArray:[[MRCommunicationStore sharedStore] communications]];
    _remainingCount = [_communications count];
    [self shuffleCommunications:_communications];
    [self updateCounters];
}

- (void)fetchCommunications {
    // Build MRCommunicationStore from API Reqeusts
    // 1. Request a page of communications
    // 2. For each communication:
    //   a. create a MRCommunication object
    //   b. add object to MRCommunicationStore
    NSString *JSONPath = [[NSBundle mainBundle] pathForResource:@"communications" ofType:@"json"];
    NSURL *localJSON = [NSURL fileURLWithPath:JSONPath];
    NSData *data = [NSData dataWithContentsOfURL:localJSON];
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSArray *jsonComms = jsonObject[@"results"];
    // Add comms on page to MRCommunicationStore
    for (NSDictionary *jsonComm in jsonComms) {
        MRCommunication *comm = [[MRCommunication alloc] initFromJSON:jsonComm];
        [[MRCommunicationStore sharedStore] addCommunication:comm];
    }
}

- (void)shuffleCommunications:(NSMutableArray *)communications {
    // for i from n − 1 downto 1 do
    //     j ← random integer with 0 ≤ j ≤ i
    //    exchange a[j] and a[i]
    for (unsigned int i = (unsigned int)[communications count]-1; i > 0; i--) {
        int j = arc4random_uniform((unsigned int)i);
        [communications exchangeObjectAtIndex:i withObjectAtIndex:j];
    }
}

- (void)updateCounters {
    _remainingCounter.text = [NSString stringWithFormat:@"%lu", _remainingCount];
    _spamCounter.text = [NSString stringWithFormat:@"%lu", [_spam count]];
    _legitCounter.text = [NSString stringWithFormat:@"%lu", [_legit count]];
}

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler {
    NSURLCredential *cred = [NSURLCredential credentialWithUser:@"Token" password:@"ba90eded37a56d5dfc1e8d191fe4e1728ca6ba10" persistence:NSURLCredentialPersistenceForSession];
    completionHandler(NSURLSessionAuthChallengeUseCredential, cred);
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"Swipeableview will now appear!");
    _swipeableView.isRotationEnabled = FBTweakValue(@"Swipeable",
                                                    @"Tweaks",
                                                    @"Rotations",
                                                    YES);
}

- (void)viewDidLayoutSubviews {
    // Required Data Source
    _swipeableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)swipeRight:(id)sender {
    [_swipeableView swipeTopViewToRight];
}

- (IBAction)swipeLeft:(id)sender {
    [_swipeableView swipeTopViewToLeft];
}

#pragma mark - ZLSwipeableViewDataSource
- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView {
    if ([_communications count] > 0) {
        // Pop communication from queue
        MRCommunication *comm = _communications[0];
        [_communications removeObjectAtIndex:0];
        
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

        view.tag = [comm.ID integerValue];
        _communicationFrom.text = comm.from;
        _communicationBody.text = comm.message;
        if (comm.attachments > 1 || comm.attachments == 0) {
            _communicationAttachmentCount.text = [NSString stringWithFormat:@"%lu Attachments", comm.attachments];
        } else {
            _communicationAttachmentCount.text = [NSString stringWithFormat:@"%lu Attachment", comm.attachments];
        }
        _communicationBody.font = [UIFont fontWithName:@"Courier New" size:14.0];
        [_commViewMapping setObject:comm forKey:[NSString stringWithFormat:@"%ld", (long)view.tag]];
        
        /* Adds contentView XIB to card, taken from: https://github.com/zhxnlai/ZLSwipeableView/blob/master/ZLSwipeableViewDemo/ZLSwipeableViewDemo/ViewController.m#L142-L167 */
        
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
    } else {
        return nil;
    }
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

#pragma mark - ZLSwipeableViewDelegate
- (void)swipeableView:(ZLSwipeableView *)swipeableView
           didSwipeUp:(UIView *)view {
    NSLog(@"did swipe up");
}
- (void)swipeableView:(ZLSwipeableView *)swipeableView
         didSwipeDown:(UIView *)view {
    NSLog(@"did swipe down");
}
- (void)swipeableView:(ZLSwipeableView *)swipeableView didSwipeLeft:(UIView *)view {
    NSLog(@"did swipe left");
    _remainingCount -= 1;
    MRCommunication *comm = [_commViewMapping objectForKey:[NSString stringWithFormat:@"%ld", (long)view.tag]];
    [_spam addObject:comm];
    [_commViewMapping removeObjectForKey:[NSString stringWithFormat:@"%ld", (long)view.tag]];
    
    [self addBounce:_spamCounter];
    
    [self updateCounters];
}
- (void)swipeableView:(ZLSwipeableView *)swipeableView didSwipeRight:(UIView *)view {
    NSLog(@"did swipe right");
    _remainingCount -= 1;
    MRCommunication *comm = [_commViewMapping objectForKey:[NSString stringWithFormat:@"%ld", (long)view.tag]];
    [_legit addObject:comm];
    [_commViewMapping removeObjectForKey:[NSString stringWithFormat:@"%ld", (long)view.tag]];
    [self addBounce:_legitCounter];
    [self updateCounters];
}
- (void)swipeableView:(ZLSwipeableView *)swipeableView didCancelSwipe:(UIView *)view {
    NSLog(@"did cancel swipe");
}
- (void)swipeableView:(ZLSwipeableView *)swipeableView didStartSwipingView:(UIView *)view atLocation:(CGPoint)location {
    NSLog(@"did start swiping at location: x %f, y%f", location.x, location.y);
}
- (void)swipeableView:(ZLSwipeableView *)swipeableView swipingView:(UIView *)view atLocation:(CGPoint)location  translation:(CGPoint)translation {
    NSLog(@"swiping at location: x %f, y %f, translation: x %f, y %f", location.x, location.y, translation.x, translation.y);
}
- (void)swipeableView:(ZLSwipeableView *)swipeableView didEndSwipingView:(UIView *)view atLocation:(CGPoint)location {
    NSLog(@"did start swiping at location: x %f, y%f", location.x, location.y);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
