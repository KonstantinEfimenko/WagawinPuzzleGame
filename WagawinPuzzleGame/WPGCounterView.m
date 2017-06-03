//
//  WPGCounterView.m
//  WagawinPuzzleGame
//
//  Created by Konstantin Efimenko on 6/2/17.
//  Copyright © 2017 Konstantin Efimenko. All rights reserved.
//

#import "WPGCounterView.h"

#define SECONDS_FOR_GAME 20
#define FILLER_INDENT 3
#define COUNTER_COLOR [UIColor colorWithRed:154.0/255.0 green:181.0/255.0 blue:237.0/255.0 alpha:1.0]

@implementation WPGCounterView
{
    UIView *filler;
    NSTimer *countDownTimer;
    UILabel *countDownLabel;
    NSInteger countDownValue;
}

- (void)drawRect:(CGRect)rect {
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = COUNTER_COLOR.CGColor;
}

- (void)startCounter{
    [self startFiller];
    [self startCountDown];
}


- (void)stopCounter{
    [self.layer removeAllAnimations];
    [countDownTimer invalidate];
}


- (void)startFiller{
    CGSize frameSize = self.frame.size;
    filler = [[UIView alloc] initWithFrame:CGRectMake(FILLER_INDENT, FILLER_INDENT, frameSize.width-FILLER_INDENT*2, frameSize.height-FILLER_INDENT*2)];
    filler.backgroundColor = COUNTER_COLOR;
    [self addSubview:filler];
    
    [UIView animateWithDuration:SECONDS_FOR_GAME animations:^{
        [filler setFrame:CGRectMake(FILLER_INDENT, frameSize.height-FILLER_INDENT, frameSize.width-FILLER_INDENT, 0)];
    } completion:^(BOOL finished){
        if (_delegate && [_delegate respondsToSelector:@selector(onCounterReachEnd)]) {
            [_delegate onCounterReachEnd];
            [self stopCounter];
        }
    }];
}


- (void)startCountDown{
    countDownValue = SECONDS_FOR_GAME;
    CGFloat edge = self.frame.size.width;
    countDownLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,self.frame.size.height-edge,edge,edge)];
    [countDownLabel setTextAlignment:NSTextAlignmentCenter];
    [countDownLabel setTextColor:[UIColor whiteColor]];
    [countDownLabel setFont:[UIFont boldSystemFontOfSize:edge-8]];
    [self addSubview:countDownLabel];
    [self changeCountDownValue];
    [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(changeCountDownValue)
                                   userInfo:nil
                                    repeats:YES];
}


- (void)changeCountDownValue{
    countDownLabel.text = [NSString stringWithFormat:@"%d",countDownValue--];
}

@end
