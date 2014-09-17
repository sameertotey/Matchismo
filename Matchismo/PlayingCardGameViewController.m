//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Sameer Totey on 9/16/14.
//  Copyright (c) 2014 Sameer Totey. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController
- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

@end
