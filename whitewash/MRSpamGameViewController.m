//
//  MRSpamGameViewController.m
//  Whitewash
//
//  Created by Allan Lasser on 4/2/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import "MRSpamGameViewController.h"

@interface MRSpamGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *orphanSubject;

@end

@implementation MRSpamGameViewController

- (UIView *)getCard {
    UIView *card = [super getCard];
    
    // get data from store and map to game-specific card.
    // in this case, SpamCard.xib
    
    self.orphanSubject.text = @"Subject";
    
    return card;
}

@end
