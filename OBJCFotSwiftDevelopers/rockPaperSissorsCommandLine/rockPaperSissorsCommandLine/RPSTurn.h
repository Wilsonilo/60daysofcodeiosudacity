//
//  RPSTurn.h
//  rockPaperSissorsCommandLine
//
//  Created by Wilson Muñoz on 9/14/17.
//  Copyright © 2017 Wilson Muñoz. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, Move) {
    Rock,
    Paper,
    Scissors,
    Invalid
};

@interface RPSTurn : NSObject

- (instancetype)initWitMove: (Move) move;
- (Move) generateMove;
- (BOOL) defeats: (RPSTurn *) oponnentTurn;
- (NSString *) description;

@property (nonatomic) Move move;
@end
