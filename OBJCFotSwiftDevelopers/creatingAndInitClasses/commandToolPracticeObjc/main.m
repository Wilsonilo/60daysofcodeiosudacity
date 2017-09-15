//
//  main.m
//  commandToolPracticeObjc
//
//  Created by Wilson Muñoz on 9/13/17.
//  Copyright © 2017 Wilson Muñoz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "House.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //int year = 365;
        
//        NSString *helloWorld = @"Hello World";
//        NSLog(@"Hi %@, %i, %i, %s", helloWorld, year, argc, argv[0]);
//        helloWorld = @"Hi World Again";
//        year = 3000;
//        // insert code here...
//        NSLog(@"%@", helloWorld);
        
        House *callingName = [[House alloc] initWithAddress:(@"Avenida la luna #35")];
        NSLog(@"%@", [callingName returnName:(@"Wilson")]);
        
    }
    return 0;
}
