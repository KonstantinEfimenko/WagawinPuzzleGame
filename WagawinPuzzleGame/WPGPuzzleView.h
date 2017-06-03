//
//  WPGPuzzleView.h
//  WagawinPuzzleGame
//
//  Created by Konstantin Efimenko on 6/2/17.
//  Copyright © 2017 Konstantin Efimenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WPGItemView.h"

@protocol WPGPuzzleViewDelegate <NSObject>

- (void)onPuzzleComplete;

@end

@interface WPGPuzzleView : UIView <WPGItemViewDelegate>

@property (weak) id<WPGPuzzleViewDelegate> delegate;

- (void)shuffle;

@end
