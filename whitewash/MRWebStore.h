//
//  MRWebStore.h
//  Whitewash
//
//  Created by Allan Lasser on 3/6/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MRGame;

@interface MRWebStore : NSObject

@property (nonatomic, strong) NSURL *url;
@property (nonatomic, readonly, copy) NSDictionary *data;
@property (nonatomic, weak) MRGame *delegate;

+ (MRWebStore *)webStoreWithURL:(NSURL *)someURL;

# pragma mark Lifecycle Methods

- (void)pullData;
- (void)pushData;

# pragma mark Queue Methods

- (void)enqueueData;

# pragma mark Mutator Methods

- (void)addData:(NSDictionary *)data;
- (void)removeDataForKey:(NSString *)key;
- (void)updateKey:(id)key withValue:(id)value;

@end

