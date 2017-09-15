//
//  RPSGame.m
//  rockPaperSissorsCommandLine
//
//  Created by Wilson Muñoz on 9/14/17.
//  Copyright © 2017 Wilson Muñoz. All rights reserved.
//

#import "RPSGame.h"
#import "RPSTurn.h"

@implementation RPSGame
@synthesize firstTurn;
@synthesize secondTurn;

- (instancetype)initWithFirstMove: (RPSTurn *) firstTurnInit  secondMove: (RPSTurn *) secondTurnOInit {
    self = [super init];
    if (self) {
        self.firstTurn = firstTurnInit;
        self.secondTurn = secondTurnOInit;
    }
    return self;
}

- (RPSTurn *) winner {
    return [self.firstTurn defeats:self.secondTurn] ? self.firstTurn : self.secondTurn;
    
}

- (RPSTurn *) loser {
    return [self.firstTurn defeats:self.secondTurn] ? self.secondTurn : self.firstTurn;
    
}

-(NSString*)messageForGame:(RPSGame*)game {
    // First, handle the tie
    if (game.firstTurn.move == game.secondTurn.move) {
        return @"It's a tie!";
    } else {
    
        // Then build up the results message "Rock defeats Scissors. You Win!" etc.
        NSString *winnerString = [[game winner] description];
        // Build the loserString here.
        NSString *loserString = [[game loser] description];

        // Build the resultsString here.
        NSLog(@"%@", winnerString);
        NSString *wholeString =  [NSString stringWithFormat:@"%@ %@ %@ %@", winnerString, @" defeats ", loserString, @"."];
        
        return wholeString;
    }
    
}

@end
