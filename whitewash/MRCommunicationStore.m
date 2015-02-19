//
//  MRCommunicationStore.m
//  Whitewash
//
//  Created by Allan Lasser on 2/19/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import "MRCommunicationStore.h"

@interface MRCommunicationStore ()

@property (nonatomic, strong) NSMutableArray *communications;

@end

@implementation MRCommunicationStore

+ (instancetype)sharedStore {
    static MRCommunicationStore *sharedStore;
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    return sharedStore;
}

- (instancetype)init {
    [NSException raise:@"Singleton" format:@"Use +[MRCommunicationStore sharedStore]"];
    return nil;
}

- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        _communications = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
