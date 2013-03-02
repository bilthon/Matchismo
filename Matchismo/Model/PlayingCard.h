//
//  PlayingCard.h
//  Matchismo
//
//  Created by Nelson Perez on 2/20/13.
//  Copyright (c) 2013 Nelson Perez. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;
+ (NSArray*) validSuits;
+ (NSUInteger) maxRank;

@end
