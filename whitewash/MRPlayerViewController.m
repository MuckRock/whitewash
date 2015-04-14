//
//  MRPlayerViewController.m
//  Whitewash
//
//  Created by Allan Lasser on 3/9/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import "MRPlayerViewController.h"

#import "MRPlayer.h"
#import "MRRecord.h"
#import "MRGame.h"
#import "MRGameDispatcher.h"
#import "MRGameViewController.h"

@interface MRPlayerViewController ()

@property (nonatomic, strong) NSArray *ranks;

# pragma mark Player

@property (nonatomic, strong) MRPlayer *player;
@property (weak, nonatomic) IBOutlet UILabel *playerName;
@property (weak, nonatomic) IBOutlet UIImageView *playerImage;
@property (weak, nonatomic) IBOutlet UILabel *playerRank;

# pragma mark Scoreboard
@property (weak, nonatomic) IBOutlet UILabel *levelUpMotivation;

@property (weak, nonatomic) IBOutlet UILabel *totalTurns;
@property (weak, nonatomic) IBOutlet UILabel *totalGames;

@property (weak, nonatomic) IBOutlet UILabel *bestScore;
@property (weak, nonatomic) IBOutlet UILabel *sessionScore;

@property (weak, nonatomic) IBOutlet UILabel *bestMultiplier;
@property (weak, nonatomic) IBOutlet UILabel *sessionMultiplier;

@end

@implementation MRPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _ranks = @[@"Intern", @"Freelancer", @"Contributor", @"Editor"];
    _player = [MRPlayer newPlayerWithName:@"Samuel Clemens"];
    _playerName.text = _player.name;
    _playerImage.image = [UIImage imageNamed:@"Tom Sawyer"];
    _playerImage.layer.cornerRadius = _playerImage.frame.size.width / 2;
    _playerImage.clipsToBounds = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _totalTurns.text = [NSString stringWithFormat:@"%lu", (unsigned long)[_player countTotalTurns]];
    _totalGames.text = [NSString stringWithFormat:@"%lu", (unsigned long)[_player countTotalGames]];
    _sessionScore.text = [NSString stringWithFormat:@"%lu", (unsigned long)[_player todayScore]];
    _sessionMultiplier.text = [NSString stringWithFormat:@"x%lu", (unsigned long)[_player todayMultiplier]];
    if (_player.rank < [_ranks count] - 1) {
        if ([_player countTotalGames] + 1 > [_player gamesNeededForNextRank]) {
            _player.rank += 1;
        }
        _playerRank.text = _ranks[(int)_player.rank];
        _levelUpMotivation.text = [NSString stringWithFormat:@"Play %d more games to take it to the next level", (int)[_player gamesNeededForNextRank] - (int)[_player countTotalGames]];
    } else {
        _playerRank.text = [_ranks lastObject];
        _levelUpMotivation.text = @"You've made it to the top! Congratulations!";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playGame:(id)sender {
    // TODO: Have GVC returned from a GameViewDispatcher object
    MRGameDispatcher *dispatcher = [MRGameDispatcher newDispatcher];
    MRGameViewController *gameViewController = [dispatcher newGame];
    gameViewController.delegate = self;
    gameViewController.multiplier = [_player todayMultiplier];
    [self presentViewController:gameViewController animated:YES completion:nil];
}

- (void)gameViewController:(MRGameViewController *)controller didCompleteGame:(MRRecord *)record {
    [_player addRecordToHistory:record];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
