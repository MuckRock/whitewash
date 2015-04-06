//
//  MRSpamGameViewController.m
//  Whitewash
//
//  Created by Allan Lasser on 4/2/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import "MRSpamGameViewController.h"

#import "MRGame.h"
#import "MRGameDataQueue.h"
#import "MRWebStore.h"

@interface MRSpamGameViewController () <MRGameViewControllerProtocol>
@property (weak, nonatomic) IBOutlet UILabel *orphanSubject;

@end

@implementation MRSpamGameViewController

+ (MRGameViewController *)newGameViewController {
    MRSpamGameViewController *gvc = [[MRSpamGameViewController alloc] initWithNibName:@"MRGameViewController" bundle:[NSBundle mainBundle]];
    NSURL *gameURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"communications" ofType:@"json"]];
    MRRuleset *gameRuleset = [MRRuleset rulesetWithRules:@[@"Spam", @"Legit"] andNib:@"SpamCard"];
    gameRuleset.pointsPerTurn = 1;
    gvc.game = [MRGame gameWithURL:gameURL andRuleset:gameRuleset];
    return gvc;
}

- (UIView *)getCard {
    UIView *card = [super getCard];
    // get data from store and map to game-specific card.
    // in this case, SpamCard.xib
    MRGameDataQueue *queue = self.game.dataQueue;
    NSDictionary *data = [queue dequeue];
    if (data != nil) {
        self.orphanSubject.text = [data valueForKeyPath:@"from_who"];
    }
    return card;
}



@end
