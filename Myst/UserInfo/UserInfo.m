//
//  UserInfo.m
//  SaveLife
//
//  Created by animesh on 03/11/14.
//  Copyright (c) 2014 vsure. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo


//@synthesize UserId;
//@synthesize Deparement_Name ;
//@synthesize Name;
//@synthesize Email;
//@synthesize ConteactNo;
//@synthesize Address;


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

//- (void)encodeWithCoder:(NSCoder *)encoder
//{
//    [encoder encodeObject:UserId forKey:@"UserId"];
//    [encoder encodeObject:Deparement_Name forKey:@"Deparement_Name"];
//    [encoder encodeObject:Name forKey:@"Name"];
//    [encoder encodeObject:Email forKey:@"Email"];
//    [encoder encodeObject:Address forKey:@"Address"];
//    [encoder encodeObject:ConteactNo forKey:@"ConteactNo"];
//}
//
//- (id)initWithCoder:(NSCoder *)decoder
//{
//    self = [super init];
//
//    if( self != nil ) {
//        UserId = [decoder decodeObjectForKey:@"UserId"];
//        Deparement_Name = [decoder decodeObjectForKey:@"Deparement_Name"];
//        Name = [decoder decodeObjectForKey:@"Name"];
//        Email = [decoder decodeObjectForKey:@"Email"];
//        Address = [decoder decodeObjectForKey:@"Address"];
//        ConteactNo = [decoder decodeObjectForKey:@"ConteactNo"];
//    }
//    
//    return self;
//}

@end
