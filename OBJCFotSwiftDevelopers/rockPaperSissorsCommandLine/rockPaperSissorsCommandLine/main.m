//
//  main.m
//  rockPaperSissorsCommandLine
//
//  Created by Wilson Muñoz on 9/14/17.
//  Copyright © 2017 Wilson Muñoz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RPSController.h"
#import "RPSGame.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        //NSLog(@"Hello, World!");
        
        RPSController *newController = [[RPSController alloc] init];
        [newController throwDown:Rock];
        NSString *result = [newController.game messageForGame:newController.game];
        NSLog(@"%@", result);
        
    }
    return 0;
}
