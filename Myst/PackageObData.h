//
//  PackageObData.h
//  Myst
//
//  Created by Vipul Jikadra on 17/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface PackageObData : JSONModel
@property (nonatomic) NSString * title;
@property (nonatomic) NSString * sedan_price;
@property (nonatomic) NSString * suv_price;
@property (nonatomic,readwrite) NSString * description;
@property (nonatomic) NSString * pkg_id;
@property (nonatomic) NSString * image;
@end
