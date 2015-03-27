//
//  MRWebStore.m
//  Whitewash
//
//  Created by Allan Lasser on 3/6/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import "MRWebStore.h"
#import "MRGameData.h"

@interface MRWebStore ()

@property (nonatomic, strong) NSMutableArray *privateGameData;

@end

@implementation MRWebStore

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

- (void)addData:(MRGameData *)data {
    [self.privateGameData addObject:data];
}

- (void)removeData:(MRGameData *)data {
    [self.privateGameData removeObjectIdenticalTo:data];
}

- (MRGameData *)popData {
    NSInteger lastItemIndex = [_privateGameData count] - 1;
    if (lastItemIndex == -1) {
        @throw [[NSException alloc] initWithName:@"No Data to Pop" reason:@"You are trying to pop data from an empty store."userInfo:nil];
    }
    MRGameData *data = _privateGameData[lastItemIndex];
    [self removeData:data];
    return data;
}

- (void)moveDataAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    if (fromIndex == toIndex) {
        return;
    }
    MRGameData *data = [self.privateGameData objectAtIndex:fromIndex];
    [self.privateGameData removeObjectAtIndex:fromIndex];
    [self.privateGameData insertObject:data atIndex:toIndex];
}

@end
