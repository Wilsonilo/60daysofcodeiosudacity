//
//  Book.h
//  commandToolPracticeObjc
//
//  Created by Wilson Muñoz on 9/13/17.
//  Copyright © 2017 Wilson Muñoz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

@interface Book : NSObject

@property (nonatomic) NSString * _Nonnull title;
@property (nonatomic) Person *  _Nonnull author;
@property (nonatomic) int yearOfPublication;

-(instancetype _Nullable)initWithTitle:(NSString*  _Nonnull)title
                      author:(NSString*  _Nonnull)author
                        year:(int ) year;

@end
