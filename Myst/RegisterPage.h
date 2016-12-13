//
//  RegisterPage.h
//  Myst
//
//  Created by Vipul Jikadra on 09/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DelegateRegisterPage <NSObject>

- (void) Push:(int)vc Data:(id)dataInfo;
- (void) PopViewController;
- (void) addCustomPopup:(NSString *) msg;
@end
@interface RegisterPage : UIViewController<UITextFieldDelegate,UIScrollViewDelegate>
{
    
    IBOutlet UIScrollView *backScrl;
    IBOutlet UITextField *tfname;
    IBOutlet UITextField *tfEmail;
    IBOutlet UITextField *tfPwd;
    IBOutlet UITextField *tfConfirmPwd;
    
    IBOutlet UILabel *lblTerms;
    IBOutlet UIButton *btnSubmit;
    CGRect keyboardFrameBeginRect;
}
@property (weak, nonatomic) id <DelegateRegisterPage> delegate;
- (IBAction)submitFire:(id)sender;
@property (nonatomic, readwrite, assign) UITextField* activeTextField;

@end
