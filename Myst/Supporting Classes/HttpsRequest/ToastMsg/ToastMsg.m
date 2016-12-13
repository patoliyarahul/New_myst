//
//  ToastMsg.m
//  Loyalty App
//
//  Created by Techlect on 02/09/14.
//  Copyright (c) 2014 Techlect. All rights reserved.
//

#import "ToastMsg.h"

static UILabel * lblMSG;
static UIView * viewMSG;
static ToastMsg * obToastMsg;

@implementation ToastMsg

+ (ToastMsg *) ToastMsgObject
{
    if (!obToastMsg) {
        obToastMsg = [ToastMsg new];
    }
    
    return obToastMsg;
}

#define FONTSIZE 14

#define Font [UIFont fontWithName:@"TimesNewRomanPSMT" size:FONTSIZE]

/*
 Times New Roman
 TimesNewRomanPS-ItalicMT
 TimesNewRomanPS-BoldMT
 TimesNewRomanPSMT
 TimesNewRomanPS-BoldItalicMT
 */

- (void) ShowToastMsg:(NSString *) msg
{
    if (msg) {
        
        if (mArrMsg == nil)
            mArrMsg = [NSMutableArray new];
        
        
        if (!viewMSG) {
            viewMSG = [[UIView alloc] init];
            
            viewMSG.backgroundColor = [UIColor colorWithRed:65.0/255.0 green:65.0/255.0 blue:65.0/255.0 alpha:1.0];
            
            viewMSG.layer.masksToBounds = YES;
            viewMSG.layer.cornerRadius = 15.0;
            viewMSG.layer.borderWidth = 1.5;
            viewMSG.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        }
        
        if (!lblMSG) {
            lblMSG = [[UILabel alloc] init];
            
            lblMSG.numberOfLines = 0;
            
            lblMSG.backgroundColor = [UIColor clearColor];
            lblMSG.textColor = [UIColor lightTextColor];
            
            lblMSG.textAlignment = NSTextAlignmentCenter;
            
            [lblMSG sizeToFit];
            
            [viewMSG addSubview:lblMSG];
            
            [lblMSG setFont:Font];
        }
        
        [mArrMsg addObject:msg];
        
        if (mArrMsg.count == 1)
            [self initMSG];
    }
}

- (void) initMSG {
    if (mArrMsg.count > 0) {
        [self performSelectorInBackground:@selector(initMSGThread) withObject:nil];
    }
}

- (void) initMSGThread {
    if (mArrMsg.count > 0) {
        [self showNewMSG:mArrMsg[0]];
    }
}

- (void) showNewMSG:(NSString *) msg {
    CGRect rectScreen = [UIScreen mainScreen].bounds;
    
    float width = rectScreen.size.width - 30;
    
    CGSize size = [self findHeightForText:msg havingWidth:width andFont:Font];
    
    lblMSG.text = msg;
    
    CGRect newRect = CGRectMake(5, 5, width, size.height);
    CGRect rectView = CGRectMake((rectScreen.size.width/2) - ((width + 10)/2), -50 + rectScreen.size.height - size.height, width + 10, size.height + 10);

    lblMSG.frame = newRect;
    viewMSG.frame = rectView;
    
    [viewMSG addSubview:lblMSG];
    
    [KAppDelegate.window addSubview:viewMSG];
    
    [self performSelectorInBackground:@selector(RemoveToastMsg) withObject:nil];
}

- (CGSize)findHeightForText:(NSString *)text havingWidth:(CGFloat)widthValue andFont:(UIFont *) font {
    CGSize size = CGSizeZero;
    if (text) {
        CGRect frame = [text boundingRectWithSize:CGSizeMake(widthValue, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName:font } context:nil];
        size = CGSizeMake(frame.size.width, frame.size.height + 1);
    }
    
    return size;
}

- (void) RemoveToastMsg
{
    sleep(2);
    
    if (mArrMsg.count > 0)
        if ([mArrMsg respondsToSelector:@selector(removeObjectAtIndex:)])
            [mArrMsg removeObjectAtIndex:0];

    if (mArrMsg.count == 0) {
        [viewMSG removeFromSuperview];
    }
    
    sleep(1.5);
    
    [self initMSG];
}

@end







