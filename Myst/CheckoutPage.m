//
//  CheckoutPage.m
//  Myst
//
//  Created by Vipul Jikadra on 20/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import "CheckoutPage.h"
#import "VehicleListCell.h"
#import "VehicleObData.h"
@interface CheckoutPage ()
{
    UITapGestureRecognizer *Paymetmethod;
    UITapGestureRecognizer *onDemandGesture;
    UITapGestureRecognizer *sheduleGesture;
}
@end

@implementation CheckoutPage

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    pickerHeight = pickerHeightConstarint.constant;
    pickerViewheight = pickerViewHeightConstraint.constant;
   
    tblVehicle.delegate = self;
    tblVehicle.dataSource = self;
    [tblVehicle registerNib:[UINib nibWithNibName:@"VehicleListCell" bundle:nil] forCellReuseIdentifier:@"VehicleList"];
    
    scrlContainer.delegate = self;
    scrlBack.delegate = self;
    
    NSLog(@"dataInfo = %@",_dataInfo);
    
    scrlContainer.frame = CGRectMake(0 , 0,  [UIScreen mainScreen].bounds.size.width, scrlContainer.frame.size.height);
    [scrlBack addSubview:scrlContainer];
    
    //???????????????????????????????????????    Shedule Wash ????????????????????////////////////////////////////
    
    onDemandGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewOndemandTapped:)];
    viewOndemand.userInteractionEnabled = YES;
    [viewOndemand addGestureRecognizer:onDemandGesture];
    imgDemand.hidden = YES;
    
    sheduleGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewScheduleTapped:)];
    viewSchedule.userInteractionEnabled = YES;
    [viewSchedule addGestureRecognizer:sheduleGesture];
    imgSchedule.hidden = YES;
    btnTimeSelect.hidden = YES;
    
    CGRect frame = viewPicker.frame;
    frame.size.height = pickerViewHeightConstraint.constant;//rect.size.width;
    [viewPicker setFrame:frame];
    
    pickerHeightConstarint.constant = 0;
    pickerViewHeightConstraint.constant = 0;
    
    
    [tblVehicle setNeedsLayout];
    [tblVehicle setNeedsDisplay];
    [tblVehicle reloadData];
    
    [self.view setNeedsUpdateConstraints];

   
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
     //???????????????????????????????????????    Payment Part ????????????????????////////////////////////////////
    
    Paymetmethod = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewAddPaymetmethodTapped:)];
    viewAddPaymetmethod.userInteractionEnabled = YES;
    [viewAddPaymetmethod addGestureRecognizer:Paymetmethod];
    
    if (IsObNotNil([KAppDelegate.CardDetail valueForKey:@"number"]))
    {
        lblAddPayment.text = [KAppDelegate.CardDetail valueForKey:@"number"];
        lblAddPayment.textColor = colorTextHintSecond;
        imgCard.image = [UIImage imageNamed:@"american.png"];
    }
    
    
    NSDate *currentDate = [NSDate date];
    pickerDate.minimumDate = currentDate;
    [pickerDate addTarget:self action:@selector(dateChanged:)
    forControlEvents:UIControlEventValueChanged];

   lblLoctaion.text = [NSString stringWithFormat:@"%@ %@ \n%@ %@ %@",[[KAppDelegate.locationDict valueForKey:@"FinalLocation"] valueForKey:@"street"], [[KAppDelegate.locationDict valueForKey:@"FinalLocation"] valueForKey:@"unit"], [[KAppDelegate.locationDict valueForKey:@"FinalLocation"] valueForKey:@"city"],[[KAppDelegate.locationDict valueForKey:@"FinalLocation"] valueForKey:@"state"] ,[[KAppDelegate.locationDict valueForKey:@"FinalLocation"] valueForKey:@"zipcode"]];

    [self findVehicleFromPackages];
    
    
    if (KAppDelegate.packages.count != 0)
    {
      
        int a = 0;
        for (NSString* key in [KAppDelegate.PackagePrice allKeys])
        {
            NSLog(@"key ==== %@",key);
            
            a = a + [[KAppDelegate.PackagePrice objectForKey:key]integerValue];
        }
        
        lblTotal.text = [NSString stringWithFormat:@"$%i",a];
    }
    else
    {
       
    }
    
    [self HighLite];
}
#define Find Vehicle For load vehicle on tblVehicle JD

