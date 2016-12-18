//
//  PackageOb.h
//  Myst
//
//  Created by Vipul Jikadra on 17/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "Message.h"
#import "PackageObData.h"
@interface PackageOb : JSONModel

@property (nonatomic) int success;
@property (nonatomic) Message * message;
@property (nonatomic) NSMutableArray<PackageObData *> *data;
@end
