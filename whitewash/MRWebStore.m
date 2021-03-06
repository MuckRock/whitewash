//
//  MRWebStore.m
//  Whitewash
//
//  Created by Allan Lasser on 3/6/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import "MRWebStore.h"

#import "MRGame.h"

@interface MRWebStore ()

@property (nonatomic, strong) NSMutableDictionary *mutableData;

@end

@implementation MRWebStore

# pragma mark Getters & Setters

@synthesize url, delegate;

- (NSArray *)data {
    return [self.mutableData copy];
}

# pragma mark Lifecycle Methods

- (instancetype)initWithURL:(NSURL *)someURL {
    self = [super init];
    if (self) {
        self.url = someURL;
        self.mutableData = [[NSMutableDictionary alloc] init];
        [self pullData];
    }
    return self;
}

+ (MRWebStore *)webStoreWithURL:(NSURL *)someURL {
    return [[MRWebStore alloc] initWithURL:someURL];
}

- (void)pullData {
    NSData *data = [NSData dataWithContentsOfURL:self.url];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    [self.mutableData addEntriesFromDictionary:json];
}

- (void)pushData {
    // POST self.mutableData to self.url
}

- (void)enqueueData {
    NSArray *results = [self.data valueForKey:@"results"];
    for (NSDictionary *result in results) {
        [self.delegate.dataQueue enqueue:result];
    }
}

# pragma mark Mutator Methods

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
