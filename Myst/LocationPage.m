//
//  LocationPage.m
//  Myst
//
//  Created by Vipul Jikadra on 19/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import "LocationPage.h"

@interface LocationPage ()
{
    
}
@end

@implementation LocationPage

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    tfName.delegate = self;
    tfStreet.delegate = self;
    tfSuite.delegate = self;
    tfCity.delegate = self;
    
    tfZipCode.delegate = self;
    tfInstructions.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(myNotificationMethod:) name:UIKeyboardDidShowNotification object:nil];
    [self HighLite];
    [self borderWork];
    
  
    
    [tfName setCustomDoneTarget:self action:@selector(doneAction:)];
    [tfStreet setCustomDoneTarget:self action:@selector(doneAction:)];
    [tfSuite setCustomDoneTarget:self action:@selector(doneAction:)];
    [tfCity setCustomDoneTarget:self action:@selector(doneAction:)];
    [tfInstructions setCustomDoneTarget:self action:@selector(doneAction:)];
    [tfZipCode setCustomDoneTarget:self action:@selector(doneAction:)];
    [tfLocationType setCustomDoneTarget:self action:@selector(doneAction:)];
    [tfState setCustomDoneTarget:self action:@selector(doneAction:)];
}
-(void)doneAction:(UITextField*)textField
{
    [self HighLite];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
     [tfLocationType setItemList:@[@"Home",@"Aprtment",@"Office Building"]];
     [tfState setItemList:@[@"CA",@"NewYork",@"New Mexico",@"Chicago",@"San Franscio"]];
    
    lblHeader.text = _dataInfo[@"title"];
    
    btnDelete.hidden = YES;
    if ([lblHeader.text isEqualToString:@"Edit Location"])
    {
        btnDelete.hidden = NO;
    }
    
    if (![[[_dataInfo valueForKey:@"data"] valueForKey:@"loc_id"] isEqualToString:@""])
    {
        tfName.text = [[_dataInfo valueForKey:@"data"] valueForKey:@"fullname"];
        tfStreet.text = [[_dataInfo valueForKey:@"data"] valueForKey:@"street"];
        tfSuite.text = [[_dataInfo valueForKey:@"data"] valueForKey:@"unit"];
        tfCity.text = [[_dataInfo valueForKey:@"data"] valueForKey:@"city"];
        tfInstructions.text = [[_dataInfo valueForKey:@"data"] valueForKey:@"instruction"];
        tfZipCode.text = [[_dataInfo valueForKey:@"data"] valueForKey:@"zipcode"];
        tfLocationType.text = [[_dataInfo valueForKey:@"data"] valueForKey:@"loc_type"];
        tfState.text = [[_dataInfo valueForKey:@"data"] valueForKey:@"state"];
        [self HighLite];
    }

}
- (void)myNotificationMethod:(NSNotification *)notification
{
    NSDictionary* keyboardInfo  = [notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    keyboardFrameBeginRect      = [keyboardFrameBegin CGRectValue];
}
- (void) borderWork
{
    
    [self SetTextFieldBorder:tfLocationType];
    [self SetTextFieldBorder:tfName];
    [self SetTextFieldBorder:tfStreet];
    [self SetTextFieldBorder:tfSuite];
    [self SetTextFieldBorder:tfCity];
    [self SetTextFieldBorder:tfState];
    [self SetTextFieldBorder:tfZipCode];
    [self SetTextFieldBorder:tfInstructions];
    
    [obNet startSpaceTo:tfLocationType Space:SpaceForTextField];
    [obNet startSpaceTo:tfName Space:SpaceForTextField];
    [obNet startSpaceTo:tfStreet Space:SpaceForTextField];
    [obNet startSpaceTo:tfSuite Space:SpaceForTextField];
    [obNet startSpaceTo:tfCity Space:SpaceForTextField];
    [obNet startSpaceTo:tfState Space:SpaceForTextField];
    [obNet startSpaceTo:tfZipCode Space:SpaceForTextField];
    [obNet startSpaceTo:tfInstructions Space:SpaceForTextField];
    
    [tfLocationType setValue:colorTextHintSecond forKeyPath:@"_placeholderLabel.textColor"];
    [tfName setValue:colorTextHintSecond forKeyPath:@"_placeholderLabel.textColor"];
    [tfStreet setValue:colorTextHintSecond forKeyPath:@"_placeholderLabel.textColor"];
    [tfSuite setValue:colorTextHintSecond forKeyPath:@"_placeholderLabel.textColor"];
    [tfCity setValue:colorTextHintSecond forKeyPath:@"_placeholderLabel.textColor"];
    [tfState setValue:colorTextHintSecond forKeyPath:@"_placeholderLabel.textColor"];
    [tfZipCode setValue:colorTextHintSecond forKeyPath:@"_placeholderLabel.textColor"];
    [tfInstructions setValue:colorTextHintSecond forKeyPath:@"_placeholderLabel.textColor"];
    
}
-(void)HighLite
{
    btnSave.hidden = NO;
    [btnSave setTitleColor:[obNet colorWithHexString:@"0AE587"] forState:UIControlStateNormal];
    btnSave.userInteractionEnabled = NO;
    btnSave.titleLabel.alpha = 0.5;
    
    if (tfLocationType.text.length != 0 && tfName.text.length != 0 && tfStreet.text.length != 0 && tfSuite.text.length != 0 && tfCity.text.length != 0 && tfState.text.length != 0 && tfZipCode.text.length != 0 && tfInstructions.text.length != 0)
    {
        btnSave.hidden = NO;
        [btnSave setTitleColor:[obNet colorWithHexString:@"0AE587"] forState:UIControlStateNormal];
        btnSave.userInteractionEnabled = YES;
        btnSave.titleLabel.alpha = 1.0;
        
    }
    
}
- (void)viewDidLayoutSubviews
{
    [backScrl setContentSize:CGSizeMake([obNet deviceFrame].size.width, [obNet deviceFrame].size.height)];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [backScrl setContentOffset:CGPointZero];
    [backScrl setContentSize:CGSizeZero];
    [self HighLite];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{

}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == tfName || textField == tfInstructions)
    {
       return  [obNet onlyChar:string];
    }
    return YES;

}
-(void)done:(id)sender
{
    [self.view endEditing:YES];
    [backScrl setContentOffset:CGPointZero];
    [backScrl setContentSize:CGSizeZero];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancelFire:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
-(void)SetTextFieldBorder :(UITextField *)textField
{
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 1;
    border.borderColor = [obNet colorWithHexString:@"9B9B9B"].CGColor;
    border.frame = CGRectMake(0, textField.frame.size.height - borderWidth, textField.frame.size.width, textField.frame.size.height);
    border.borderWidth = borderWidth;
    border.opacity = 0.5;
    [textField.layer addSublayer:border];
    textField.layer.masksToBounds = YES;
    
}
- (IBAction)SaveFire:(id)sender
{
    NSString * msg = nil;
    
    if (tfLocationType.text.length == 0)
    {
        msg = @"LocationType is empty";
    }
    else if (tfName.text.length == 0)
    {
        msg = @"LocationName is empty";
    }
    else if (tfSuite.text.length == 0)
    {
        msg = @"Suite is empty";
    }
    else if (tfCity.text.length == 0)
    {
        msg = @"City Name is empty";
    }
    else if (tfState.text.length == 0)
    {
        msg = @"State is empty";
    }
    else if (tfZipCode.text.length == 0)
    {
        msg = @"Zipcode is empty";
    }
    else if (tfInstructions.text.length == 0)
    {
        msg = @"Instructions is empty";
    }
    if (msg)
    {
        ToastMSG(msg);
    }
    else
    {
        NSMutableDictionary * mD = [NSMutableDictionary new];
        
        UserInfo *ob = [obNet getUserInfoObject];
        

        
        mD[@"cust_id"] = ob.data.cust_id;
        mD[@"type"] = tfLocationType.text;
        mD[@"name"] = tfName.text;
        mD[@"street"] = tfState.text;
        mD[@"unit"] = tfSuite.text;
        mD[@"city"] = tfCity.text;
        mD[@"state"] = tfState.text;
        mD[@"zipcode"] = tfZipCode.text;
        mD[@"instruction"] = tfInstructions.text;
        mD[@"latitude"] = @"";
        mD[@"longitude"] = @"";
        
        if ([lblHeader.text isEqualToString:@"Edit Location"])
        {
             mD[@"loc_id"] = [[_dataInfo valueForKey:@"data"] valueForKey:@"loc_id"];
            [obNet JSONFromWebServices:WS_editLocation Parameter:mD Method:@"POST" AI:YES PopUP:YES Caller:CALLER WithBlock:^(id json)
             {
                 if (IsObNotNil(json))
                 {
                     
                     if ([json[@"success"] integerValue] == 1)
                     {
                         
                         ToastMSG(json[@"message"][@"title"]);
                         [self dismissViewControllerAnimated:YES completion:NULL];
                         
                     }
                     else
                     {
                         ToastMSG(json[@"message"][@"title"]);
                     }
                     
                 }
                 else
                 {
                     ToastMSG(json[@"message"][@"title"]);
                 }
                 
             }];
        }
        else
        {
            [obNet JSONFromWebServices:WS_addLocation Parameter:mD Method:@"POST" AI:YES PopUP:YES Caller:CALLER WithBlock:^(id json)
             {
                 if (IsObNotNil(json))
                 {
                     
                     if ([json[@"success"] integerValue] == 1)
                     {
                         
                         ToastMSG(json[@"message"][@"title"]);
                         [self dismissViewControllerAnimated:YES completion:NULL];
                         
                     }
                     else
                     {
                         ToastMSG(json[@"message"][@"title"]);
                     }
                     
                 }
                 else
                 {
                     ToastMSG(json[@"message"][@"title"]);
                 }
                 
             }];
            

        }
        
}

}
- (IBAction)deleteFire:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Are You Sure Want To Delete This Location.", nil];
    
    [actionSheet showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        NSMutableDictionary * mD = [NSMutableDictionary new];
        
        UserInfo *ob = [obNet getUserInfoObject];
        
        mD[@"cust_id"] = ob.data.cust_id;
        mD[@"loc_id"] = [[_dataInfo valueForKey:@"data"] valueForKey:@"loc_id"];
        
        [obNet JSONFromWebServices:WS_deleteLocation Parameter:mD Method:@"POST" AI:YES PopUP:YES Caller:CALLER WithBlock:^(id json)
         {
             if (IsObNotNil(json))
             {
                 
                 if ([json[@"success"] integerValue] == 1)
                 {
                     
                     ToastMSG(json[@"message"][@"title"]);
                     [self dismissViewControllerAnimated:YES completion:NULL];
                     
                 }
                 else
                 {
                     ToastMSG(json[@"message"][@"title"]);
                 }
                 
             }
             else
             {
                 ToastMSG(json[@"message"][@"title"]);
             }
             
         }];
        
    }
}

@end
