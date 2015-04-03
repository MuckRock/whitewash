//
//  MRCompletedGameViewController.m
//  Whitewash
//
//  Created by Allan Lasser on 4/2/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import "MRCompletedGameViewController.h"

#import "MRGame.h"
#import "MRGameDataQueue.h"
#import "MRWebStore.h"

@interface MRCompletedGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *formerRequestTitle;
@property (weak, nonatomic) IBOutlet UILabel *formerRequestAgency;
@property (weak, nonatomic) IBOutlet UILabel *latterRequestTitle;
@property (weak, nonatomic) IBOutlet UILabel *latterRequestAgency;

@end

@implementation MRCompletedGameViewController

- (UIView *)getCard {
    UIView *card = [super getCard];
    // get data from queue and map to game-specific card.
    // in this case, CompletedCard.xib
    MRGameDataQueue *queue = self.game.dataQueue;
    NSDictionary *former = [queue dequeue];
    NSDictionary *latter = [queue dequeue];
    if (former && latter) {
        self.formerRequestTitle.text = [former valueForKey:@"title"];
        self.latterRequestTitle.text = [latter valueForKey:@"title"];
        
        self.formerRequestAgency.text = [NSString stringWithFormat:@"%@", [former valueForKey:@"agency"]];
        self.latterRequestAgency.text = [NSString stringWithFormat:@"%@", [latter valueForKey:@"agency"]];
        
    }
    return card;
}

@end
