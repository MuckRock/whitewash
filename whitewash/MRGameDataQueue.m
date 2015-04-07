//
//  MRGameDataQueue.m
//  Whitewash
//
//  Created by Allan Lasser on 4/3/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import "MRGameDataQueue.h"

@interface MRGameDataQueue ()

@property (nonatomic, strong) NSMutableArray *mutableQueue;

@end

@implementation MRGameDataQueue

- (instancetype)init {
    self = [super init];
    if (self) {
        self.mutableQueue = [[NSMutableArray alloc] init];
    }
    return self;
}

+ (MRGameDataQueue *)newQueue {
    return [[MRGameDataQueue alloc] init];
}

- (NSArray *)queue {
    return [self.mutableQueue copy];
}

- (void)enqueue:(id)data {
    [self.mutableQueue addObject:data];
}

- (id)dequeue {
    id data;
    @try {
        data = [self.mutableQueue firstObject];
        [self.mutableQueue removeObjectAtIndex:0];
    }
    @catch (NSException *exception) {
        data = nil;
    }
    @finally {
        return data;
    }
}

@end
