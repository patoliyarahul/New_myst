//
//  LocationOb.h
//  Myst
//
//  Created by Vipul Jikadra on 19/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "Message.h"
#import "LocationObData.h"
@interface LocationOb : JSONModel
@property (nonatomic) int success;
@property (nonatomic) Message * message;
@property (nonatomic) NSMutableArray<LocationObData *> *data;
@end
