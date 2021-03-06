//
//  MRCompletedGameViewController.m
//  Whitewash
//
//  Created by Allan Lasser on 4/2/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import "MRCompletedGameViewController.h"

#import "MRGame.h"
#import "MRGameDataQueue.h"
#import "MRWebStore.h"

@interface MRCompletedGameViewController () <MRGameViewControllerProtocol>

@property (weak, nonatomic) IBOutlet UILabel *formerRequestTitle;
@property (weak, nonatomic) IBOutlet UILabel *formerRequestAgency;
@property (weak, nonatomic) IBOutlet UITextView *formerRequestDescription;
@property (weak, nonatomic) IBOutlet UILabel *latterRequestTitle;
@property (weak, nonatomic) IBOutlet UILabel *latterRequestAgency;
@property (weak, nonatomic) IBOutlet UITextView *latterRequestDescription;

@end

@implementation MRCompletedGameViewController

+ (MRGameViewController *)newGameViewController {
    MRCompletedGameViewController *gvc = [[MRCompletedGameViewController alloc] initWithNibName:@"MRGameViewController" bundle:[NSBundle mainBundle]];
    NSURL *gameURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"completed" ofType:@"json"]];
    MRRuleset *gameRuleset = [MRRuleset rulesetWithRules:@[@"Former", @"Latter"] andNib:@"CompletedCard"];
    gameRuleset.pointsPerTurn = 1;
    gvc.game = [MRGame gameWithURL:gameURL andRuleset:gameRuleset];
    gvc.game.ruleset.pointsPerTurn = 2;
    return gvc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.turns = self.turns/2;
    [super updateCounters];
}

- (UIView *)getTutorialCard {
    UIView *card = [[[NSBundle mainBundle] loadNibNamed:@"CompletedTutorialCard"
                                                  owner:self
                                                options:nil] objectAtIndex:0];
    card.translatesAutoresizingMaskIntoConstraints = NO;
    card.tag = -1;
    return card;
}

- (UIView *)getCard {
    UIView *card = [super getCard];
    // get data from queue and map to game-specific card.
    // in this case, CompletedCard.xib
    MRGameDataQueue *queue = self.game.dataQueue;
    NSDictionary *former = [queue dequeue];
    NSDictionary *latter = [queue dequeue];
    if (former && latter) {
        self.formerRequestTitle.text = [former valueForKey:@"title"];
        self.latterRequestTitle.text = [latter valueForKey:@"title"];
        
        self.formerRequestAgency.text = [NSString stringWithFormat:@"%@", [former valueForKey:@"agency"]];
        self.latterRequestAgency.text = [NSString stringWithFormat:@"%@", [latter valueForKey:@"agency"]];
        
        self.formerRequestDescription.text = [NSString stringWithFormat:@"%@", [former valueForKey:@"description"]];
        self.latterRequestDescription.text = [NSString stringWithFormat:@"%@", [latter valueForKey:@"description"]];
        
    }
    card.tag = [self.game.dataCardMap count];
    [self.game.dataCardMap addObject:@[former, latter]];
    return card;
}

@end
