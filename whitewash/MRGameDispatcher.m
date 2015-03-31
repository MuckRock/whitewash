//
//  MRGameDispatcher.m
//  Whitewash
//
//  Created by Allan Lasser on 3/30/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import "MRGameDispatcher.h"

#import "MRGame.h"
#import "MRRuleset.h"

@interface MRGameDispatcher ()

@property (nonatomic) int rand;

@end

@implementation MRGameDispatcher

+ (MRGameDispatcher *)newDispatcher {
    MRGameDispatcher *dispatcher = [[MRGameDispatcher alloc] init];
    dispatcher.rand = arc4random() % 2;
    return dispatcher;
}

- (MRGame *)newGame {
    return [MRGame gameWithURL:[self gameURL] andRuleset:[self gameRuleset]];
}

- (NSURL *)gameURL {
    NSString *path = (self.rand == 0) ? @"communications" : @"completed";
    return [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:path ofType:@"json"]];
}

- (MRRuleset *)gameRuleset {
    MRRuleset *ruleset = (self.rand == 0) ? [MRRuleset rulesetWithRules:@[@"Spam", @"Legit"] andNib:@"SpamCard"] : [MRRuleset rulesetWithRules:@[@"Former", @"Latter"] andNib:@"CompletedCard"];
    ruleset.pointsPerTurn = 1;
    return ruleset;
}

@end
