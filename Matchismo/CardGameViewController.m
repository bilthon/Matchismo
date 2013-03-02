//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Nelson Perez on 2/19/13.
//  Copyright (c) 2013 Nelson Perez. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
//@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame * game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@end

@implementation CardGameViewController

- (CardMatchingGame*) game{
    if(!_game) _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                         usingDeck:[[PlayingCardDeck alloc] init]];
    return _game;
}

- (IBAction)changeGameMode:(UISegmentedControl *)sender {
    NSInteger * index = [sender selectedSegmentIndex];
    if(index == 0)
        [self.game setGameMode:TWO_CARDS_MODE];
    else
        [self.game setGameMode:THREE_CARDS_MODE];
        
}

- (void) setCardButtons:(NSArray *)cardButtons {
    _cardButtons = cardButtons;
}
- (IBAction)dealCard:(id)sender {
    [self.game initWithCardCount:[self.cardButtons count] usingDeck:[[PlayingCardDeck alloc] init]];
    [self.game setFlipCount:0];
    [self updateUI:@""];
}

-(void) updateUI:(NSString*)result{
    [self.resultLabel setText:result];
    for(UIButton * cardButton in self.cardButtons){
        Card * card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d",self.game.score];
        self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d",self.game.flipCount];
    }
}

- (IBAction)flipCard:(UIButton *)sender {
    NSString * result = [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    [self.game setFlipCount:self.game.flipCount+1];
    [self updateUI:result];
}

@end
