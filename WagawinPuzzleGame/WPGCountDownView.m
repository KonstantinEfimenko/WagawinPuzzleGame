//
//  WPGCountDownView.m
//  WagawinPuzzleGame
//
//  Created by Konstantin Efimenko on 6/2/17.
//  Copyright © 2017 Konstantin Efimenko. All rights reserved.
//

#import "WPGCountDownView.h"

#define SECONDS 3

@implementation WPGCountDownView
{
    int secondsLeft;
    UILabel*textLabel;
}

- (void)startCountDown{
    [self setHidden:NO];
    textLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width-50)/2, (self.frame.size.height-50)/2, 50, 50)];
    [textLabel setTextColor:[UIColor whiteColor]];
    [textLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:textLabel];
    textLabel.font = [UIFont boldSystemFontOfSize:50];
    secondsLeft = SECONDS;
    [self animateNextNumber];
}

- (void)animateNextNumber{
    textLabel.text = [NSString stringWithFormat:@"%d",secondsLeft];
    [UIView animateWithDuration:1.0 animations:^{
        textLabel.transform = CGAffineTransformScale(textLabel.transform, 5, 5);
    } completion:^(BOOL complete){
        if(--secondsLeft>0){
            textLabel.transform = CGAffineTransformScale(textLabel.transform, 0.2, 0.2);
            [self animateNextNumber];
        }else{
            textLabel.text = @"";
            [self setHidden:YES];
            if(_delegate && [_delegate respondsToSelector:@selector(onCountDownReachEnd)]){
                [_delegate onCountDownReachEnd];
            }
        }
    }];
}

@end
