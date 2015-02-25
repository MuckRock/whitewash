//
//  MRCommunicationStore.h
//  Whitewash
//
//  Created by Allan Lasser on 2/19/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MRCommunication.h"

@interface MRCommunicationStore : NSObject

@property (nonatomic, readonly, copy) NSArray *communications;

- (void)addCommunication:(MRCommunication *)communication;
- (void)removeCommunication:(MRCommunication *)communication;
- (void)moveCommunicationAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;
+ (instancetype)sharedStore;

@end
