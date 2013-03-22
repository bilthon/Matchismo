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
#import "GameResult.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
//@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame * game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeSelector;
@property (strong, nonatomic) GameResult *gameResult;
@end

@implementation CardGameViewController

-(GameResult*)gameResult{
    if(!_gameResult) _gameResult = [[GameResult alloc] init];
    return _gameResult;
}

- (CardMatchingGame*) game {
    if(!_game) _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                         usingDeck:[[PlayingCardDeck alloc] init]];
    return _game;
}

- (IBAction)changeGameMode:(UISegmentedControl *)sender {
    NSInteger index = [sender selectedSegmentIndex];
    if(index == 0)
        [self.game setGameMode:TWO_CARDS_MODE];
    else
        [self.game setGameMode:THREE_CARDS_MODE];
        
}

- (void) viewDidLoad{
    [super viewDidLoad];
    [self.game initWithCardCount:[self.cardButtons count] usingDeck:[[PlayingCardDeck alloc] init]];
    [self updateUI:@""];
}

- (void) setCardButtons:(NSArray *)cardButtons {
    _cardButtons = cardButtons;
}
- (IBAction)dealCard:(id) sender {
//    [self.game initWithCardCount:[self.cardButtons count] usingDeck:[[PlayingCardDeck alloc] init]];
//    [self.game setFlipCount:0];
//    [self changeGameMode:0];
//    [self updateUI:@""];
    self.game = nil;
    self.gameResult = nil;
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
        if(card.isFaceUp) {
            [cardButton setImage:nil forState:UIControlStateNormal];
        } else {
            [cardButton setImage:[UIImage imageNamed:@"cardback.jpg"] forState:UIControlStateNormal];
        }
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d",self.game.score];
        self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d",self.game.flipCount];
    }
    BOOL enableSegment = YES;
    if (self.game.flipCount > 0) {
        enableSegment = NO;
    }else{
        [self.gameModeSelector setSelectedSegmentIndex:0];
    }
    for(int i = 0; i < self.gameModeSelector.numberOfSegments; i++)
        [self.gameModeSelector setEnabled:enableSegment forSegmentAtIndex:i];
}

- (IBAction)flipCard:(UIButton *)sender {
    [self.game setFlipCount:self.game.flipCount+1];
    NSString * result = [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    [self updateUI:result];
    self.gameResult.score = self.game.score;
}

@end
