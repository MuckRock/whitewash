//
//  MRRecordTests.m
//  Whitewash
//
//  Created by Allan Lasser on 3/6/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "MRRecord.h"

@interface MRRecordTests : XCTestCase

@end

@implementation MRRecordTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInit {
    MRRecord *record = [[MRRecord alloc] init];
    XCTAssertNotNil(record, @"MRRecord fails to initialize");
}

- (void)testNewRecord {
    MRRecord *record = [MRRecord newRecord];
    XCTAssertNotNil(record, @"newRecord fails to return a new record");
}

@end
