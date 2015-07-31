//
//  PlayingCardView.h
//  SuperCard
//
//  Created by easonchen on 15/7/27.
//  Copyright (c) 2015年 easonchen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView

@property (nonatomic) NSInteger rank;
@property (strong,nonatomic) NSString *suit;
@property (nonatomic) BOOL faceUp;


- (void)pinch:(UIPinchGestureRecognizer *)gesture;

@end
