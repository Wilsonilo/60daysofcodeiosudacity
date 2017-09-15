//
//  House.h
//  commandToolPracticeObjc
//
//  Created by Wilson Muñoz on 9/13/17.
//  Copyright © 2017 Wilson Muñoz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface House : NSObject

//MARK: - Properties
@property (nonatomic) NSString *address;
@property (nonatomic, readonly) int numberOfBedRooms;
@property (nonatomic) BOOL hasHotTubs;


//MARK: - Methods
- (NSString *) returnName: (NSString *) name;
- (instancetype) initWithAddress: (NSString *) initaddress initWithAuthor: (NSString *) initauthor;

@end
