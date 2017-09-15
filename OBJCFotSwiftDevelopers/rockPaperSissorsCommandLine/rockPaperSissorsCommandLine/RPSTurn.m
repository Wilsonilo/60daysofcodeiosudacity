//
//  RPSTurn.m
//  rockPaperSissorsCommandLine
//
//  Created by Wilson Muñoz on 9/14/17.
//  Copyright © 2017 Wilson Muñoz. All rights reserved.
//

#import "RPSTurn.h"

@implementation RPSTurn
@synthesize move;
- (instancetype)initWitMove: (Move) initMove {
    self = [super init];
    if (self) {
        self.move = initMove;
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.move = [self generateMove];
    }
    return self;
}

- (NSString *) description {
    switch (self.move) {
        case Rock:
            return @"Rock";
            break;
        case Paper:
            return @"Paper";
            break;
        case Scissors:
            return @"Scissors";
            break;
        default:
            return @"Rock";
            
    }
}

- (Move) generateMove {
    NSUInteger randomNumber = arc4random_uniform(3);
    
    switch (randomNumber) {
        case 0:
            return Rock;
            break;
        case 1:
            return Paper;
            break;
        case 2:
            return Scissors;
            break;
        default:
            return Invalid;
            
    }
    //return Rock;
}
- (BOOL) defeats: (RPSTurn *) oponnentTurn {
    
    if (self.move == Paper && oponnentTurn.move == Rock) {
        return true;
    } else if (self.move == Scissors && oponnentTurn.move == Paper){
        return true;
    } else if (self.move == Rock && oponnentTurn.move == Scissors){
        return true;
    } else {
        return false;
    }

}
@end
