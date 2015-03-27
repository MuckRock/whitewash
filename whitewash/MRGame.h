//
//  MRGame.h
//  Whitewash
//
//  Created by Allan Lasser on 3/6/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MRRecord.h"
#import "MRRuleset.h"
#import "MRWebStore.h"

@interface MRGame : NSObject

@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) MRRecord *record;
@property (nonatomic, strong) MRRuleset *ruleset;
@property (nonatomic, strong) MRWebStore *store;

+ (MRGame *)gameWithURL:(NSURL *)someURL andRulset:(MRRuleset *)someRuleset;
- (void)takeTurnWithMove:(id)move;

@end
