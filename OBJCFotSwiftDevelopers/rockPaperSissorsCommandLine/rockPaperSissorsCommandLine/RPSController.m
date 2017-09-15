//
//  RPSController.m
//  rockPaperSissorsCommandLine
//
//  Created by Wilson Muñoz on 9/14/17.
//  Copyright © 2017 Wilson Muñoz. All rights reserved.
//

#import "RPSController.h"
#import "RPSTurn.h"
#import "RPSGame.h"

@implementation RPSController
- (instancetype)init
{
    self = [super init];
    if (self) {
        //
    }
    return self;
}
- (void) throwDown: (Move) playersMove {
    
    //Init Move
    RPSTurn *playersTurn    = [[RPSTurn alloc] initWitMove:playersMove];
    RPSTurn *AITurn         = [[RPSTurn alloc] init];
    self.game = [[RPSGame alloc] initWithFirstMove:playersTurn secondMove:AITurn];
}

@end
