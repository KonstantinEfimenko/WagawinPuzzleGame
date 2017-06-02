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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    countDownView.delegate = self;
    [countDownView startCountDown];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma WPGCountDownViewDelegate

- (void)onCountDownReachEnd{
    [puzzleView shuffle];
}

@end
