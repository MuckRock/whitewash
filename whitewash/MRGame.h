//
//  MRGame.h
//  Whitewash
//
//  Created by Allan Lasser on 3/6/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MRRecord.h"
#import "MRGameDataStore.h"

@interface MRGame : NSObject

@property (nonatomic, strong) MRRecord *record;
@property (nonatomic, strong) MRGameDataStore *gameData;
@property (nonatomic, strong) NSData *inputData;
@property (nonatomic, strong) NSData *outputData;
@property (nonatomic, strong) NSURL *inputURL;
@property (nonatomic, strong) NSURL *outputURL;

- (instancetype)initWithInputURL:(NSURL *)anInputURL
                    andOutputURL:(NSURL *)anOutputURL;
- (instancetype)initWithEndpointURL:(NSURL *)endpoint;

@end
