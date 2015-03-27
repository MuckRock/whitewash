//
//  MRWebStoreTests.m
//  Whitewash
//
//  Created by Allan Lasser on 3/6/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "MRWebStore.h"

@interface MRWebStoreTests : XCTestCase

@end

@implementation MRWebStoreTests {
    MRWebStore *store;
    NSURL *url;
}

- (void)setUp {
    [super setUp];
    url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"communications" ofType:@"json"]];
    store = [MRWebStore webStoreWithURL:url];
}

- (void)tearDown {
    [super tearDown];
    url = nil;
    store = nil;
}

- (void)testConstructor {
    XCTAssertNotNil(store);
}

- (void)testPullData {
    XCTAssertGreaterThan([store.data count], 0);
}

- (void)testAddData {
    NSUInteger startingLength = [store.data count];
    [store addData:@{@"hello": @1}];
    NSUInteger currentLength = [store.data count];
    XCTAssertEqual((currentLength - startingLength), 1);
}

- (void)testRemoveDataForKey {
    NSUInteger startingLength = [store.data count];
    [store removeDataForKey:@"count"];
    NSUInteger currentLength = [store.data count];
    XCTAssertEqual((currentLength - startingLength), -1);
}

- (void)testUpdateKeyWithValueForNonexistantKey {
    [store updateKey:@"hello" withValue:@1];
    XCTAssertEqual([store valueForKey:@"hello"], @1);
}

@end
