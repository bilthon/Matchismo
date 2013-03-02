//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Nelson Perez on 2/24/13.
//  Copyright (c) 2013 Nelson Perez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"
#define TWO_CARDS_MODE 0
#define THREE_CARDS_MODE 1

// designated initiallizer
@interface CardMatchingGame : NSObject

- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(Deck*)deck;

- (NSString*)flipCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

@property (readonly, nonatomic) int score;
@property (nonatomic) int flipCount;
@property (nonatomic) int gameMode;
@end
