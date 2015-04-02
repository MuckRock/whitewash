//
//  MRCompletedGameViewController.m
//  Whitewash
//
//  Created by Allan Lasser on 4/2/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import "MRCompletedGameViewController.h"

@interface MRCompletedGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *formerRequestTitle;
@property (weak, nonatomic) IBOutlet UILabel *formerRequestAgency;
@property (weak, nonatomic) IBOutlet UILabel *latterRequestTitle;
@property (weak, nonatomic) IBOutlet UILabel *latterRequestAgency;

@end

@implementation MRCompletedGameViewController

- (UIView *)getCard {
    UIView *card = [super getCard];
    
    // get data from store and map to game-specific card.
    // in this case, CompletedCard.xib
    
    return card;
}

@end
