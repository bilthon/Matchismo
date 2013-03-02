//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Nelson Perez on 2/24/13.
//  Copyright (c) 2013 Nelson Perez. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (readwrite,nonatomic) int score;
@property (strong,nonatomic) NSMutableArray *cards; // of Card
@end

@implementation CardMatchingGame

-(void) setGameMode:(int)gameMode{
    NSLog(@"Game mode changed");
    _gameMode = gameMode;
}

- (NSMutableArray*) cards{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

#define SIMPLE_FLIP @"Flipped up %@"
#define CARD_MATCH @"Matched %@ and %@ for 4 points"
#define CARD_MISMATCH @"%@ and %@ don't match! 2 point penalty!"

- (NSString*) flipCardAtIndex:(NSUInteger)index{
    Card * card = [self cardAtIndex:index];
    NSString * result = [NSString stringWithFormat:SIMPLE_FLIP,card.contents];
    if(self.gameMode == TWO_CARDS_MODE && card){
        /* Two cards mode */
        if(!card.isUnplayable){
            if(!card.isFaceUp){
                for(Card * otherCard in self.cards){
                    if(otherCard.isFaceUp && !otherCard.isUnplayable){
                        int matchScore = [card match:@[otherCard]];
                        if(matchScore){
                            self.score += matchScore;
                            card.unplayable = YES;
                            otherCard.unplayable = YES;
                            result = [NSString stringWithFormat:CARD_MATCH,card.contents,otherCard.contents];
                        }else{
                            otherCard.faceUp = NO;
                            self.score -=  MISMATCH_PENALTY;
                            result = [NSString stringWithFormat:CARD_MISMATCH,card.contents,otherCard.contents];
                        }
                        break;
                    }
                }
                self.score -= FLIP_COST;
            }
            card.faceUp = !card.faceUp;
        }
    }else if(card){
        /* Three cards mode */
        if(!card.isUnplayable){
            card.faceUp = !card.isFaceUp;
            /* Check if we flipped 3 cards already */
            if(self.flipCount != 0 && self.flipCount % 3 == 0){
                NSMutableArray * playingCards = [NSMutableArray arrayWithCapacity:3];
                for(Card * selectedCard in self.cards){
                    if(selectedCard.isFaceUp && !selectedCard.isUnplayable){
                        [playingCards addObject:selectedCard];
                    }
                }
                int matchScore = [card match:playingCards];
                if(matchScore){
                    self.score += matchScore;
                    for(Card * selectedCard in playingCards)
                        selectedCard.unplayable = YES;
                    result = @"Cards match!";
                }else{
                    self.score -=  MISMATCH_PENALTY;
                    for(Card * selectedCard in playingCards)
                        selectedCard.faceUp = NO;
                    result = @"Cards don't match";
                }
            }
        }
    }
    return result;
}


- (Card*) cardAtIndex:(NSUInteger)index{
    return (index < [self.cards count] ? self.cards[index] : nil);
}

- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(Deck *)deck{
    self = [super init];
    if(self){
        self.score = 0;
        for(int i = 0; i < count; i++){
            Card * card = [deck drawRandomCard];
            if(card){
                self.cards[i] = card;
            }else{
                self = nil;
                break;
            }
        }
    }
    return self;
}
@end
