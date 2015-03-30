//
//  MRRuleset.m
//  Whitewash
//
//  Created by Allan Lasser on 3/6/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import "MRRuleset.h"
#import "MRTurn.h"

@interface MRRuleset ()

@property (nonatomic, strong) NSPredicate *predicate;

@end

@implementation MRRuleset

@synthesize rules, pointsPerTurn, pointMultiplier;

+ (MRRuleset *)rulesetWithRules:(NSArray *)rules {
    return [[MRRuleset alloc] initWithRules:rules];
}

- (instancetype)initWithRules:(NSArray *)theRules {
    self = [super init];
    if (self) {
        self.rules = theRules;
        self.predicate = [NSPredicate predicateWithFormat:@"SELF IN %@", theRules];
        self.pointsPerTurn = 1;
        self.pointMultiplier = 1;
    }
    return self;
}

- (MRTurn *)validateMove:(id)move {
    MRTurn *turn = nil;
    BOOL validMove = [self.predicate evaluateWithObject:move];
    if (validMove) {
        turn = [[MRTurn alloc] init];
        turn.score = self.pointsPerTurn;
        turn.multiplier = self.pointMultiplier;
        turn.move = move;
        return turn;
    }
    return turn;
}

@end
