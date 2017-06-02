//
//  WPGPuzzleView.h
//  WagawinPuzzleGame
//
//  Created by Konstantin Efimenko on 6/2/17.
//  Copyright © 2017 Konstantin Efimenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WPGItemView.h"

@interface WPGPuzzleView : UIView <WPGItemViewDelegate>

- (void)shuffle;

@end
