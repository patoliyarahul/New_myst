//
//  PersonalDetailsPage.h
//  Myst
//
//  Created by Vipul Jikadra on 30/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <libPhoneNumber-iOS/NBPhoneNumberUtil.h>
#import <libPhoneNumber-iOS/NBPhoneNumber.h>
#import <libPhoneNumber-iOS/NBAsYouTypeFormatter.h>
@interface PersonalDetailsPage : UIViewController<UITextFieldDelegate>
{
    
    IBOutlet UITextField *tfName;
    IBOutlet UITextField *tfEmail;
    
    IBOutlet UITextField *tfMobile;
    
     NBAsYouTypeFormatter *asYouTypeFormatter;
}
-(void)Submit;
@end
