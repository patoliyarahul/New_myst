//
//  OrderHistoryPage.h
//  Myst
//
//  Created by Vipul Jikadra on 03/01/17.
//  Copyright © 2017 Vipul Jikadra. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DelegateOrderHistoryPage <NSObject>
- (void) Push:(int)vc Data:(id)dataInfo;
- (void) PopViewController;
- (void) addCustomPopup:(NSString *) msg;
-(void)ShowTipView:(NSMutableDictionary *)data;
@end
@interface OrderHistoryPage : UIViewController
{
    
}
@property (weak, nonatomic) id <DelegateOrderHistoryPage> delegate;
@end
