//
//  MRPlayerViewController.m
//  Whitewash
//
//  Created by Allan Lasser on 3/9/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import "MRPlayerViewController.h"

#import "MRPlayer.h"

@interface MRPlayerViewController ()

@property (nonatomic, strong) MRPlayer *player;
@property (weak, nonatomic) IBOutlet UILabel *playerName;

@end

@implementation MRPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.player = [MRPlayer newPlayerWithName:@"Allan Lasser"];
    self.playerName.text = self.player.name;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
