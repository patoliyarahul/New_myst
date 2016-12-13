//
//  Database.m
//  8coupons
//
//  Created by Devang Pandya on 25/03/14.
//  Copyright (c) 2014 abc. All rights reserved.
//

#import "Database.h"
#import "UtilityMethods.h"
#import "FMDatabase.h"

@implementation Database
- (id)init
{
    self = [super init];
    if (self)
    {
        database = [FMDatabase databaseWithPath:[UtilityMethods getDBPath]];
        [database open];
    }
    return self;
}
+ (Database *)sharedDatabase
{
    static Database *sharedDatabaseInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedDatabaseInstance = [[self alloc] init];
    });
    return sharedDatabaseInstance;
}
-(void)insertSearchKey:(NSString*)searchText{
    int count = [self checkIfSearchKeyExists:searchText];
    if (count==0) {
        [database executeUpdate:@"INSERT INTO SearchKeys (search_term,search_count) VALUES (?,?)", [NSString stringWithFormat:@"%@", searchText], [NSNumber numberWithInt:1]];
    }{
        [database executeUpdate:@"UPDATE SearchKeys set search_count= ? where search_term= ?",[NSNumber numberWithInt:count+1], [NSString stringWithFormat:@"%@", searchText]];
    }
}
-(int)checkIfSearchKeyExists:(NSString*)searchText{
    FMResultSet *results = [database executeQuery:@"SELECT search_count FROM SearchKeys where search_term= ?",[NSString stringWithFormat:@"%@", searchText]];
    int count = 0;
    while([results next]) {
        count = [results intForColumn:@"search_count"];
    }
//    [database close];
    return count;
}
-(NSArray*)getRecentSearches{
    FMResultSet *results = [database executeQuery:@"SELECT * FROM SearchKeys where search_count= 1"];
    NSMutableArray *arrResults = [[NSMutableArray alloc] init];
    while([results next]) {
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
        [dictionary setObject:[results stringForColumn:@"search_term"] forKey:@"search_term"];
        [dictionary setObject:[NSNumber numberWithInt:[results intForColumn:@"search_count"]] forKey:@"count"];
        [arrResults addObject:dictionary];
    }
    return arrResults;
}
-(NSArray*)getPopularSearches{
    FMResultSet *results = [database executeQuery:@"SELECT * FROM SearchKeys where search_count> 1"];
    NSMutableArray *arrResults = [[NSMutableArray alloc] init];
    while([results next]) {
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
        [dictionary setObject:[results stringForColumn:@"search_term"] forKey:@"search_term"];
        [dictionary setObject:[NSNumber numberWithInt:[results intForColumn:@"search_count"]] forKey:@"count"];
        [arrResults addObject:dictionary];
    }
    return arrResults;
}


#pragma mark Notification

-(void)Insert_Record:(NSString *)type category_image:(NSString *)category_image image_path:(NSString *)image_path message:(NSString*)message category_id:(NSString*)category_id subcat_name:(NSString*)subcat_name subcategory_id:(NSString*)subcategory_id date:(NSString *)date
{

[database executeUpdate:@"INSERT INTO notification (type,category_image,image_path,message,category_id,subcat_name,subcategory_id,date) VALUES (?,?,?,?,?,?,?,?)",
     [NSString stringWithFormat:@"%@", type],
     [NSString stringWithFormat:@"%@", category_image],
     [NSString stringWithFormat:@"%@", image_path],
     [NSString stringWithFormat:@"%@", message],
     [NSString stringWithFormat:@"%@", category_id],
     [NSString stringWithFormat:@"%@", subcat_name],
     [NSString stringWithFormat:@"%@", subcategory_id],[NSString stringWithFormat:@"%@", date]];
    
}
-(NSMutableArray *)Select_Record
{
    FMResultSet *results = [database executeQuery:@"SELECT * FROM notification",nil];
    
    NSMutableArray *category = [[NSMutableArray alloc]init];
    if (results != nil)
    {

        while([results next])
        {
            
//            NotificationRecord *bean = [[NotificationRecord alloc] init];
//            
//            bean.type = [results stringForColumnIndex:0];
//            bean.category_image =[results stringForColumnIndex:1];
//            bean.image_path = [results stringForColumnIndex:2];
//            bean.message = [results stringForColumnIndex:3];
//            bean.category_id = [results stringForColumnIndex:4];
//            bean.subcat_name = [results stringForColumnIndex:5];
//            bean.subcategory_id = [results stringForColumnIndex:6];
//            bean.date = [results stringForColumnIndex:7];
//        
//        [category addObject:bean];
        }
    }
    NSLog(@"[results stringForColumnIndex:0] == %@",category);
    return category;
}
-(void)deleteRowFromNotification:(NSString*)meal_id
{
    [database executeUpdate:@"DELETE FROM notification"];
}

@end
