//
//  ForgetPwdPage.h
//  Myst
//
//  Created by Vipul Jikadra on 12/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgetPwdPage : UIViewController<UITextFieldDelegate>
{
    
    IBOutlet UILabel *lblMsg;
    
    IBOutlet UITextField *tfEmail;
    
    IBOutlet UIButton *tfSubmit;
}
- (IBAction)submitFire:(id)sender;

@end
