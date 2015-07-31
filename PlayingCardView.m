//
//  PlayingCardView.m
//  SuperCard
//
//  Created by easonchen on 15/7/27.
//  Copyright (c) 2015年 easonchen. All rights reserved.
//

#import "PlayingCardView.h"

@interface PlayingCardView()

@property (nonatomic) CGFloat faceCardScaleFactor;

@end

@implementation PlayingCardView

#pragma mark -Propertys

- (void)setRank:(NSInteger)rank
{
    _rank=rank;
    [self setNeedsDisplay];
}

- (void)setSuit:(NSString *)suit
{
    _suit=suit;
    [self setNeedsDisplay];
}
- (void)setFaceUp:(BOOL)faceUp
{
    _faceUp=faceUp;
    [self setNeedsDisplay];
}

//pinch gesture implement
- (void)pinch:(UIPinchGestureRecognizer *)gesture
{
    if ((gesture.state==UIGestureRecognizerStateChanged)||(gesture.state==UIGestureRecognizerStateEnded)) {
        self.faceCardScaleFactor*=gesture.scale;
        gesture.scale=1.0;
    }
}

#define DEFAULT_FACE_CARD_SCALE_FACTOR 0.90

@synthesize faceCardScaleFactor=_faceCardScaleFactor;

- (CGFloat)faceCardScaleFactor
{
    if (!_faceCardScaleFactor) {
        _faceCardScaleFactor=DEFAULT_FACE_CARD_SCALE_FACTOR;
    }
    return _faceCardScaleFactor;
}

- (void)setFaceCardScaleFactor:(CGFloat)faceCardScaleFactor
{
    _faceCardScaleFactor=faceCardScaleFactor;
    [self setNeedsDisplay];
}

#pragma mark -Drawing

#define CORNER_FONT_STANDAND_HEIGHT 180.0
#define CORNER_RADIUS 12.0

- (CGFloat)CornerScaleFactor{return self.bounds.size.height/CORNER_FONT_STANDAND_HEIGHT;}
- (CGFloat)CornerRadius{return CORNER_RADIUS*[self CornerScaleFactor];}
- (CGFloat)CornerOffest{return [self CornerRadius]/3.0;}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    UIBezierPath *roundedRect=[UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self CornerRadius]];
    
    [roundedRect addClip];
    
    [[UIColor whiteColor] setFill];
    //UIRectFill(self.bounds);
    [roundedRect fill];
    
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
    
    UIImage *faceUpImage=[UIImage imageNamed:[NSString stringWithFormat:@"%@%@",[self rankAsString],self.suit]];
    if (self.faceUp) {
        if (faceUpImage) {
            CGRect imageRect=CGRectInset(self.bounds, self.bounds.size.width*(1.0-self.faceCardScaleFactor), self.bounds.size.height*(1.0-self.faceCardScaleFactor));
            [faceUpImage drawInRect:imageRect];
        }
        else{
            [self drawPips];
        }
        [self drawCorners];
    }
    else{
        UIImage *backaUpImage=[UIImage imageNamed:@"backUp"];
        [backaUpImage drawInRect:self.bounds];
    }
    
}

- (void)drawPips
{

};

- (NSString *)rankAsString
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"][self.rank];
}

- (void)drawCorners
{
    NSMutableParagraphStyle *paragraphStyle=[[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment=NSTextAlignmentCenter;
    
    UIFont *cornerFont=[UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    cornerFont=[cornerFont fontWithSize:cornerFont.pointSize*[self CornerScaleFactor]];
    
    NSMutableAttributedString *cornerText=[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@",[self rankAsString],self.suit] attributes:@{NSFontAttributeName:cornerFont,NSParagraphStyleAttributeName:paragraphStyle}];
    
    CGRect textBounds;
    textBounds.origin=CGPointMake([self CornerOffest], [self CornerOffest]);
    textBounds.size=[cornerText size];
    [cornerText drawInRect:textBounds];
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
    CGContextRotateCTM(context, M_PI);
    [cornerText drawInRect:textBounds];
}

#pragma mark -Initialization

- (void)setUp
{
    self.backgroundColor=nil;
    self.opaque=NO;
    self.contentMode=UIViewContentModeRedraw;
}

- (void)awakeFromNib
{
    [self setUp];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

@end
