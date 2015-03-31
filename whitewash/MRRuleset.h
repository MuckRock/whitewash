//
//  MRRuleset.h
//  Whitewash
//
//  Created by Allan Lasser on 3/6/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MRTurn.h"

@interface MRRuleset : NSObject

@property (nonatomic, strong) NSArray *rules;
@property (nonatomic) NSInteger pointsPerTurn;
@property (nonatomic) NSInteger pointMultiplier;
@property (nonatomic, strong) NSString *nibName;

- (MRTurn *)validateMove:(id)move;

+ (MRRuleset *)rulesetWithRules:(NSArray *)rules andNib:(NSString *)nib;

@end
