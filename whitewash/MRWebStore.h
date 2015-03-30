//
//  MRWebStore.h
//  Whitewash
//
//  Created by Allan Lasser on 3/6/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRWebStore : NSObject

@property (nonatomic, strong) NSURL *url;
@property (nonatomic, readonly, copy) NSDictionary *data;

+ (MRWebStore *)webStoreWithURL:(NSURL *)someURL;

- (NSDictionary *)pullData;
- (void)pushData;

- (void)addData:(NSDictionary *)data;
- (void)removeDataForKey:(id)key;
- (void)updateKey:(id)key withValue:(id)value;

@end
