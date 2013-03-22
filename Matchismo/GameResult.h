//
//  GameResult.h
//  Matchismo
//
//  Created by Nelson Perez on 3/20/13.
//  Copyright (c) 2013 Nelson Perez. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ALL_RESULTS_KEY @"GameResult_All"
#define START_KEY @"StartDate"
#define END_KEY @"EndDate"
#define SCORE_KEY @"Score"

@interface GameResult : NSObject

+(NSArray*) allGameResults;

@property (readonly,nonatomic) NSDate *start;
@property (readonly,nonatomic) NSDate *end;
@property (readonly,nonatomic) NSTimeInterval duration;
@property (nonatomic) int score;
@end
