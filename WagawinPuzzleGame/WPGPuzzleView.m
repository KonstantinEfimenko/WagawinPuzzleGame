//
//  WPGPuzzleView.m
//  WagawinPuzzleGame
//
//  Created by Konstantin Efimenko on 6/2/17.
//  Copyright © 2017 Konstantin Efimenko. All rights reserved.
//

#import "WPGPuzzleView.h"

#define HORIZONTAL_ITEMS_COUNT 4
#define VERTICAL_ITEMS_COUNT 3

@implementation WPGPuzzleView
{
    CGFloat itemWidth;
    CGFloat itemHeight;
    UIImage *originalImage;
    NSMutableArray *rightOrderItems;
    CGPoint originalPosition;
    CGPoint touchOffset;
}



- (void)drawRect:(CGRect)rect {
    rightOrderItems = [[NSMutableArray alloc] init];
    originalImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://s3-eu-west-1.amazonaws.com/wagawin-ad-platform/media/testmode/banner-landscape.jpg"]]];
    itemWidth = rect.size.width/HORIZONTAL_ITEMS_COUNT;
    itemHeight = rect.size.height/VERTICAL_ITEMS_COUNT;
    
    for (int x = 0; x < HORIZONTAL_ITEMS_COUNT; x++){
        for (int y = 0; y < VERTICAL_ITEMS_COUNT; y++){
            [self makeItemForHorizontalPosition:x verticalPosition:y];
        }
    }
}


- (void)makeItemForHorizontalPosition:(NSInteger)x verticalPosition:(NSInteger)y{
    CGRect frame = CGRectMake(originalImage.size.width/HORIZONTAL_ITEMS_COUNT*x, originalImage.size.height/VERTICAL_ITEMS_COUNT*y, originalImage.size.width/HORIZONTAL_ITEMS_COUNT, originalImage.size.height/VERTICAL_ITEMS_COUNT);
    CGImageRef itemImageRef = CGImageCreateWithImageInRect(originalImage.CGImage, frame);
    UIImage *itemImage = [UIImage imageWithCGImage:itemImageRef];
    
    CGRect itemFrame =  CGRectMake(itemWidth*x, itemHeight*y, itemWidth, itemHeight);
    
    WPGItemView* itemImageView = [[WPGItemView alloc] initWithImage:itemImage];
    itemImageView.frame = itemFrame;
    itemImageView.userInteractionEnabled = YES;
    itemImageView.delegate = self;
    [rightOrderItems addObject:itemImageView];
    itemImageView.originalPosition = itemImageView.center;
}


- (void)shuffle{
    NSInteger itemsCount = HORIZONTAL_ITEMS_COUNT*VERTICAL_ITEMS_COUNT;
    NSMutableSet*shuffledItemsSet = [[NSMutableSet alloc]init];
    NSMutableArray*shuffledItems = [[NSMutableArray alloc]init];
    while (shuffledItems.count<itemsCount){
        WPGItemView *view = rightOrderItems[random()%itemsCount];
        if(![shuffledItemsSet containsObject:view]){
            [shuffledItemsSet addObject:view];
            [shuffledItems addObject:view];
        }
    }
    for (UIView *view in rightOrderItems){
        [view removeFromSuperview];
    }
    NSInteger num = 0;
    for (int x = 0; x < HORIZONTAL_ITEMS_COUNT; x++){
        for (int y = 0; y < VERTICAL_ITEMS_COUNT; y++){
            WPGItemView *item = shuffledItems[num++];
            [item setFrame:CGRectMake(itemWidth*x, itemHeight*y, itemWidth, itemHeight)];
            item.currentPosition = item.center;
            [self addSubview:item];
        }
    }
}


- (void)itemView:(WPGItemView *)itemView wasDroppedInPoint:(CGPoint)point{
    WPGItemView *itemHere = [self getItemAtPoint:point butNot:itemView];
    if(itemHere){
        [UIView animateWithDuration:0.1 animations:^{
            itemHere.center = itemView.currentPosition;
            itemView.center = itemHere.currentPosition;
        }];
        CGPoint itemViewCenter = itemView.currentPosition;
        itemView.currentPosition = itemHere.currentPosition;
        itemHere.currentPosition = itemViewCenter;
        [self checkIfPuzzleComplete];
    }else{
        [UIView animateWithDuration:0.1 animations:^{
            itemView.center = itemView.currentPosition;
        }];
    }
}


-(WPGItemView *) getItemAtPoint:(CGPoint)point butNot:(WPGItemView*)notItem{
    CGRect touchRect = CGRectMake(point.x, point.y, 1.0, 1.0);
    
    for(WPGItemView *item in self.subviews){
        if( CGRectIntersectsRect(item.frame, touchRect) && item!=notItem){
            return item;
        }		
    }
    return nil;
}


- (void)checkIfPuzzleComplete{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"originalPosition!=currentPosition"];
    NSArray*itemsWithWrongPosition = [rightOrderItems filteredArrayUsingPredicate:predicate];
    if(itemsWithWrongPosition.count==0){
        if(_delegate && [_delegate respondsToSelector:@selector(onPuzzleComplete)]){
            [_delegate onPuzzleComplete];
        }
    }
}

@end
