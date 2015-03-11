//
//  MRPlayerViewController.m
//  Whitewash
//
//  Created by Allan Lasser on 3/9/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import "MRPlayerViewController.h"

#import "MRPlayer.h"
#import "mRRecord.h"
#import "MRGameViewController.h"

@interface MRPlayerViewController ()

@property (nonatomic, strong) MRPlayer *player;
@property (weak, nonatomic) IBOutlet UILabel *playerName;
@property (weak, nonatomic) IBOutlet UILabel *turnsPlayedCounter;
@property (weak, nonatomic) IBOutlet UILabel *gamesPlayedCounter;

@end

@implementation MRPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _player = [MRPlayer newPlayerWithName:@"Allan Lasser"];
    _playerName.text = _player.name;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSInteger gamesPlayed = 0;
    NSInteger turnsPlayed = 0;
    for (MRRecord *record in _player.history) {
        gamesPlayed += 1;
        turnsPlayed += [record.turns count];
    }
    _gamesPlayedCounter.text = [NSString stringWithFormat:@"%li", gamesPlayed];
    _turnsPlayedCounter.text = [NSString stringWithFormat:@"%li", turnsPlayed];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playGame:(id)sender {
    // TODO: Have GVC returned from a GameViewDispatcher object
    MRGameViewController *gameViewController = [[MRGameViewController alloc] initWithNibName:@"MRGameViewController" bundle:[NSBundle mainBundle]];
    gameViewController.delegate = self;
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
