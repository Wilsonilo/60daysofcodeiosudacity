//
//  House.m
//  commandToolPracticeObjc
//
//  Created by Wilson Muñoz on 9/13/17.
//  Copyright © 2017 Wilson Muñoz. All rights reserved.
//

#import "House.h"

//@interface House()
////@property (nonatomic, readwrite) int numberOfBedRooms;
//@end

@implementation House
@synthesize numberOfBedRooms;
@synthesize address;
@synthesize hasHotTubs;

- (instancetype) initWithAddress: (NSString *) initaddress {
    
    self = [super init];
    
    if (self){
        address            = initaddress;// use _ to point to the address.
        numberOfBedRooms   = 2;
        hasHotTubs         = false;
    }
    return self;
}

- (NSString *)returnName:(NSString *)name {
    NSString *result = [[NSString alloc] init];
    result = @"Hey, nice to meey you ";
    result = [result stringByAppendingString: name];
    return result;
}

@end
