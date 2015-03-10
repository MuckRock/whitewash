//
//  MRGame.m
//  Whitewash
//
//  Created by Allan Lasser on 3/6/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import "MRGame.h"

@implementation MRGame

@synthesize record, inputData, inputURL, outputData, outputURL;

- (instancetype)init {
    return [self initWithEndpointURL:nil];
}

- (instancetype)initWithEndpointURL:(NSURL *)endpoint {
    return [self initWithInputURL:endpoint andOutputURL:endpoint];
}

- (instancetype)initWithInputURL:(NSURL *)anInputURL andOutputURL:(NSURL *)anOutputURL {
    self = [super init];
    if (self) {
        self.inputURL = anInputURL;
        self.outputURL = anOutputURL;
        self.record = [MRRecord newRecord];
    }
    return self;
}

- (void)takeTurn:(id)turn {
    [self.record recordTurn:turn];
    [self.record modifyScoreBy:1];
}

@end
