//
//  MRCompletedGameViewController.m
//  Whitewash
//
//  Created by Allan Lasser on 4/2/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import "MRCompletedGameViewController.h"

@interface MRCompletedGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *request1Title;
@property (weak, nonatomic) IBOutlet UILabel * request2Title;

@end

@implementation MRCompletedGameViewController

- (UIView *)getCard {
    UIView *card = [super getCard];
    
    // get data from store and map to game-specific card.
    // in this case, CompletedCard.xib
    
    self.request1Title.text = @"A Cool Request";
    self.request2Title.text = @"Another request";
    
    return card;
}

@end
