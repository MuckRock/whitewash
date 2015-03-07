//
//  MRRulesetTests.m
//  Whitewash
//
//  Created by Allan Lasser on 3/6/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "MRRuleset.h"

@interface MRRulesetTests : XCTestCase

@end

@implementation MRRulesetTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInit {
    MRRuleset *rules = [[MRRuleset alloc] init];
    XCTAssertNotNil(rules);
}

- (void)testRuleArrays {
    MRRuleset *rules = [[MRRuleset alloc] init];
    XCTAssertNotNil(rules.startState);
    XCTAssertEqual([rules.startState count], 0);
    XCTAssertNotNil(rules.moves);
    XCTAssertEqual([rules.moves count], 0);
    XCTAssertNotNil(rules.endState);
    XCTAssertEqual([rules.endState count], 0);
}

- (void)testAddingRule {
    MRRuleset *rules = [[MRRuleset alloc] init];
    NSObject *specificRule = [[NSObject alloc] init];
    [rules addStartStateRule:specificRule];
    XCTAssertEqualObjects(rules.startState[0], specificRule);
    [rules addEndStateRule:specificRule];
    XCTAssertEqualObjects(rules.endState[0], specificRule);
    [rules addMoveRule:specificRule];
    XCTAssertEqualObjects(rules.moves[0], specificRule);
}

- (void)testRemovingRule {
    MRRuleset *rules = [[MRRuleset alloc] init];
    NSObject *specificRule = [[NSObject alloc] init];
    XCTAssertNoThrow([rules removeStartStateRule:specificRule]);
    XCTAssertNoThrow([rules removeEndStateRule:specificRule]);
    XCTAssertNoThrow([rules removeMoveRule:specificRule]);
    [rules addStartStateRule:specificRule];
    [rules addEndStateRule:specificRule];
    [rules addMoveRule:specificRule];
    [rules removeStartStateRule:specificRule];
    XCTAssertEqual([rules.startState count], 0);
    [rules removeEndStateRule:specificRule];
    XCTAssertEqual([rules.endState count], 0);
    [rules removeMoveRule:specificRule];
    XCTAssertEqual([rules.moves count], 0);
}

- (void)testAddingRules {
    MRRuleset *rules = [[MRRuleset alloc] init];
    NSArray *specificRules = @[@"Stop", @"Go", @"Turn Left", @"Turn Right"];
    [rules addStartStateRules:specificRules];
    XCTAssertEqual([rules.startState count], 4);
    [rules addEndStateRules:specificRules];
    XCTAssertEqual([rules.endState count], 4);
    [rules addMoveRules:specificRules];
    XCTAssertEqual([rules.moves count], 4);
}

@end
