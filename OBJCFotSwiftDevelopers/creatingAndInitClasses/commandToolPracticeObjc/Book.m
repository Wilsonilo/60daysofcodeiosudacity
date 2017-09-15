//
//  Book.m
//  commandToolPracticeObjc
//
//  Created by Wilson Muñoz on 9/13/17.
//  Copyright © 2017 Wilson Muñoz. All rights reserved.
//

#import "Book.h"
#import "Person.h"

@implementation Book

-(instancetype)initWithTitle:(NSString*)title
                      author:(Person *)author
                        year:(int)year {
    self = [super init];
    if(self) {
        _title = title;
        _author = author;
        _yearOfPublication = year;
    }
    
    return self;
}

@end
