//
//  SetCard.m
//  Matchismo
//
//  Created by Sameer Totey on 9/16/14.
//  Copyright (c) 2014 Sameer Totey. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

- (NSString *)contents
{
    return nil;
}

+ (BOOL)validSetNum:(SetNum)num
{
    if ((num > 0) && (num <  maxNum)) {
        return YES;
    } else return NO;
}

+ (BOOL)validSetColor:(SetColor)color
{
    if ((color > 0) && (color <  maxColor)) {
        return YES;
    } else return NO;
}

+ (BOOL)validSetShading:(SetShading)shading
{
    if ((shading > 0) && (shading < maxShading)) {
        return YES;
    } else return NO;
}

+ (BOOL)validSetSymbol:(SetSymbol)symbol
{
    if ((symbol > 0) && (symbol < maxSymbol)) {
        return YES;
    } else return NO;
}

- (void)setNum:(SetNum)num
{
    if ([SetCard validSetNum:_num]){
        _num = num;
    }
}

- (void)setColor:(SetColor)color
{
    if ([SetCard validSetColor:color]) {
        _color = color;
    }
}

- (void)setSymbol:(SetSymbol)symbol
{
    if ([SetCard validSetSymbol:symbol]) {
        _symbol = symbol;
    }
}

- (void)setShading:(SetShading)shading
{
    if ([SetCard validSetShading:shading]) {
        _shading = shading;
    }
}


- (int) match:(NSArray *)otherCards {
    int score = 0;
    
    // This matching is done assuming there is only one deck, the logic will be different for more decks
    if ([otherCards count] == 2){
        // anything other than 2 other cards in the other cards is not a match
        SetCard *card1 = [otherCards firstObject];
        SetCard *card2 = [otherCards lastObject];
        if ((((self.num == card1.num) && (self.num == card2.num)) ||
             (self.num != card1.num && self.num != card2.num && card1.num != card2.num)) &&
            (((self.color == card1.color) && (self.color == card2.color)) ||
             (self.color != card1.color && self.color != card2.color && card1.color != card2.num)) &&
            (((self.symbol == card1.symbol) && (self.symbol == card2.symbol)) ||
             (self.symbol != card1.symbol && self.symbol != card2.symbol && card1.symbol != card2.symbol)) &&
            (((self.shading == card1.shading) && (self.shading == card2.shading)) ||
             (self.shading != card1.shading && self.shading != card2.shading && card1.shading != card2.shading)))
        {
            
            score = 1;
        }
    }
    return score;
}


@end
