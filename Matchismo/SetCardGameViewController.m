//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Sameer Totey on 9/16/14.
//  Copyright (c) 2014 Sameer Totey. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController
- (Deck *)createDeck {
    return [[SetCardDeck alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setGameNumMatchModeWith:3];
}

- (NSAttributedString *)titleForCard:(Card *)card
{
    NSString *symbol = @"?";
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
    
    if ([card isKindOfClass:[SetCard class]]){
        SetCard *setCard = (SetCard *)card;
        
        if (setCard.symbol == oval) symbol = @"●";
        if (setCard.symbol == diamond) symbol = @"▲";
        if (setCard.symbol == squiggle) symbol = @"■";
        
        symbol = [symbol stringByPaddingToLength:setCard.num
                                      withString:symbol
                                 startingAtIndex:0];
        
        if (setCard.color == red)
            [attributes setObject:[UIColor redColor]
                           forKey:NSForegroundColorAttributeName];
        if (setCard.color == green)
            [attributes setObject:[UIColor greenColor]
                           forKey:NSForegroundColorAttributeName];
        if (setCard.color == purple)
            [attributes setObject:[UIColor purpleColor]
                           forKey:NSForegroundColorAttributeName];
        
        if (setCard.shading == solid)
            [attributes setObject:@-5
                           forKey:NSStrokeWidthAttributeName];
        if (setCard.shading == striped)
            [attributes addEntriesFromDictionary:@{
                                                   NSStrokeWidthAttributeName : @-5,
                                                   NSStrokeColorAttributeName : [UIColor blackColor],
                                                   NSForegroundColorAttributeName : [attributes[NSForegroundColorAttributeName] colorWithAlphaComponent:0.1]
                                                   }];
        if (setCard.shading == nothing)
            [attributes setObject:@5 forKey:NSStrokeWidthAttributeName];
        
    }
    
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:symbol attributes:attributes];
    return title;
}


- (void)updateUI {
    [super updateUI];
//    self.flipDescription.attributedText = [self replaceCardDescriptionsInText:self.flipDescription.attributedText];
}

//- (NSAttributedString *)replaceCardDescriptionsInText:(NSAttributedString *)text
//{
//    NSMutableAttributedString *newText = [text mutableCopy];
//    
//    NSArray *setCards = [SetCard cardsFromText:text.string];
//    
//    if (setCards) {
//        for (SetCard *setCard in setCards) {
//            NSRange range = [newText.string rangeOfString:setCard.contents];
//            if (range.location != NSNotFound) {
//                [newText replaceCharactersInRange:range
//                             withAttributedString:[self titleForCard:setCard]];
//            }
//        }
//    }
//    return newText;
//}


- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.chosen ? @"setCardSelected" : @"setcard"];
}


@end
