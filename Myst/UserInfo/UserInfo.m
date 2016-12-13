//
//  UserInfo.m
//  SaveLife
//
//  Created by animesh on 03/11/14.
//  Copyright (c) 2014 vsure. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

- (id) init
{
    self = [super init];
    
    if (self) {
        
        //        UserId = @"";
        //        Deparement_Name = @"";
        //        Name = @"";
        //        Email = @"";
        //        ConteactNo = @"";
        //        Address = @"";
        //        ConteactNo = @"";
    }
    
    return self;
}

- (id) initWith:(UserInfo *) ob {
    self = [super init];
    
    if (self)
    {
        
        //        UserId = ob.UserId;
        //        Deparement_Name = ob.Deparement_Name;
        //        Name = ob.Name;
        //        Email = ob.Email;
        //        Address = ob.Address;
        //        ConteactNo = ob.ConteactNo;
    }
    
    return self;
}


@end
