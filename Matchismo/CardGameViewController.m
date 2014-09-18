//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Sameer Totey on 9/11/14.
//  Copyright (c) 2014 Sameer Totey. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"
#import "ShowActivityHistoryViewController.h"

@interface CardGameViewController ()
@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) Card *lastTouchedCard;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameSegmentedControl;
@property (strong, nonatomic) NSMutableArray *history; //of description (NSStrings)
@property (weak, nonatomic) IBOutlet UISlider *historySlider;
@property (strong, nonatomic) NSString *actionDescription;
@end

@implementation CardGameViewController


- (NSMutableArray *)history {
    if (!_history) {
        _history = [[NSMutableArray alloc] init];
    }
    return _history;
}

- (IBAction)touchDealButton:(id)sender {
    // reset the game object - this will start a new game the next time
    self.game = nil;
    self.history = nil;
    [self updateUI];
    self.gameSegmentedControl.enabled = YES;
}

- (IBAction)valueChangedForSegmentedControl:(UISegmentedControl *)sender {
    if (self.gameSegmentedControl.selectedSegmentIndex == 0) {
        self.game.numMatchMode = 2;
    } else {
        self.game.numMatchMode = 3;
    }
}

- (CardMatchingGame *)game {
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:
                 [self.cardButtons count] usingDeck:[self createDeck]];
    }
    return _game;
}

- (Deck *)createDeck     // abstract
{
    return nil;
}

- (void)setGameNumMatchModeWith:(NSUInteger)num
{
    self.game.numMatchMode = num;
}

- (IBAction)touchCardButton:(UIButton *)sender {
    if (self.gameSegmentedControl.enabled) {
        self.gameSegmentedControl.enabled = NO;
    }
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    self.lastTouchedCard = [self.game cardAtIndex:chosenButtonIndex];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
 }

- (void)updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld",
                            (long)self.game.score];
    [self setActionDescription];
    [self.historySlider setValue:1.0 animated:YES];
    [self updateDescriptionLabelText:[self.history count]];
}

- (void)setTitleForCard:(Card *)card
{
}

- (NSAttributedString *)titleForCard:(Card *)card {
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:card.chosen ? card.contents : @""];
    return title;
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.chosen ? @"cardfront" : @"cardback"];
}

- (IBAction)valueChangedForSlider:(UISlider *)sender {
    [self updateDescriptionLabelText:(long)[sender value] * [self.history count]];
}

- (void) updateDescriptionLabelText:(long)index {
    if (index < 0) {
        index = 0;
    }else if (index >= [self.history count]) {
        index = [self.history count] -1;
    }
    self.descriptionLabel.text = [self.history objectAtIndex:index];
}

- (void) setActionDescription {
    NSString *otherCards = [self.game.lastOtherCards componentsJoinedByString:@","];
    
    if (self.game.lastMatchScore > 0) {
        self.actionDescription = [NSString stringWithFormat:@"Matched %@%@ for %ld points", self.lastTouchedCard.contents, otherCards, (long)self.game.lastMatchScore];
    } else if (self.game.lastMatchScore < 0 ) {
        self.actionDescription = [NSString stringWithFormat:@"%@%@ don't match %ld point penalty!", self.lastTouchedCard.contents, otherCards, (long)self.game.lastMatchScore];
    } else {
        self.actionDescription = self.lastTouchedCard.contents;
    }
    
    [self.history addObject:self.actionDescription];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"isShowHistory"]) {
        if ([segue.destinationViewController isKindOfClass:[ShowActivityHistoryViewController class]]) {
            ShowActivityHistoryViewController *ahvc = (ShowActivityHistoryViewController *)segue.destinationViewController;
            ahvc.history = self.history;
        }
    }
}



@end
