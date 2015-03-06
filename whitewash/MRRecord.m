//
//  MRRecord.m
//  Whitewash
//
//  Created by Allan Lasser on 3/6/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import "MRRecord.h"

@interface MRRecord ()

@property (nonatomic) NSInteger privateScore;
@property (nonatomic) NSInteger privateTurns;

@end

@implementation MRRecord

- (instancetype)init {
    self = [super init];
    if (self) {
        self.privateScore = 0;
        self.privateTurns = 0;
    }
    return self;
}

+ (MRRecord *)newRecord {
    return [[MRRecord alloc] init];
}

- (NSInteger)score {
    return self.privateScore;
}

- (NSInteger)turns {
    return self.privateTurns;
}

@end
