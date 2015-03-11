//
//  MRGameDataStore.m
//  Whitewash
//
//  Created by Allan Lasser on 3/6/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import "MRGameDataStore.h"

@interface MRGameDataStore ()

@property (nonatomic, strong) NSMutableArray *privateGameData;

@end

@implementation MRGameDataStore

- (instancetype)init {
    self = [super init];
    if (self) {
        self.privateGameData = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray *)data {
    return [self.privateGameData copy];
}

# pragma mark Store

- (void)addData:(id)data {
    [self.privateGameData addObject:data];
}

- (void)removeData:(id)data {
    [self.privateGameData removeObjectIdenticalTo:data];
}

- (id)popData {
    NSInteger lastItemIndex = [_privateGameData count] - 1;
    if (lastItemIndex == -1) {
        @throw [[NSException alloc] initWithName:@"No Data to Pop" reason:@"You are trying to pop data from an empty store."userInfo:nil];
    }
    id data = _privateGameData[lastItemIndex];
    [self removeData:data];
    return data;
}

- (void)moveDataAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    if (fromIndex == toIndex) {
        return;
    }
    id data = [self.privateGameData objectAtIndex:fromIndex];
    [self.privateGameData removeObjectAtIndex:fromIndex];
    [self.privateGameData insertObject:data atIndex:toIndex];
}

@end
