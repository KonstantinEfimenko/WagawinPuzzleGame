//
//  WPGCountDownView.h
//  WagawinPuzzleGame
//
//  Created by Konstantin Efimenko on 6/2/17.
//  Copyright © 2017 Konstantin Efimenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WPGCountDownViewDelegate <NSObject>

- (void)onCountDownReachEnd;

@end

@interface WPGCountDownView : UIView

@property (weak) id<WPGCountDownViewDelegate> delegate;

- (void)startCountDown;

@end
