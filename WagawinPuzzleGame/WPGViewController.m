//
//  WPGViewController.m
//  WagawinPuzzleGame
//
//  Created by Konstantin Efimenko on 6/2/17.
//  Copyright © 2017 Konstantin Efimenko. All rights reserved.
//

#import "WPGViewController.h"
#import "AppDelegate.h"

@interface WPGViewController ()

@end

@implementation WPGViewController
{
    __weak IBOutlet UIImageView *previewImage;
    __weak IBOutlet WPGPuzzleView *puzzleView;
    __weak IBOutlet WPGCountDownView *countDownView;
    __weak IBOutlet WPGCounterView *counterView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    puzzleView.delegate = self;
    AppDelegate *appDelegate = (AppDelegate*)([UIApplication sharedApplication].delegate);
    puzzleView.originalImage = appDelegate.originalImage;
    previewImage.image = appDelegate.originalImage;
    countDownView.delegate = self;
    [countDownView startCountDown];
    counterView.delegate = self;
    [self prepareGradient];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareGradient{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    //gradient.set
    gradient.frame = self.view.bounds;
    gradient.colors = @[(id)[UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1].CGColor,
                        (id)[UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1].CGColor,
                        (id)[UIColor colorWithRed:253.0/255.0 green:253.0/255.0 blue:253.0/255.0 alpha:1].CGColor];
    [gradient setStartPoint:CGPointMake(0, 1)];
    [gradient setLocations:@[@(0.0),@(0.09),@(1.0)]];
    [gradient setEndPoint:CGPointMake(1, 0)];
    [self.view.layer insertSublayer:gradient atIndex:0];
}


- (IBAction)onCancelButtonClicked:(id)sender {
    [counterView stopCounter];
    [self showMessage:@"Game was canceled"];
}


- (void)showMessage:(NSString*)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"New game" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        [previewImage setHidden:NO];
        [countDownView startCountDown];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark WPGCountDownViewDelegate

- (void)onCountDownReachEnd{
    [previewImage setHidden:YES];
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
