//
//  PlayingCard.m
//  Matchismo
//
//  Created by Nelson Perez on 2/20/13.
//  Copyright (c) 2013 Nelson Perez. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

/**
 *  ++++++++++++ Point system ++++++++++++
 *  _______________________________________
 * |            |             |            |
 * |            |  Same suit  |  Same rank |
 * |____________|_____________|____________|
 * | 2 out of 2 |     2       |     4      |
 * |------------+-------------+------------|
 * | 2 out of 3 |     1       |     3      |
 * |------------+-------------+------------|
 * | 3 out of 3 |     8       |     16     |
 * +------------+-------------+------------+
 */
- (int) match:(NSArray*)otherCards{
    int score = 0;
    if(![[otherCards lastObject] isMemberOfClass:[PlayingCard class]])
        return score;
    /* 2-cards-match mode */
    if([otherCards count] == 1){
        PlayingCard * otherCard = [otherCards lastObject];
        if([otherCard.suit isEqualToString:self.suit]){
            score = 2;
        }else if(otherCard.rank == self.rank){
            score = 4;
        }
    }else {
        /* 3-cars-match mode */
        int suitMatch = 0;
        int rankMatch = 0;
        for(PlayingCard * card in otherCards){
            if([self.suit isEqualToString:card.suit])
                suitMatch++;
            if(self.rank == card.rank)
                rankMatch++;
        }
        if([[[otherCards objectAtIndex:0] suit] isEqualToString:[[otherCards objectAtIndex:1] suit]])
            suitMatch++;
        if([[otherCards objectAtIndex:0] rank] == [[otherCards objectAtIndex:1] rank])
            rankMatch++;
        if(rankMatch == 3)
            score = 16;
        else if(suitMatch == 3)
            score = 8;
        else if(rankMatch == 2)
            score = 3;
        else if(suitMatch == 2)
            score = 1;
    }
    return score;
}

- (NSString *) contents {
    NSArray * rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

+ (NSArray*)validSuits{
    return @[@"♠",@"♥",@"♦",@"♣"];
}

- (void) setSuit:(NSString *) suit {
    if([[PlayingCard validSuits] containsObject:suit]){
        _suit = suit;
    }
}

- (NSString*) suit {
    return _suit ? _suit : @"?";
}

+ (NSArray*) rankStrings {
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger) maxRank {
    return [self rankStrings].count-1;
}

- (void) setRank:(NSUInteger)rank {
    if(rank <= [PlayingCard maxRank])
        _rank = rank;
}
@end
