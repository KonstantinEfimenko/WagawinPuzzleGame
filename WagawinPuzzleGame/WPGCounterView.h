//
//  WPGCounterView.h
//  WagawinPuzzleGame
//
//  Created by Konstantin Efimenko on 6/2/17.
//  Copyright © 2017 Konstantin Efimenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WPGCounterViewDelegate <NSObject>

- (void)onCounterReachEnd;

@end

@interface WPGCounterView : UIView

@property (weak) id<WPGCounterViewDelegate> delegate;

- (void)startCounter;

- (void)stopCounter;

@end
