//
//  MRWebStore.m
//  Whitewash
//
//  Created by Allan Lasser on 3/6/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import "MRWebStore.h"

@interface MRWebStore ()

@property (nonatomic, strong) NSMutableDictionary *mutableData;

@end

@implementation MRWebStore

@synthesize url;

- (instancetype)initWithURL:(NSURL *)someURL {
    self = [super init];
    if (self) {
        self.url = someURL;
        self.mutableData = [[NSMutableDictionary alloc] initWithDictionary:[self pullData]];
    }
    return self;
}

+ (MRWebStore *)webStoreWithURL:(NSURL *)someURL {
    return [[MRWebStore alloc] initWithURL:someURL];
}

- (NSDictionary *)pullData {
    NSData *data = [NSData dataWithContentsOfURL:self.url];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    return json;
}

- (void)pushData:(NSDictionary *)data {
    // POST self.mutableData to self.url
}

- (NSArray *)data {
    return [self.mutableData copy];
}

# pragma mark Store

- (void)addData:(NSDictionary *)data {
    [self.mutableData addEntriesFromDictionary:data];
}

- (void)removeDataForKey:(id)key {
    [self.mutableData removeObjectForKey:key];
}

- (void)updateKey:(id)key withValue:(id)value {
    if ([self.mutableData objectForKey:key]) {
        [self.mutableData setValue:value forKey:key];
    } else {
        [self addData:@{key: value}];
    }
}

@end
