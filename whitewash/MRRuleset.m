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

@property (nonatomic) NSInteger pointsPerTurn;
@property (nonatomic) NSInteger pointMultiplier;

@end

@implementation MRRuleset

@synthesize rules;

- (MRTurn *)validateMove:(id)move {
    // compare move against move rules
    // if a valid move, create and return a turn object
    MRTurn *turn = [[MRTurn alloc] init];
    turn.score = self.pointsPerTurn;
    turn.multiplier = self.pointMultiplier;
    turn.move = move;
    // otherwise, raise an invalid move played error
}

@end
