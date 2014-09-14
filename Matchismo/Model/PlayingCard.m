//
//  PlayingCard.m
//  Matchismo
//
//  Created by Sameer Totey on 9/11/14.
//  Copyright (c) 2014 Sameer Totey. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (NSString *) contents {
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

+ (NSArray *)validSuits {
    return @[@"♣️", @"♥️",@"♠️",@"♦️"];
}

+ (NSUInteger)maxRank {
    return [[self rankStrings] count] -1;
}

+ (NSArray *)rankStrings {
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

@synthesize suit = _suit;   // because we set both getter and setter

- (void)setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit]) {
         _suit = suit;
    }
}

- (NSString *)suit {
    return _suit ? _suit : @"?";
}

- (void)setRank:(NSUInteger)rank {
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

- (int) match:(NSArray *)otherCards {
    int score = 0;
    
    // This matching is done assuming there is only one deck, the logic will be different for more decks
    if ([otherCards count] == 1){
        PlayingCard *card = [otherCards firstObject];
        // since we only have one deck either the suit will match or the rank never both
        if ([card.suit isEqualToString:self.suit]) {
            score = 1;
        } else if (card.rank == self.rank) {
            score = 4;
        }
    } else if ([otherCards count] == 2){
        PlayingCard *card1 = [otherCards firstObject];
        PlayingCard *card2 = [otherCards lastObject];
        if ((self.rank == card1.rank) && (self.rank == card2.rank)) {
            score = 10;
        } else if ([card1.suit isEqualToString:self.suit] &&
                   [card2.suit isEqualToString:self.suit]){
            score = 5;
        } else if ((card1.rank == self.rank) || (card2.rank == self.rank) ||
                (card2.rank == card1.rank)) {
                    score = 2;
        } else if (([card1.suit isEqualToString:self.suit]) ||
            ([card2.suit isEqualToString:self.suit]) || ([card1.suit isEqualToString:card2.suit])) {
                score = 1;
        }
    }
    return score;
}


@end
