//
//  LoginPage.h
//  Myst
//
//  Created by Vipul Jikadra on 12/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DelegateLoginPage <NSObject>

- (void) Push:(int)vc Data:(id)dataInfo;
- (void) PopViewController;
- (void) addCustomPopup:(NSString *) msg;
@end
@interface LoginPage : UIViewController<UITextFieldDelegate>
{
    
    IBOutlet UITextField *tfPwd;
    IBOutlet UITextField *tfEmail;
    
    IBOutlet UIButton *btnSubmit;
    IBOutlet UILabel *lblForgetpwd;
    
    IBOutlet UIButton *btnCross;
    
}
- (IBAction)crossFire:(id)sender;


@property (weak, nonatomic) id <DelegateLoginPage> delegate;
- (IBAction)submitFire:(id)sender;
@end
