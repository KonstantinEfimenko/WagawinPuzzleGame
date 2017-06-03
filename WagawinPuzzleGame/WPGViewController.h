//
//  WPGViewController.h
//  WagawinPuzzleGame
//
//  Created by Konstantin Efimenko on 6/2/17.
//  Copyright © 2017 Konstantin Efimenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WPGCountDownView.h"
#import "WPGCounterView.h"
#import "WPGPuzzleView.h"

@interface WPGViewController : UIViewController <WPGCountDownViewDelegate, WPGCounterViewDelegate, WPGPuzzleViewDelegate>


@end

