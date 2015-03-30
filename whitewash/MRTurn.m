//
//  MRTurn.m
//  Whitewash
//
//  Created by Allan Lasser on 3/26/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import "MRTurn.h"

@implementation MRTurn

@synthesize move, date, score, multiplier;

- (instancetype)init {
    self = [super self];
    if (self) {
        self.date = [NSDate date];
    }
    return self;
}

@end
