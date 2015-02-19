//
//  MRCommunicationStore.h
//  Whitewash
//
//  Created by Allan Lasser on 2/19/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRCommunicationStore : NSObject

+ (instancetype)sharedStore;

- (void)addCommunicationToStore:(id)communication;
- (id)

@end
