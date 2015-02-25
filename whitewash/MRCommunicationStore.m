//
//  MRCommunicationStore.m
//  Whitewash
//
//  Created by Allan Lasser on 2/19/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import "MRCommunicationStore.h"

@interface MRCommunicationStore ()

@property (nonatomic, strong) NSMutableArray *private_communications;

@end

@implementation MRCommunicationStore

# pragma mark Initialization

- (instancetype)init {
    [NSException raise:@"Singleton" format:@"Use +[MRCommunicationStore sharedStore]"];
    return nil;
}

- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        _private_communications = [[NSMutableArray alloc] init];
    }
    return self;
}

# pragma mark SharedStore

- (void)addCommunication:(MRCommunication *)communication {
    [_private_communications addObject:communication];
}

- (void)removeCommunication:(MRCommunication *)communication {
    [_private_communications removeObjectIdenticalTo:communication];
}

- (void)moveCommunicationAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    MRCommunication *comm = [_private_communications objectAtIndex:fromIndex];
    [_private_communications removeObjectAtIndex:fromIndex];
    [_private_communications insertObject:comm atIndex:toIndex];
}

+ (instancetype)sharedStore {
    static MRCommunicationStore *sharedStore;
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    return sharedStore;
}

- (NSArray *)communications {
    return [_private_communications copy];
}

@end
