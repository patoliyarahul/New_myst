//
//  ToastMsg.h
//  Loyalty App
//
//  Created by Techlect on 02/09/14.
//  Copyright (c) 2014 Techlect. All rights reserved.
//

#import <Foundation/Foundation.h>

#define AToastMSG(m) ([[ToastMsg ToastMsgObject] ShowToastMsg:m])

@interface ToastMsg : NSObject
{
    NSMutableArray * mArrMsg;
}

+ (ToastMsg *) ToastMsgObject;

- (void) ShowToastMsg:(NSString *) msg;

@end