//
//  Person.m
//  commandToolPracticeObjc
//
//  Created by Wilson Muñoz on 9/13/17.
//  Copyright © 2017 Wilson Muñoz. All rights reserved.
//

#import "Person.h"

@implementation Person

- (instancetype)initWithName: (NSString *) name
                 dateOfBirth: (NSString *) dateOfBirth
{
    self = [super init];
    if (self) {
        _name = name;
        _dateOfBirth = dateOfBirth;
    }
    return self;
}
@end
