//
//  Deck.h
//  Matchismo
//
//  Created by Nelson Perez on 2/20/13.
//  Copyright (c) 2013 Nelson Perez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject
- (void) addCard:(Card *)card atTop:(BOOL)atTop;
- (Card*) drawRandomCard;
@end
