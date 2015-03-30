//
//  MRGame.m
//  Whitewash
//
//  Created by Allan Lasser on 3/6/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import "MRGame.h"
#import "MRRecord.h"
#import "MRRuleset.h"
#import "MRWebStore.h"

@implementation MRGame

@synthesize record, ruleset, store;

- (instancetype)init {
    return [self initWithURL:nil andRuleset:nil];
}

- (instancetype)initWithURL:(NSURL *)someURL andRuleset:(MRRuleset *)someRuleset {
    self = [super init];
    if (self) {
        self.ruleset = someRuleset;
        self.record = [MRRecord newRecord];
        self.store = [MRWebStore webStoreWithURL:someURL];
    }
    return self;
}

+ (MRGame *)gameWithURL:(NSURL *)someURL andRuleset:(MRRuleset *)someRuleset {
    return [[MRGame alloc] initWithURL:someURL andRuleset:someRuleset];
}

- (void)takeTurnWithMove:(id)move {
    MRTurn *turn = [self.ruleset validateMove:move];
    if (turn) {
        [record addTurn:turn];
    }
    else {
        [NSException raise:@"Illegal Move" format:@"Moving %@ is against the rules", move];
    }
}

@end
