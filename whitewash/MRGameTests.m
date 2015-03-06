//
//  MRGameTests.m
//  Whitewash
//
//  Created by Allan Lasser on 3/6/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "MRGame.h"

@interface MRGameTests : XCTestCase

@end

@implementation MRGameTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInit {
    MRGame *game = [[MRGame alloc] init];
    XCTAssertNotNil(game, @"MRGame fails to initialize");
    XCTAssertNil(game.inputURL);
    XCTAssertNil(game.outputURL);
    XCTAssertNotNil(game.record);
}

- (void)testInitWithEndpointURL {
    NSURL *url = [NSURL URLWithString:@"https://www.muckrock.com/"];
    MRGame *game = [[MRGame alloc] initWithEndpointURL:url];
    XCTAssertNotNil(game);
    XCTAssertEqual(game.inputURL, url);
    XCTAssertEqual(game.outputURL, url);
}

- (void)testInitWithInputURLandOutputURL {
    NSURL *url1 = [NSURL URLWithString:@"http://www.upworthy.com/"];
    NSURL *url2 = [NSURL URLWithString:@"http://www.buzzfeed.com/"];
    MRGame *game = [[MRGame alloc] initWithInputURL:url1 andOutputURL:url2];
    XCTAssertNotNil(game);
    XCTAssertEqual(game.inputURL, url1);
    XCTAssertEqual(game.outputURL, url2);
}

@end
