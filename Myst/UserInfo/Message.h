//
//  Message.h
//  Myst
//
//  Created by Vipul Jikadra on 13/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface Message : JSONModel
@property (nonatomic) NSString * title;
@property (nonatomic) NSString * description;
@end
