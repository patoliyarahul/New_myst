//
//  ExplorePackagePage.m
//  Myst
//
//  Created by Vipul Jikadra on 27/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import "ExplorePackagePage.h"
#import "PackageOb.h"
#import "PackageObData.h"
#import "VehicleObData.h"
#import "ExploreCell.h"
@interface ExplorePackagePage ()
{
    PackageOb *pOB;
    PackageObData *obDataIndex;
}
@end

@implementation ExplorePackagePage

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    tblPckage.delegate = self;
    tblPckage.dataSource = self;
    [tblPckage registerNib:[UINib nibWithNibName:@"ExploreCell" bundle:nil] forCellReuseIdentifier:@"ExploreCell"];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    tblPckage.hidden = YES;
    [obNet JSONFromWebServices:WS_getPackages Parameter:nil Method:@"GET" AI:YES PopUP:YES Caller:CALLER WithBlock:^(id json)
     {
         
         if (IsObNotNil(json))
         {
             
             if ([json[@"success"] integerValue] == 1)
             {
                 
                 NSError* err = nil;
                 
                 pOB = [[PackageOb alloc]initWithDictionary:json error:&err];
                 tblPckage.hidden = NO;
                 [tblPckage reloadData];
                 
             }
             else
             {
                 ToastMSG(json[@"message"][@"title"]);
                  tblPckage.hidden = YES;
             }
             
         }
         else
         {
             ToastMSG(json[@"message"][@"title"]);
              tblPckage.hidden = YES;
         }
         
         
         
     }];
    
    
    
}
- (void)didReceiveMemoryWarning {
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
    NSString *CellIdentifier = @"ExploreCell";
    ExploreCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[ExploreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.layer.backgroundColor = [UIColor clearColor].CGColor;
    cell.backgroundColor = [UIColor clearColor];
    
    PackageObData *obData = pOB.data[indexPath.row];
    
    [cell.imgPackage GetNSetUIImage:[obData valueForKey:@"image"] DefaultImage:nil CustomScale:NO AI:cell.AI];
    cell.lblPackageName.text = [obData valueForKey:@"title"];
    
    NSMutableAttributedString *attributedStringsecond = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Includes: \n%@",[obData valueForKey:@"description"]]];
    [attributedStringsecond addAttribute:NSForegroundColorAttributeName
                                   value:[UIColor blackColor]
                                   range:NSMakeRange(0, 9)];
     cell.lblPackageDescrption.attributedText = attributedStringsecond;
    
    [cell.btnRequest addTarget:self action:@selector(RequestFire:event:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
-(IBAction)RequestFire:(id)sender event:(id)event
{
    [_delegate Push:VC_AddvehiclePage Data:nil];
}

@end
