//
//  WPGViewController.m
//  WagawinPuzzleGame
//
//  Created by Konstantin Efimenko on 6/2/17.
//  Copyright © 2017 Konstantin Efimenko. All rights reserved.
//

#import "WPGViewController.h"
#import "WPGPuzzleView.h"


@interface WPGViewController ()

@end

@implementation WPGViewController
{
    __weak IBOutlet WPGPuzzleView *puzzleView;
    __weak IBOutlet WPGCountDownView *countDownView;
    __weak IBOutlet WPGCounterView *counterView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    countDownView.delegate = self;
    [countDownView startCountDown];
    counterView.delegate = self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma WPGCountDownViewDelegate

- (void)onCountDownReachEnd{
    [puzzleView shuffle];
    [counterView startCounter];
}

#pragma WPGCounterViewDelegate

- (void)onCounterReachEnd{
    //TODO: show relaunch button
}

@end
