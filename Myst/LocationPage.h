//
//  LocationPage.h
//  Myst
//
//  Created by Vipul Jikadra on 19/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationPage : UIViewController<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    IBOutlet UIButton *btnCancel;
    
    IBOutlet UIButton *btnSave;
    
    IBOutlet UITextField *tfLocationType;
    
    IBOutlet UITextField *tfStreet;
    IBOutlet UITextField *tfName;
    IBOutlet UITextField *tfSuite;
    
    IBOutlet UITextField *tfCity;
    
    IBOutlet UITextField *tfZipCode;
    IBOutlet UITextField *tfState;
    
    IBOutlet UITextField *tfInstructions;
    
    CGRect keyboardFrameBeginRect;
    
    UIPickerView *myPickerView;
    IBOutlet UIScrollView *backScrl;
    
    NSMutableArray *locationType;
    NSMutableArray *States;
    
}
- (IBAction)cancelFire:(id)sender;

- (IBAction)SaveFire:(id)sender;
@property (nonatomic, readwrite, assign) UITextField* activeTextField;
@end
