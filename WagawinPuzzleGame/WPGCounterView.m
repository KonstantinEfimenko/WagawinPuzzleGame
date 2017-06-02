//
//  WPGCounterView.m
//  WagawinPuzzleGame
//
//  Created by Konstantin Efimenko on 6/2/17.
//  Copyright © 2017 Konstantin Efimenko. All rights reserved.
//

#import "WPGCounterView.h"

#define SECONDS_FOR_GAME 20
#define COUNTER_COLOR [UIColor colorWithRed:154.0/255.0 green:181.0/255.0 blue:237.0/255.0 alpha:1.0]

@implementation WPGCounterView
{
    UIView *filler;
}

- (void)drawRect:(CGRect)rect {
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = COUNTER_COLOR.CGColor;
}

- (void)startCounter{
    filler = [[UIView alloc] initWithFrame:CGRectMake(3, 3, self.frame.size.width-6, self.frame.size.height-6)];
    filler.backgroundColor = COUNTER_COLOR;
    [self addSubview:filler];
    [UIView animateWithDuration:SECONDS_FOR_GAME animations:^{
        [filler setFrame:CGRectMake(3, self.frame.size.height-6, self.frame.size.width-6, 0)];
    } completion:^(BOOL finished){
        if (_delegate && [_delegate respondsToSelector:@selector(onCounterReachEnd)]) {
            [_delegate onCounterReachEnd];
        }
    }];
    //TODO: add countdown
}

@end
