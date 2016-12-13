//
//  UserInfo.h
//  SaveLife
//
//  Created by animesh on 03/11/14.
//  Copyright (c) 2014 vsure. All rights reserved.
//

#import "JSONModel.h"
#import <Foundation/Foundation.h>
#import "Message.h"
#import "UserData.h"
@interface UserInfo : JSONModel
@property (nonatomic) int success;
@property (nonatomic) Message * message;
@property (nonatomic) UserData *data;
- (id) init;

- (id) initWith:(UserInfo *) ob;

@end







