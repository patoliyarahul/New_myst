//
//  UtilityMethods.m
//  8coupons
//
//  Created by Devang Pandya on 23/03/14.
//  Copyright (c) 2014 abc. All rights reserved.
//

#import "UtilityMethods.h"

@implementation UtilityMethods
//Get Angle to show between two location.

+(NSString*)getDBPath
{
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [docPaths objectAtIndex:0];
    NSString *dbPath = [documentsDir stringByAppendingPathComponent:@"DB.sqlite"];
    NSLog(@"dbpath == %@",dbPath);
    return dbPath;
}
+(NSString*)removeWhiteSpace:(NSString*)stringForTrimming{
   return [stringForTrimming stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
}
@end
