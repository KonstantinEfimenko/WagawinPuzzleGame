//
//  WPGItemView.m
//  WagawinPuzzleGame
//
//  Created by Konstantin Efimenko on 6/2/17.
//  Copyright © 2017 Konstantin Efimenko. All rights reserved.
//

#import "WPGItemView.h"
#import "WPGCountDownView.h"

@implementation WPGItemView
{
    CGPoint touchOffset;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.superview bringSubviewToFront:self];
    CGPoint position = [[touches anyObject] locationInView: self.superview];
    touchOffset = CGPointMake(self.center.x-position.x,self.center.y-position.y);
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint position = [touch locationInView: self.superview];
    
    [UIView animateWithDuration:.001
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^ {
                         
                         self.center = CGPointMake(position.x+touchOffset.x, position.y+touchOffset.y);
                     }
                     completion:^(BOOL finished) {}];
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint position = [[touches anyObject] locationInView: self.superview];
    if(_delegate && [_delegate respondsToSelector:@selector(itemView:wasDroppedInPoint:)]){
        [_delegate itemView:self wasDroppedInPoint:position];
    }
}

@end
