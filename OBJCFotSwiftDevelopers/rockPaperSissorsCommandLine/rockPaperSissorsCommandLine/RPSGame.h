//
//  RPSGame.h
//  rockPaperSissorsCommandLine
//
//  Created by Wilson Muñoz on 9/14/17.
//  Copyright © 2017 Wilson Muñoz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RPSTurn.h"

@interface RPSGame : NSObject
@property (nonatomic) RPSTurn * firstTurn;
@property (nonatomic) RPSTurn * secondTurn;
-(NSString*)messageForGame:(RPSGame*)game;
- (instancetype)initWithFirstMove: (RPSTurn *) firstTurnInit  secondMove: (RPSTurn *) secondTurnInit;
- (RPSTurn *) winner;
- (RPSTurn *) loser;
@end
