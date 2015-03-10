//
//  MRRulesetTests.m
//  Whitewash
//
//  Created by Allan Lasser on 3/6/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "MRRuleset.h"

@interface MRRulesetTests : XCTestCase

@property (nonatomic) MRRuleset *rules;
@property (nonatomic) id specificRule;

@end

@implementation MRRulesetTests

- (void)setUp {
    [super setUp];
    _rules = [[MRRuleset alloc] init];
    _specificRule = OCMClassMock([NSObject class]);
}

- (void)tearDown {
    [super tearDown];
    _rules = nil;
    _specificRule = nil;
}

- (void)testInit {
    XCTAssertNotNil(_rules);
}

- (void)testRuleArrays {
    XCTAssertNotNil(_rules.startState);
    XCTAssertEqual([_rules.startState count], 0);
    XCTAssertNotNil(_rules.moves);
    XCTAssertEqual([_rules.moves count], 0);
    XCTAssertNotNil(_rules.endState);
    XCTAssertEqual([_rules.endState count], 0);
}

- (void)testAddingRule {
    [_rules addStartStateRule:_specificRule];
    XCTAssertEqualObjects(_rules.startState[0], _specificRule);
    [_rules addEndStateRule:_specificRule];
    XCTAssertEqualObjects(_rules.endState[0], _specificRule);
    [_rules addMoveRule:_specificRule];
    XCTAssertEqualObjects(_rules.moves[0], _specificRule);
}

- (void)testRemovingRule {
    XCTAssertNoThrow([_rules removeStartStateRule:_specificRule]);
    XCTAssertNoThrow([_rules removeEndStateRule:_specificRule]);
    XCTAssertNoThrow([_rules removeMoveRule:_specificRule]);
    [_rules addStartStateRule:_specificRule];
    [_rules addEndStateRule:_specificRule];
    [_rules addMoveRule:_specificRule];
    [_rules removeStartStateRule:_specificRule];
    XCTAssertEqual([_rules.startState count], 0);
    [_rules removeEndStateRule:_specificRule];
    XCTAssertEqual([_rules.endState count], 0);
    [_rules removeMoveRule:_specificRule];
    XCTAssertEqual([_rules.moves count], 0);
}

- (void)testAddingRules {
    NSArray *array = @[@"Stop", @"Go", @"Turn Left", @"Turn Right"];
    id specificRules = OCMPartialMock(array);
    [_rules addStartStateRules:specificRules];
    XCTAssertEqual([_rules.startState count], 4);
    [_rules addEndStateRules:specificRules];
    XCTAssertEqual([_rules.endState count], 4);
    [_rules addMoveRules:specificRules];
    XCTAssertEqual([_rules.moves count], 4);
}

@end
