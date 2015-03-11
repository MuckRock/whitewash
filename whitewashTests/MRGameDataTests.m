//
//  MRGameDataTests.m
//  Whitewash
//
//  Created by Allan Lasser on 3/11/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "MRGameData.h"

@interface MRGameDataTests : XCTestCase

@end

@implementation MRGameDataTests {
    MRGameData *gameData;
}

- (void)setUp {
    [super setUp];
    gameData = [[MRGameData alloc] initWithName:@"Test Data" body:@"Lorem ipsum" andFiles:@[]];
}

- (void)tearDown {
    gameData = nil;
    [super tearDown];
}

- (void)testInit {
    XCTAssertNotNil(gameData);
}

@end
