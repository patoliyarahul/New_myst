//
//  CheckoutPage.m
//  Myst
//
//  Created by Vipul Jikadra on 20/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import "CheckoutPage.h"
#import "VehicleListCell.h"
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
    
    pickerHeight = datePickerConstraint.constant;
    pickerViewheight = pickerViewConstraint.constant;
    
//    
//    tblVehicle.delegate = self;
//    tblVehicle.dataSource = self;
    [tblVehicle registerNib:[UINib nibWithNibName:@"VehicleListCell" bundle:nil] forCellReuseIdentifier:@"VehicleList"];
    
    
    NSLog(@"dataInfo = %@",_dataInfo);
   
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

    
    scrlContainer.frame = CGRectMake(0 , 0,  [UIScreen mainScreen].bounds.size.width, scrlContainer.frame.size.height);
    [scrlBack addSubview:scrlContainer];
    
    
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

    
    datePickerConstraint.constant = 0;
    pickerViewConstraint.constant = 0;
    
    [self.view needsUpdateConstraints];
    
    NSDate *currentDate = [NSDate date];
    pickerDate.minimumDate = currentDate;
    [pickerDate addTarget:self action:@selector(dateChanged:)
     forControlEvents:UIControlEventValueChanged];
    
    [self findVehicleFromPackages];
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
    
    
}
-(void)viewOndemandTapped:(UIGestureRecognizer *)recognizer
{
    NSLog(@"tapped");
    btnTimeSelect.hidden = YES;
    imgDemand.hidden = NO;
    lblETA.textColor = [obNet colorWithHexString:@"FF000000"];
    
    imgSchedule.hidden = YES;
    lblDateTime.textColor = [obNet colorWithHexString:@"D2D2D2"];
    
    datePickerConstraint.constant = 0;
    pickerViewConstraint.constant = 0;
    
    [self.view needsUpdateConstraints];
}
-(void)viewScheduleTapped:(UIGestureRecognizer *)recognizer
{
    NSLog(@"tapped");
     btnTimeSelect.hidden = NO;
    imgSchedule.hidden = NO;
    lblDateTime.textColor = [obNet colorWithHexString:@"FF000000"];
    
    imgDemand.hidden = YES;
    lblETA.textColor = [obNet colorWithHexString:@"D2D2D2"];
    
    datePickerConstraint.constant = pickerHeight;
    pickerViewConstraint.constant = pickerViewheight;
    [self.view needsUpdateConstraints];
    
}
-(void)viewAddPaymetmethodTapped:(UIGestureRecognizer *)recognizer
{
    NSLog(@"tapped");
    [_delegate Push:VC_AddPaymentPage Data:nil];

}
- (void)viewDidLayoutSubviews
{
    [scrlBack setContentSize:CGSizeMake([obNet deviceFrame].size.width, scrlContainer.frame.size.height)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)requestFire:(id)sender
{
}

- (IBAction)loceditFire:(id)sender
{
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
    datePickerConstraint.constant = 0;
    pickerViewConstraint.constant = 0;
    
    [self.view needsUpdateConstraints];
}


////////////////////////////////////////////////////   TableView Dele and Source Method  /////////////////////////////////////////////////////////////

#pragma mark TableView Delegate methods For Menu

//-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    //minimum size of your cell, it should be single line of label if you are not clear min. then return UITableViewAutomaticDimension;
//    return UITableViewAutomaticDimension;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return UITableViewAutomaticDimension;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return KAppDelegate..count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSString *CellIdentifier = @"VehicleList";
//    VehicleListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[VehicleListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
//    
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.layer.backgroundColor = [UIColor clearColor].CGColor;
//    cell.backgroundColor = [UIColor clearColor];
//    
//    VehicleObData *obData = vOB.data[indexPath.row];
//    
//    cell.lblYear.text = [NSString stringWithFormat:@"%@ %@ %@",[obData valueForKey:@"model_year"] , [obData valueForKey:@"make"] , [obData valueForKey:@"model"]];
//    cell.lblType.text = [obData valueForKey:@"type"];
//    
//    cell.lblPackage.text = @"";
//    cell.imgCheck.hidden = YES;
//    cell.btnMsg.hidden = YES;
//    
//    [cell.btnSelect addTarget:self action:@selector(SelectFire:event:) forControlEvents:UIControlEventTouchUpInside];
//    [cell.btnMsg addTarget:self action:@selector(MsgFire:event:) forControlEvents:UIControlEventTouchUpInside];
//    
//    if ([KAppDelegate.packages objectForKey:[[vOB.data valueForKey:@"veh_id"] objectAtIndex:indexPath.row]])
//    {
//        NSMutableAttributedString *attributedStringsecond = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Package: %@$%.f",[KAppDelegate.packages objectForKey:[[vOB.data valueForKey:@"veh_id"] objectAtIndex:indexPath.row]],[[KAppDelegate.PackagePrice objectForKey:[[vOB.data valueForKey:@"veh_id"] objectAtIndex:indexPath.row]] floatValue]]];
//        [attributedStringsecond addAttribute:NSForegroundColorAttributeName
//                                       value:[UIColor colorWithRed:94/255 green:94/255 blue:94/255 alpha:1]
//                                       range:NSMakeRange(0, 8)];
//        [attributedStringsecond addAttribute:NSUnderlineStyleAttributeName
//                                       value:[NSNumber numberWithInteger:NSUnderlineStyleSingle]
//                                       range:NSMakeRange(0, attributedStringsecond.length)];
//        cell.lblPackage.attributedText = attributedStringsecond;
//        cell.btnSelect.hidden = YES;
//        cell.imgCheck.hidden = NO;
//    }
//    else
//    {
//        cell.btnSelect.hidden = NO;
//        cell.imgCheck.hidden = YES;
//    }
//    
//    if ([KAppDelegate.intructions objectForKey:[[vOB.data valueForKey:@"veh_id"] objectAtIndex:indexPath.row]])
//    {
//        cell.btnMsg.hidden = NO;
//    }
//    
//    return cell;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}
//


@end
