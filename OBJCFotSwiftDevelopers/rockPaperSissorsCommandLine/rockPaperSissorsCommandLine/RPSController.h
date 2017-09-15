//
//  RPSController.h
//  rockPaperSissorsCommandLine
//
//  Created by Wilson Muñoz on 9/14/17.
//  Copyright © 2017 Wilson Muñoz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RPSTurn.h"
#import "RPSGame.h"

@interface RPSController : NSObject
@property (nonatomic) RPSGame* game;
- (void) throwDown: (Move) playersMove;
@end
