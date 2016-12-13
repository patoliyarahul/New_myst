//
//  Database.h
//  8coupons
//
//  Created by Devang Pandya on 25/03/14.
//  Copyright (c) 2014 abc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMDatabase;
@interface Database : NSObject
{
    FMDatabase *database;
}
+ (Database *)sharedDatabase;
-(void)insertSearchKey:(NSString*)searchText;
-(int)checkIfSearchKeyExists:(NSString*)searchText;
-(NSArray*)getRecentSearches;
-(NSArray*)getPopularSearches;


//// db method



-(void)Insert_Record:(NSString *)type category_image:(NSString *)category_image image_path:(NSString *)image_path message:(NSString*)message category_id:(NSString*)category_id subcat_name:(NSString*)subcat_name subcategory_id:(NSString*)subcategory_id date:(NSString *)date;
-(NSMutableArray *)Select_Record;
-(void)deleteRowFromNotification:(NSString*)meal_id;

//-(void)saveDeal:(Deal*)deal catID:(NSString*)categoryID;
//-(void)removeDealWithID:(NSString*)dealID;
//-(void)removeDealsWithCategoryId:(NSString*)categoryid;
//-(Deal*)getDealOfTheDay;
//-(NSMutableArray*)getDealsForCategory:(NSString*)categoryid;
//-(void)saveDealsForCategory:(NSString*)catID deals:(NSArray*)dealsArray;
//
//-(void)saveCategories:(NSArray*)arrCategories;
//-(NSMutableArray*)loadCategories;
//
//-(void)saveDealTypes:(NSArray*)arrDealTypes;
//-(NSMutableArray*)loadDealTypes;

@end