-(void)findVehicleFromPackages
{
    
    vehicles = [NSMutableArray new];
    for (int i = 0; i< [[_dataInfo valueForKey:@"Vehicle"]count]; i++)
    {
        if ([KAppDelegate.packages objectForKey:[[[_dataInfo valueForKey:@"Vehicle"] valueForKey:@"veh_id"] objectAtIndex:i]])
        {
           
            [vehicles addObject:[[_dataInfo valueForKey:@"Vehicle"] objectAtIndex:i]];
            
             NSLog(@"found at %@",vehicles);
        }
        else
        {
            NSLog(@"not found");
        }
    }
    
    CGFloat height = tblVehicle.rowHeight;
    height *= vehicles.count;
    tableviewHeightConstraint.constant = height+50;
    
    [tblVehicle setNeedsLayout];
    [tblVehicle setNeedsDisplay];
    [tblVehicle reloadData];
    
    [self.view setNeedsUpdateConstraints];
}
-(void)HighLite
{
    if (Checked && IsObNotNil([KAppDelegate.CardDetail valueForKey:@"number"]))
    {
        [btnRequest setBackgroundColor:[UIColor colorWithRed:10/255.0f green:228/255.0f blue:135/255.0f alpha:1.0]];
    }
}
-(void)viewOndemandTapped:(UIGestureRecognizer *)recognizer
{
    NSLog(@"tapped");
     Checked = true;
    btnTimeSelect.hidden = YES;
    imgDemand.hidden = NO;
    lblETA.textColor = [obNet colorWithHexString:@"FF000000"];
    
    imgSchedule.hidden = YES;
    lblDateTime.textColor = [obNet colorWithHexString:@"D2D2D2"];
    
    pickerHeightConstarint.constant = 0;
    pickerViewHeightConstraint.constant = 0;
    
    CGRect frame = viewPicker.frame;
    frame.size.height = pickerViewHeightConstraint.constant;//rect.size.width;
    [viewPicker setFrame:frame];
    
    [viewPicker setNeedsUpdateConstraints];
    [pickerDate setNeedsUpdateConstraints];
    [pickerDate setNeedsLayout];
    [self.view needsUpdateConstraints];
    
     [self HighLite];
  
}
-(void)viewScheduleTapped:(UIGestureRecognizer *)recognizer
{
    NSLog(@"tapped");
    Checked = true;
    btnTimeSelect.hidden = NO;
    imgSchedule.hidden = NO;
    lblDateTime.textColor = [obNet colorWithHexString:@"FF000000"];
    
    imgDemand.hidden = YES;
    lblETA.textColor = [obNet colorWithHexString:@"D2D2D2"];
    
    pickerHeightConstarint.constant = pickerHeight;
    pickerViewHeightConstraint.constant = pickerViewheight;
    
    CGRect frame = viewPicker.frame;
    frame.size.height = pickerViewheight;//rect.size.width;
    [viewPicker setFrame:frame];
    
    
    [viewPicker setNeedsUpdateConstraints];
    [self.view needsUpdateConstraints];
    [pickerDate setNeedsUpdateConstraints];
    [pickerDate setNeedsLayout];
    
     [self HighLite];
    
}
-(void)viewAddPaymetmethodTapped:(UIGestureRecognizer *)recognizer
{
    NSLog(@"tapped");
    NSMutableDictionary *senddict = [[NSMutableDictionary alloc] init];
    [senddict setObject:@"CheckoutPage" forKey:@"From"];
    [_delegate Push:VC_PaymentMethodPage Data:senddict];

}
- (void)viewDidLayoutSubviews
{
    CGRect frame1 = btnRequest.frame;
    frame1.size.height = 60;//rect.size.width;
    [btnRequest setFrame:frame1];
    
    [scrlBack setContentSize:CGSizeMake([obNet deviceFrame].size.width, viewPayment.frame.size.height + viewSchedule.frame.size.height + viewTime.frame.size.height + viewPicker.frame.size.height + tblVehicle.frame.size.height + viewVehicle.frame.size.height + viewLocation.frame.size.height + viewTotal.frame.size.height + btnRequest.frame.size.height+50)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)loceditFire:(id)sender
{
    NSMutableDictionary *senddict = [[NSMutableDictionary alloc] init];
    [senddict setObject:[_dataInfo valueForKey:@"Vehicle"] forKey:@"Vehicle"];
    [senddict setObject:@"checkout" forKey:@"From"];
    [_delegate Push:VC_AddLocationPage Data:senddict];
}
- (void) dateChanged:(id)sender
{
    // handle date changes
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMM d,YYYY hh:mm aa"];
    lblDateTime.text =  [dateFormat stringFromDate:[pickerDate date]];
    
}
- (IBAction)timeSelectFire:(id)sender
{
    btnTimeSelect.hidden = YES;
    pickerHeightConstarint.constant = 0;
    pickerViewHeightConstraint.constant = 0;
    
    CGRect frame = viewPicker.frame;
    frame.size.height = pickerViewHeightConstraint.constant;//rect.size.width;
    [viewPicker setFrame:frame];
    
    [viewPicker setNeedsUpdateConstraints];
    [pickerDate setNeedsUpdateConstraints];
    [pickerDate setNeedsLayout];
    [self.view needsUpdateConstraints];
    
}


////////////////////////////////////////////////////   TableView Dele and Source Method  /////////////////////////////////////////////////////////////

#pragma mark TableView Delegate methods For Menu

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //minimum size of your cell, it should be single line of label if you are not clear min. then return UITableViewAutomaticDimension;
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     return UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return vehicles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"VehicleList";
    VehicleListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[VehicleListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.layer.backgroundColor = [UIColor clearColor].CGColor;
    cell.backgroundColor = [UIColor clearColor];
    
    VehicleObData *obData = vehicles[indexPath.row];
    
    cell.lblYear.text = [NSString stringWithFormat:@"%@ %@ %@",[obData valueForKey:@"model_year"] , [obData valueForKey:@"make"] , [obData valueForKey:@"model"]];
    cell.lblType.text = [obData valueForKey:@"type"];
    
    cell.lblPackage.text = @"";
    cell.imgCheck.hidden = YES;
    cell.btnMsg.hidden = YES;
    [cell.btnSelect setTitle:@"Remove" forState:UIControlStateNormal];
    [cell.btnSelect setTitleColor:[obNet colorWithHexString:@"D0011B"] forState:UIControlStateNormal];
    
    [cell.btnSelect addTarget:self action:@selector(RemoveFire:event:) forControlEvents:UIControlEventTouchUpInside];
    
   
    NSMutableAttributedString *attributedStringsecond = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Package: %@$%.f",[[KAppDelegate.packages objectForKey:[obData valueForKey:@"veh_id"]] valueForKey:@"title"],[[KAppDelegate.PackagePrice objectForKey:[obData valueForKey:@"veh_id"]] floatValue]]];
    [attributedStringsecond addAttribute:NSForegroundColorAttributeName
                                   value:[UIColor colorWithRed:94/255 green:94/255 blue:94/255 alpha:1]
                                   range:NSMakeRange(0, 8)];
    [attributedStringsecond addAttribute:NSUnderlineStyleAttributeName
                                   value:[NSNumber numberWithInteger:NSUnderlineStyleSingle]
                                   range:NSMakeRange(0, attributedStringsecond.length)];
    cell.lblPackage.attributedText = attributedStringsecond;
    cell.btnSelect.hidden = NO;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(IBAction)RemoveFire:(id)sender event:(id)event
{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:tblVehicle];
    NSIndexPath *indexPath = [tblVehicle indexPathForRowAtPoint:currentTouchPosition];
    
    NSString *ids = [[vehicles valueForKey:@"veh_id"] objectAtIndex:indexPath.row];
 
       if ([KAppDelegate.packages objectForKey:ids])
        {
            [KAppDelegate.packages removeObjectForKey:ids];
            [KAppDelegate.intructions removeObjectForKey:ids];
            [KAppDelegate.PackagePrice removeObjectForKey:ids];
        }
        else
        {
            NSLog(@"not found");
        }
    
    if (KAppDelegate.packages.count > 0)
    {
         [self findVehicleFromPackages];
    }
    else
    {
        [_delegate Push:VC_HomePage Data:nil];
    }
    
}
#define  request Fire Here


- (IBAction)requestFire:(id)sender
{
     NSString * msg = nil;
    if ([lblAddPayment.text isEqualToString:@"Add a Payment Method"])
    {
         msg = @"Please Select Payment Method";
    }
    else if (Checked == false)
    {
         msg = @"Please Select Schedule Wash";
    }
    if (msg)
    {
        ToastMSG(msg);
    }
    else
    {
    
        NSMutableString *veh_ids = [[NSMutableString alloc] init];
        NSMutableString *pkg_ids = [[NSMutableString alloc] init];
        NSMutableString *inst_ids = [[NSMutableString alloc] init];
        
        for (int i = 0; i <vehicles.count; i++)
        {
            
            [veh_ids appendString:[NSString stringWithFormat:@"%@,",[vehicles objectAtIndex:i][@"veh_id"]]];
            [pkg_ids appendString:[NSString stringWithFormat:@"%@,",[[KAppDelegate.packages objectForKey:[[vehicles valueForKey:@"veh_id"] objectAtIndex:i]]valueForKey:@"pkg_id"]]];
            [inst_ids appendString: [NSString stringWithFormat:@"%@,",[KAppDelegate.intructions valueForKey:[[vehicles valueForKey:@"veh_id"] objectAtIndex:i]]]];
            
        }
         veh_ids = (NSMutableString*)[veh_ids substringToIndex:[veh_ids length]-1];
         pkg_ids = (NSMutableString*)[pkg_ids substringToIndex:[pkg_ids length]-1];
         inst_ids = (NSMutableString*)[inst_ids substringToIndex:[inst_ids length]-1];
        
        
        UserInfo *ob = [obNet getUserInfoObject];
        NSMutableDictionary * mD = [NSMutableDictionary new];
        
        mD[@"cust_id"] = ob.data.cust_id;
        mD[@"veh_ids"] = veh_ids;
        mD[@"pkg_ids"] = pkg_ids;
        mD[@"inst_ids"] = inst_ids;
        mD[@"loc_id"] = [[KAppDelegate.locationDict valueForKey:@"FinalLocation"] valueForKey:@"loc_id"];
        mD[@"pay_id"] = @"1";
        mD[@"order_total"] = lblTotal.text;
        mD[@"ondemand"] = @"";
        mD[@"message"] = @"First Order";
        mD[@"schedule"] = lblDateTime.text;
        
        [obNet JSONFromWebServices:WS_washcart Parameter:mD Method:@"POST" AI:YES PopUP:YES Caller:CALLER WithBlock:^(id json)
         {
             if (IsObNotNil(json))
             {
                 if ([json[@"success"] integerValue] == 1)
                 {
                     ToastMSG(json[@"message"][@"title"]);
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
