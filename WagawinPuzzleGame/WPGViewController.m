//
//  WPGViewController.m
//  WagawinPuzzleGame
//
//  Created by Konstantin Efimenko on 6/2/17.
//  Copyright © 2017 Konstantin Efimenko. All rights reserved.
//

#import "WPGViewController.h"

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
    puzzleView.delegate = self;
    countDownView.delegate = self;
    [countDownView startCountDown];
    counterView.delegate = self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)showMessage:(NSString*)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"New game" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        [countDownView startCountDown];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark WPGCountDownViewDelegate

- (void)onCountDownReachEnd{
    [puzzleView shuffle];
    [counterView startCounter];
}

#pragma mark WPGCounterViewDelegate

- (void)onCounterReachEnd{
    [self showMessage:@"Game over!"];
}

#pragma mark WPGPuzzleViewDelegate

- (void)onPuzzleComplete{
    [counterView stopCounter];
    [self showMessage:@"You won!"];
}

@end
