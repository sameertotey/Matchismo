//
//  Deck.m
//  Matchismo
//
//  Created by Sameer Totey on 9/11/14.
//  Copyright (c) 2014 Sameer Totey. All rights reserved.
//

#import "Deck.h"
#import "Card.h"

@interface Deck()
@property (nonatomic, strong) NSMutableArray *cards;  // of Cards
@end

@implementation Deck

- (NSMutableArray *)cards {
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (void)addCard:(Card *)card atTop:(BOOL)atTop  {
    if (atTop) {
        [self.cards insertObject:card atIndex:0];
    } else {
        [self.cards addObject:card];
    }
}

- (void)addCard:(Card *)card {
    [self addCard:card atTop:NO];
}

- (Card *)drawRandomCard {
    Card *randomCard = nil;
    if ([self.cards count]) {
        unsigned index = arc4random() % [self.cards count];
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    
    return randomCard;
}
@end
