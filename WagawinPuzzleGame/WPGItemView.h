//
//  WPGItemView.h
//  WagawinPuzzleGame
//
//  Created by Konstantin Efimenko on 6/2/17.
//  Copyright © 2017 Konstantin Efimenko. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WPGItemView;

@protocol WPGItemViewDelegate <NSObject>

- (void)itemView:(WPGItemView*)itemView wasDroppedInPoint:(CGPoint)point;

@end

@interface WPGItemView : UIImageView

@property CGPoint originalPosition;
@property CGPoint currentPosition;
@property (weak) id<WPGItemViewDelegate> delegate;

@end
