//
//  MRGameViewController.h
//  Whitewash
//
//  Created by Allan Lasser on 3/9/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MRGameViewController;
@class MRRecord;

@protocol MRGameViewContollerDelegate <NSObject>

- (void)gameViewController:(MRGameViewController *)controller
             didCompleteGame:(MRRecord *)record;

@end

@interface MRGameViewController : UIViewController

@property (nonatomic, weak) id <MRGameViewContollerDelegate> delegate;
@property (nonatomic, weak) NSArray *playerHistory;

@end
