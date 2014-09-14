//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Sameer Totey on 9/12/14.
//  Copyright (c) 2014 Sameer Totey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

// designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readonly) NSInteger lastMatchScore;
@property (nonatomic, strong, readonly) NSMutableArray *lastOtherCards;
@property (nonatomic) NSUInteger numMatchMode;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@end
