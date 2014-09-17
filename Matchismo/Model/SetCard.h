//
//  SetCard.h
//  Matchismo
//
//  Created by Sameer Totey on 9/16/14.
//  Copyright (c) 2014 Sameer Totey. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

typedef enum {
    one = 1,
    two,
    three,
    maxNum
} SetNum;

typedef enum {
    red = 1,
    green,
    purple,
    maxColor
} SetColor;

typedef enum {
    solid = 1,
    striped,
    nothing,
    maxShading
} SetShading;

typedef enum {
    diamond = 1,
    squiggle,
    oval,
    maxSymbol
} SetSymbol;


@property (nonatomic) SetNum num;
@property (nonatomic) SetColor color;
@property (nonatomic) SetShading shading;
@property (nonatomic) SetSymbol symbol;

+ (BOOL)validSetNum:(SetNum)num;
+ (BOOL)validSetColor:(SetColor)color;
+ (BOOL)validSetShading:(SetShading)shading;
+ (BOOL)validSetSymbol:(SetSymbol)symbol;


@end
