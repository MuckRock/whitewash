//
//  MRGame.m
//  Whitewash
//
//  Created by Allan Lasser on 3/6/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import "MRGame.h"
#import "MRGameData.h"

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
        self.inputData = [[MRGameDataStore alloc] init];
        self.outputData = [[MRGameDataStore alloc] init];
    }
    return self;
}

- (void)takeTurn:(id)turn {
    [self.record recordTurn:turn];
    [self.record modifyScoreBy:1];
}

- (void)populateInputDataStore {
    // TODO: actually get real data. you know, from the server.
    // When that happens, use self.inputURL as the URL path.
    NSString *JSONPath = [[NSBundle mainBundle] pathForResource:@"communications" ofType:@"json"];
    // The rest of this works fine tho
    NSData *data = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:JSONPath]];
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    for (NSDictionary *jsonData in jsonObject[@"results"]) {
        NSString *name;
        NSString *body;
        NSArray *files;
        @try {
            name = jsonData[@"name"];
        }
        @catch (NSException *exception) {
            name = @"Unnamed";
        }
        @try {
            body = jsonData[@"communication"];
        }
        @catch (NSException *exception) {
            body = @"Empty";
        }
        @try {
            files = jsonData[@"files"];
        }
        @catch (NSException *exception) {
            files = @[];
        }
        MRGameData *dataToAdd = [[MRGameData alloc] initWithName:name body:body andFiles:files];
        [self.inputData addData:dataToAdd];
    }
}

@end
