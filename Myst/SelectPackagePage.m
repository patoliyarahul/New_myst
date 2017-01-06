//
//  SelectPackagePage.m
//  Myst
//
//  Created by Vipul Jikadra on 16/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import "SelectPackagePage.h"
#import "PackageCell.h"
#import "PackageOb.h"
#import "PackageObData.h"
#import "VehicleObData.h"

@interface SelectPackagePage ()
{
     PackageOb *pOB;
     PackageObData *obDataIndex;
}
@end

@implementation SelectPackagePage

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    tablePackage.delegate = self;
    tablePackage.dataSource = self;
    [tablePackage registerNib:[UINib nibWithNibName:@"PackageCell" bundle:nil] forCellReuseIdentifier:@"PackageCell"];
    tablePackage.estimatedRowHeight = 200.0;
    tablePackage.rowHeight = UITableViewAutomaticDimension;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    Open = false;
    
    NSMutableAttributedString *attributedStringsecond = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@",@"For: ",[_dataInfo valueForKey:@"model"]]];
    [attributedStringsecond addAttribute:NSForegroundColorAttributeName
                                   value:[UIColor colorWithRed:102/255 green:103/255 blue:102/255 alpha:1]
                                   range:NSMakeRange(0, 4)];
    
    lblMake.attributedText = attributedStringsecond;
    
    
    tablePackage.hidden = YES;
    NSMutableDictionary * mD = [NSMutableDictionary new];
    
    VehicleObData *vobData = [_dataInfo valueForKey:@"VehicleObData"];
    
    UserInfo *ob = [obNet getUserInfoObject];
    
    mD[@"cust_id"] = ob.data.cust_id;
    mD[@"type"] = [vobData valueForKey:@"type"];

    [obNet JSONFromWebServices:WS_getPackages Parameter:mD Method:@"POST" AI:YES PopUP:YES Caller:CALLER WithBlock:^(id json)
     {
         
         if (IsObNotNil(json))
         {
             
             if ([json[@"success"] integerValue] == 1)
             {
                 
                 NSError* err = nil;
                 
                 pOB = [[PackageOb alloc]initWithDictionary:json error:&err];
                 
                 [tablePackage reloadData];
                 tablePackage.hidden = NO;
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark TableView Delegate methods For Menu

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //minimum size of your cell, it should be single line of label if you are not clear min. then return UITableViewAutomaticDimension;
   
    return  UITableViewAutomaticDimension;
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  
    return pOB.data.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"PackageCell";
    PackageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[PackageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.layer.backgroundColor = [UIColor clearColor].CGColor;
    cell.backgroundColor = [UIColor clearColor];
    
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
   
    return cell;
}
- (void)configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell isKindOfClass:[PackageCell class]])
    {
        PackageObData *obData = pOB.data[indexPath.row];
        
        PackageCell *cell1 = (PackageCell *)cell;
        
        cell1.lblPackageName.text = [obData valueForKey:@"title"];
        cell1.lblPackageDesc.text = [NSString stringWithFormat:@"%@%@",@"includes:\n",[obData valueForKey:@"description"]];
        
        cell1.imgCheck.hidden = YES;
        
        
        VehicleObData *vobData = [_dataInfo valueForKey:@"VehicleObData"];
        
        ///// Logic For Selected Package
        
        if ([[[KAppDelegate.packages objectForKey:[vobData valueForKey:@"veh_id"]] valueForKey:@"title"] isEqualToString:[obData valueForKey:@"title"]])
        {
            NSIndexPath* selectedCellIndexPath= [NSIndexPath indexPathForRow:indexPath.row inSection:0];
            [self tableView:tablePackage didSelectRowAtIndexPath:selectedCellIndexPath];
            [tablePackage selectRowAtIndexPath:selectedCellIndexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
            NSLog(@"id = %@",[KAppDelegate.packages valueForKey:[vobData valueForKey:@"veh_id"]]);
        }
        
        
      cell1.lblPrice.text =[NSString stringWithFormat:@"$%.f",[[obData valueForKey:@"price"] floatValue]];
        
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (Open)
    {
        obDataIndex = pOB.data[indexPath.row];
        
        VehicleObData *obData = [_dataInfo valueForKey:@"VehicleObData"];
        /// Set Object
        
        [KAppDelegate.packages setObject:obDataIndex forKey:[obData valueForKey:@"veh_id"]];
        
        [KAppDelegate.intructions setObject:alertText forKey:[obData valueForKey:@"veh_id"]];
       
        [KAppDelegate.PackagePrice setObject:[obDataIndex valueForKey:@"price"] forKey:[obData valueForKey:@"veh_id"]];
   
        
        NSLog(@"New UUID, adding %@ %@",KAppDelegate.packages,KAppDelegate.intructions);
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Special Instructions"
                                                        message:@"Let us know more detail(optional)"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Save",nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alert textFieldAtIndex:0].text = [KAppDelegate.intructions objectForKey:[[_dataInfo valueForKey:@"VehicleObData"] valueForKey:@"veh_id"]];
        [alert show];
        obDataIndex = pOB.data[indexPath.row];
        Open = YES;
    }

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
     VehicleObData *obData = [_dataInfo valueForKey:@"VehicleObData"];
    /// Set Object
    
    [KAppDelegate.packages setObject:obDataIndex forKey:[obData valueForKey:@"veh_id"]];
    
    [KAppDelegate.intructions setObject:[alertView textFieldAtIndex:0].text forKey:[obData valueForKey:@"veh_id"]];
    [KAppDelegate.PackagePrice setObject:[obDataIndex valueForKey:@"price"] forKey:[obData valueForKey:@"veh_id"]];

    alertText = [alertView textFieldAtIndex:0].text;
    NSLog(@"New UUID, adding %@ %@",KAppDelegate.packages,KAppDelegate.intructions);
}
@end
