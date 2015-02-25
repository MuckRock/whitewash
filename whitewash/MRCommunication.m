//
//  MRCommunication.m
//  Whitewash
//
//  Created by Allan Lasser on 2/19/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import "MRCommunication.h"

@implementation MRCommunication

- (instancetype)init {
    NSDictionary *json = @{@"id": @"Unknown",
                           @"from_who": @"Unknown",
                           @"communication": @"Lorem ipsum dolor sit amet.",
                           @"attachments"};
    return [self initFromJSON:json];
}

- (instancetype)initFromJSON:(NSDictionary *)json {
    self = [super init];
    if (self) {
        self.ID = json[@"id"];
        self.from = json[@"from_who"];
        self.message = json[@"communication"];
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    NSDictionary *json = @{@"id": self.ID, @"from_who": self.from, @"communication": self.message};
    return [[MRCommunication alloc] initFromJSON:json];
}

- (NSString *)description {
    return @"An object representing a FOIA communication from MuckRock";
}

@end
