//
//  MRPrototype.m
//  Whitewash
//
//  Created by Allan Lasser on 12/18/14.
//  Copyright (c) 2014 MuckRock. All rights reserved.
//

#import "MRPrototype.h"

@implementation MRPrototype

@synthesize name;

- (instancetype)init {
    return [self initWithName:@"New Prototype"];
}

- (instancetype)initWithName:(NSString *)theName {
    self = [super init];
    if (self) {
        self.name = theName;
    }
    return self;
}

- (NSString *)description {
    return self.name;
}

@end
