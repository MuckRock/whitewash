//
//  MRPrototype.m
//  Whitewash
//
//  Created by Allan Lasser on 12/18/14.
//  Copyright (c) 2014 MuckRock. All rights reserved.
//

#import "MRPrototype.h"

@implementation MRPrototype

@synthesize name, simpleValue;

- (instancetype)init {
    return [self initWithName:@"New Prototype" andValue:@0];
}

- (instancetype)initWithName:(NSString *)theName andValue:(NSNumber *)theValue {
    self = [super init];
    if (self) {
        self.name = theName;
        self.simpleValue = theValue;
    }
    return self;
}

- (NSString *)description {
    return @"A prototype.";
}

- (void)incrementValue {
    int value = [self.simpleValue intValue];
    self.simpleValue = [NSNumber numberWithInt:value + 1];
}

- (void)decrementValue {
    int value = [self.simpleValue intValue];
    self.simpleValue = [NSNumber numberWithInt:value - 1];
}

@end
