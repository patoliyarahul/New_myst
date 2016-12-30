//
//  RequestDemoPage.m
//  Myst
//
//  Created by Vipul Jikadra on 31/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import "RequestDemoPage.h"
#import "ExploreCell.h"
@interface RequestDemoPage ()

@end

@implementation RequestDemoPage

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    tblPckage.delegate = self;
    tblPckage.dataSource = self;
    [tblPckage registerNib:[UINib nibWithNibName:@"ExploreCell" bundle:nil] forCellReuseIdentifier:@"ExploreCell"];
    
    name = [[NSMutableArray alloc] initWithObjects:@"How Does Auto Detailing Clay Work?",@"What is Wax?",@"Benefit of a Polish",@"Why Condition your Leather?", nil];
    Descrption = [[NSMutableArray alloc] initWithObjects:@"Detailing clay glides along the surface of your paint and grabs anything that protrudes from the surface. It removes brake dust, rail dust, overspray and industrial pollution.",@"Wax protects paint from ultraviolet light, salt, dirt, rain, bug guts, and bird poop on the clear coat’s surface. It also provides a fantastic long lasting shine !",@"Polishing removes swirl marks, water spots and haze that makes the paint surface look dull. ",@"Consider leather as your skin. Leather has pores and it needs hydration. Leather conditioner acts as a lotion for the interior of your car.", nil];
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
    
    return name.count;
    
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
    cell.backgroundColor = [obNet colorWithHexString:@"4A4A4A"];
    cell.AI.hidden = YES;
    cell.lblPackageDescrption.textColor = [UIColor whiteColor];
    cell.lblPackageDescrption.font = [UIFont fontWithName:@SFUIDisplay_Regular size:16];
    [cell.imgPackage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"demo%i",indexPath.row+1]]];
    cell.lblPackageName.text = [name objectAtIndex:indexPath.row];
    
    cell.lblPackageDescrption.text = [Descrption objectAtIndex:indexPath.row];
    
    [cell.btnRequest addTarget:self action:@selector(RequestFire:event:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
-(IBAction)RequestFire:(id)sender event:(id)event
{
    [_delegate Push:VC_AddvehiclePage Data:nil];
}

@end
