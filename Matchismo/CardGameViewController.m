//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Sameer Totey on 9/11/14.
//  Copyright (c) 2014 Sameer Totey. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) Card *lastTouchedCard;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISwitch *gameSelectorSwitch;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@end

@implementation CardGameViewController

- (IBAction)touchDealButton:(id)sender {
    // reset the game object - this will start a new game the next time
    self.game = nil;
    [self updateUI];
    self.gameSelectorSwitch.enabled = YES;
}

- (CardMatchingGame *)game {
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:
                 [self.cardButtons count] usingDeck:[self createDeck]];
    }
    return _game;
}

- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    if (self.gameSelectorSwitch.enabled) {
        self.gameSelectorSwitch.enabled = NO;
    }
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    self.lastTouchedCard = [self.game cardAtIndex:chosenButtonIndex];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
 }

- (IBAction)valueChangedForGameMatcher:(UISwitch *)sender {
    // for now the value of on means turn on 3 player mode
    if (self.gameSelectorSwitch.on) {
        self.game.numMatchMode = 3;
    } else {
        self.game.numMatchMode = 2;
    }
}

- (void)updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld",
                            (long)self.game.score];
    [self setDescription];
    
}

- (NSString *)titleForCard:(Card *)card {
    return card.chosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.chosen ? @"cardfront" : @"cardback"];
}

- (void) setDescription {
    self.descriptionLabel.text = [NSString stringWithFormat:@"Scored: %ld", (long)self.game.lastMatchScore];
    
    if (self.game.lastMatchScore > 0) {
        self.descriptionLabel.text = [NSString stringWithFormat:@"Matched %@%@ for %ld points", self.lastTouchedCard.contents, [[self.game.lastOtherCards firstObject] contents], (long)self.game.lastMatchScore];
    } else if (self.game.lastMatchScore < 0 ) {
        self.descriptionLabel.text = [NSString stringWithFormat:@"%@%@ don't match %ld point penalty!", self.lastTouchedCard.contents, [[self.game.lastOtherCards firstObject] contents], (long)self.game.lastMatchScore];
    } else {
        self.descriptionLabel.text = self.lastTouchedCard.contents;
    }
    
}

@end
