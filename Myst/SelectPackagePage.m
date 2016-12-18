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
   

    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSMutableAttributedString *attributedStringsecond = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@",@"For: ",[_dataInfo valueForKey:@"model"]]];
    [attributedStringsecond addAttribute:NSForegroundColorAttributeName
                                   value:[UIColor colorWithRed:102/255 green:103/255 blue:102/255 alpha:1]
                                   range:NSMakeRange(0, 4)];
    
    lblMake.attributedText = attributedStringsecond;
    
    
    
    NSLog(@"attributedStringsecond = %@",attributedStringsecond);
    [obNet JSONFromWebServices:WS_getPackages Parameter:nil Method:@"GET" AI:YES PopUP:YES Caller:CALLER WithBlock:^(id json)
     {
         
         if (IsObNotNil(json))
         {
             
             if ([json[@"success"] integerValue] == 1)
             {
                 
                 NSError* err = nil;
                 
                 pOB = [[PackageOb alloc]initWithDictionary:json error:&err];
                 
                 [tablePackage reloadData];
                
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

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //minimum size of your cell, it should be single line of label if you are not clear min. then return UITableViewAutomaticDimension;
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
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
    
    PackageObData *obData = pOB.data[indexPath.row];
    
    
    cell.lblPackageName.text = [obData valueForKey:@"title"];
    cell.lblPackageDesc.text = [NSString stringWithFormat:@"%@%@",@"includes:\n",[obData valueForKey:@"description"]];
    cell.lblPrice.text =[NSString stringWithFormat:@"$%.f",[[obData valueForKey:@"price"] floatValue]];
    cell.imgCheck.hidden = YES;
    
    
    VehicleObData *vobData = [_dataInfo valueForKey:@"VehicleObData"];
   
    
    if ([[KAppDelegate.packages valueForKey:[vobData valueForKey:@"veh_id"]] isEqualToString:[obData valueForKey:@"title"]])
    {
        NSIndexPath* selectedCellIndexPath= [NSIndexPath indexPathForRow:indexPath.row inSection:0];
        [self tableView:tablePackage didSelectRowAtIndexPath:selectedCellIndexPath];
        [tablePackage selectRowAtIndexPath:selectedCellIndexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        NSLog(@"id = %@",[KAppDelegate.packages valueForKey:[vobData valueForKey:@"veh_id"]]);
    }
   
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
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
    
   
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
     VehicleObData *obData = [_dataInfo valueForKey:@"VehicleObData"];
    /// Set Object
    
    [KAppDelegate.packages setObject:[obDataIndex valueForKey:@"title"] forKey:[obData valueForKey:@"veh_id"]];
    [KAppDelegate.intructions setObject:[alertView textFieldAtIndex:0].text forKey:[obData valueForKey:@"veh_id"]];

    NSLog(@"New UUID, adding %@ %@",KAppDelegate.packages,KAppDelegate.intructions);
}
@end
