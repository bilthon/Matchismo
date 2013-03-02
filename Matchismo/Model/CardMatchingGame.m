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
    if(card && !card.isUnplayable){
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
                        self.score -= matchScore * MISMATCH_PENALTY;
                        result = [NSString stringWithFormat:CARD_MISMATCH,card.contents,otherCard.contents];
                    }
                    break;
                }
            }
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.isFaceUp;
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
