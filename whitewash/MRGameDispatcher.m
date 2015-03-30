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

@implementation MRGameDispatcher

+ (MRGameDispatcher *)newDispatcher {
    return [[MRGameDispatcher alloc] init];
}

- (MRGame *)newGame {
    return [MRGame gameWithURL:[self gameURL] andRuleset:[self gameRuleset]];
}

- (NSURL *)gameURL {
    return [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"communications" ofType:@"json"]];
}

- (MRRuleset *)gameRuleset {
    return [MRRuleset rulesetWithRules:@[@"Spam", @"Legit"]];
}

@end
