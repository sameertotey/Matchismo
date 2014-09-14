//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Sameer Totey on 9/12/14.
//  Copyright (c) 2014 Sameer Totey. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (readwrite, nonatomic) NSInteger score;
@property (strong, nonatomic) NSMutableArray *cards;  // of Card
@property (nonatomic, strong, readwrite) NSMutableArray *lastOtherCards; //of cards
@property (nonatomic, readwrite) NSInteger lastMatchScore;
@end

@implementation CardMatchingGame


- (NSMutableArray *)cards {
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck {
    self = [super init];    // super's designated initializer
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
        
    }
    // default numMatchMode to 2
    self.numMatchMode = 2;
    return self;
}

// incase this initializer is called make it fail...
- (instancetype)init {
    return nil;
}

- (NSMutableArray *)lastOtherCards {
    if (!_lastOtherCards) {
        _lastOtherCards = [[NSMutableArray alloc] init];
    }
    return _lastOtherCards;
}

- (void)setNumMatchMode:(NSUInteger)numMatchMode {
    if (_numMatchMode < 2) {
        _numMatchMode = 2;
    } else if (_numMatchMode > [self.cards count]) {
        _numMatchMode = [self.cards count];
    } else {
        _numMatchMode = numMatchMode;
    }
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index {
    
    Card *card = [self cardAtIndex:index];
    
    if(!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            // match other chosen card(s)
            self.lastOtherCards = nil;
            self.lastMatchScore = 0;
            for (Card *othercard in self.cards) {
                if (othercard.isChosen && !othercard.isMatched) {
                    [self.lastOtherCards addObject:othercard];
                    if ([self.lastOtherCards count] + 1 == self.numMatchMode) {
                        // let us attempt a match now that we have enough cards
                        int matchScore = [card match:self.lastOtherCards];
                        if (matchScore) {
                            self.lastMatchScore = matchScore * MATCH_BONUS;
                            for (Card *tempCard in self.lastOtherCards) {
                                tempCard.matched = YES;
                            }
                            card.matched = YES;
                        } else {
                            self.lastMatchScore = -MISMATCH_PENALTY;
                            for (Card *tempCard in self.lastOtherCards) {
                                tempCard.chosen = NO;
                            }
                        }
                        break; // if we attempted one match we are done
                    }
                }
            }
            card.chosen = YES;
            self.score += (self.lastMatchScore - COST_TO_CHOOSE);
        }
    }
}

- (Card *)cardAtIndex:(NSUInteger)index {
    
    return ([self.cards count] > index) ? self.cards[index] : nil;
}

@end
