//
//  SettingPage.h
//  Myst
//
//  Created by Vipul Jikadra on 30/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DelegateSettingPage <NSObject>

- (void) Push:(int)vc Data:(id)dataInfo;
- (void) PopViewController;
- (void) addCustomPopup:(NSString *) msg;
-(void)ShowLocationView:(NSMutableDictionary *)data;
@end
@interface SettingPage : UIViewController
{
    
    IBOutlet UIView *viewPersonalDeatil;
    
    IBOutlet UIView *viewPush;
    
    IBOutlet UIView *viewEmail;
    
    
    IBOutlet UISwitch *switchPush;
    
    IBOutlet UISwitch *switchEmail;
    
    IBOutlet UIButton *btnDelete;
    
}
- (IBAction)pushFire:(id)sender;
- (IBAction)emailFire:(id)sender;
- (IBAction)DeleteFire:(id)sender;
@property (weak, nonatomic) id <DelegateSettingPage> delegate;
@end