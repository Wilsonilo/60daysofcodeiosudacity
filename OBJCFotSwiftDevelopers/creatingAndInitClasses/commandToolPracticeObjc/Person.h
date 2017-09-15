//
//  Person.h
//  commandToolPracticeObjc
//
//  Created by Wilson Muñoz on 9/13/17.
//  Copyright © 2017 Wilson Muñoz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic) NSString * name;
@property (nonatomic) NSString * dateOfBirth;
- (instancetype)initWithName: (NSString *) name
                 dateOfBirth: (NSString *) dateOfBirth;
@end
