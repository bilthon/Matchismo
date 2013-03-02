//
//  Card.h
//  Matchismo
//
//  Created by Nelson Perez on 2/20/13.
//  Copyright (c) 2013 Nelson Perez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
// what's on the card
@property (strong, nonatomic) NSString *contents;

// state of the card
@property (nonatomic,getter = isFaceUp) BOOL faceUp;
@property (nonatomic,getter = isUnplayable) BOOL unplayable;

- (int)match:(NSArray*)otherCards;
@end
