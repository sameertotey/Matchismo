//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Sameer Totey on 9/16/14.
//  Copyright (c) 2014 Sameer Totey. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype)init {
    self = [super init];
    
    if (self) {
        for (SetNums num = 1 ; num < maxNum; num++) {
            for (SetColor color = 1; color < maxColor; color++) {
                for (SetSymbol symbol = 1; symbol < maxSymbol; symbol++) {
                    for (SetShading shading = 1; shading < maxShading; shading++) {
                        SetCard *card = [[SetCard alloc] init];
                        card.num  = num;
                        card.color = color;
                        card.symbol = symbol;
                        card.shading = shading;
                        [self addCard:card];
                    }
                }
            }
        }
    }
    return self;
}
@end
