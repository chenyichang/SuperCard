//
//  SuperCardViewController.m
//  SuperCard
//
//  Created by easonchen on 15/7/27.
//  Copyright (c) 2015年 ___FULLUSERNAME___. All rights reserved.
//

#import "SuperCardViewController.h"
#import "PlayingCardView.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@interface SuperCardViewController ()
@property (weak, nonatomic) IBOutlet PlayingCardView *playingCardView;

@property (strong,nonatomic) Deck *deck;

@end

@implementation SuperCardViewController

- (Deck *)deck
{
    if (!_deck) {
        _deck=[self createDeck];
    }
    return _deck;
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (void)drawRandomCard
{
    Card *card=[self.deck drawRandomCard];
    if ([card isKindOfClass:[PlayingCard class]]) {
        PlayingCard *playCard=(PlayingCard *)card;
        self.playingCardView.rank=playCard.rank;
        self.playingCardView.suit=playCard.suit;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
   
    [self drawRandomCard];
    [self.playingCardView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self.playingCardView action:@selector(pinch:)]];
}

- (IBAction)swipe:(UISwipeGestureRecognizer *)sender {
    self.playingCardView.faceUp=!self.playingCardView.faceUp;
    if (self.playingCardView.faceUp) {
        [self drawRandomCard];
    }
    
}

@end
