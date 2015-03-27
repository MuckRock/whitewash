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

@property (nonatomic, strong) NSCompoundPredicate *rules;

- (MRTurn *)validateMove:(id)move;

@end
