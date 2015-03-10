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

@property (nonatomic) NSURL *url1;
@property (nonatomic) NSURL *url2;
@property (nonatomic) MRGame *game;

@end

@implementation MRGameTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _url1 = [NSURL URLWithString:@"http://www.upworthy.com/"];
    _url2 = [NSURL URLWithString:@"http://www.buzzfeed.com/"];
    _game = [[MRGame alloc] initWithInputURL:_url1 andOutputURL:_url2];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    _url1 = nil;
    _url2 = nil;
    _game = nil;
}

- (void)testInitWithInputURLandOutputURL {
    XCTAssertNotNil(_game);
    XCTAssertEqual(_game.inputURL, _url1);
    XCTAssertEqual(_game.outputURL, _url2);
    XCTAssertNotNil(_game.record);
}

@end
