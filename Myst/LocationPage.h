//
//  LocationPage.h
//  Myst
//
//  Created by Vipul Jikadra on 19/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationPage : UIViewController<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIActionSheetDelegate>
{
    IBOutlet UIButton *btnCancel;
    
    IBOutlet UIButton *btnSave;
    
    IBOutlet IQDropDownTextField *tfLocationType;
    
    IBOutlet UITextField *tfStreet;
    IBOutlet UITextField *tfName;
    IBOutlet UITextField *tfSuite;
    
    IBOutlet UITextField *tfCity;
    
    IBOutlet UITextField *tfZipCode;
    IBOutlet IQDropDownTextField *tfState;
    
    IBOutlet UITextField *tfInstructions;
    
    CGRect keyboardFrameBeginRect;
    
    UIPickerView *myPickerView;
    IBOutlet UIScrollView *backScrl;
    

    IBOutlet UILabel *lblHeader;
    IBOutlet UIButton *btnDelete;
}
- (IBAction)cancelFire:(id)sender;

- (IBAction)SaveFire:(id)sender;
@property (nonatomic, readwrite, assign) UITextField* activeTextField;
@property(nonatomic) NSMutableDictionary *dataInfo;
- (IBAction)deleteFire:(id)sender;
@end
