//
//  AddPaymentPage.h
//  Myst
//
//  Created by Vipul Jikadra on 21/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import <UIKit/UIKit.h>
#define Visa 1// = Pattern.compile("^4[0-9]{12}(?:[0-9]{3})?$");
#define Master 2//= Pattern.compile("^5[1-5][0-9]{14}$");
#define Express 3//= Pattern.compile("^3[47][0-9]{13}$");
#define Diners 4//= Pattern.compile("^3(?:0[0-5]|[68][0-9])[0-9]{11}$");
#define Discover 5//= Pattern.compile("^6(?:011|5[0-9]{2})[0-9]{12}$");
#define JSB 6//
#define NoONe 7//
@protocol DelegateAddPaymentPage <NSObject>

- (void) Push:(int)vc Data:(id)dataInfo;
- (void) PopViewController;
- (void) addCustomPopup:(NSString *) msg;
-(void)ShowLocationView;
@end
@interface AddPaymentPage : UIViewController<UITextFieldDelegate>
{
    IBOutlet UITextField *tfCardNumber;
    
    IBOutlet UITextField *tfCvv;
    
    IBOutlet UITextField *tfExpiryDate;
    
    IBOutlet UIImageView *imgCard;
    
    int noOfCharacterInCardNumber;
    NSString * strCardExpired;
    
    int month;
    int year;

}
@property (weak, nonatomic) id <DelegateAddPaymentPage> delegate;
- (IBAction)btnAddHiphen:(id)sender;
-(void)Submit;
@end
