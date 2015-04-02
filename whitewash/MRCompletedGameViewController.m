//
//  MRCompletedGameViewController.m
//  Whitewash
//
//  Created by Allan Lasser on 4/2/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import "MRCompletedGameViewController.h"

@interface MRCompletedGameViewController ()

@end

@implementation MRCompletedGameViewController

- (UIView *)getCard {
    UIView *card = [super getCard];
    
    // get data from store and map to game-specific card.
    // in this case, CompletedCard.xib
    
    return card;
}

@end
