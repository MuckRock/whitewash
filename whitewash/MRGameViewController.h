//
//  MRGameViewController.h
//  Whitewash
//
//  Created by Allan Lasser on 3/9/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MRGameViewController;
@class MRGame;
@class MRRecord;

@protocol MRGameViewContollerDelegate <NSObject>

- (void)gameViewController:(MRGameViewController *)controller
             didCompleteGame:(MRRecord *)record;

@end

@protocol MRGameViewControllerProtocol <NSObject>

+ (MRGameViewController *)newGameViewController;

@end

@interface MRGameViewController : UIViewController

@property (nonatomic, strong) MRGame *game;
@property (nonatomic) NSInteger multiplier;
@property (nonatomic, weak) id <MRGameViewContollerDelegate> delegate;
@property (nonatomic) NSUInteger turns;

- (void)updateCounters;

- (UIView *)getTutorialCard;
- (UIView *)getCard;

@end
