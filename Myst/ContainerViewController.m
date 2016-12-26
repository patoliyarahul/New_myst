//
//  ContainerViewController.m
//  GigMail
//
//  Created by Ideal IT Techno on 20/04/13.
//  Copyright (c) 2013 Ideal It Technology. All rights reserved.
//

#import "ContainerViewController.h"
#import "ContainerWork.h"
//#import "Email_Ob.h"
//#import "EditProfile.h"
//#import "MealOb.h"
#import "VehiclePage.h"
#import "LocationPage.h"



@interface ContainerViewController ()
{

    
}

@end

@implementation ContainerViewController
@synthesize  viewAddVisitor, newVC, viewContainer, lblHeader, btnBack, btnMenu, setFilters, viewFilters, btnClear, btnSubmitReview;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   
    
    menuAnimation = NO;
    boolIsOpen = NO;
    
    [[ContainerWork ContainerWorkObject:self] InitMainVCStack];
    
    [tblMenu setShowsHorizontalScrollIndicator:NO];
    [tblMenu setShowsVerticalScrollIndicator:NO];
    
    [tblMenu reloadData];
    
    tblMenu.delegate = self;
    tblMenu.dataSource = self;
    
    [[ContainerWork ContainerWorkObject:self] ContainerOpenWithVC:newVC];
    
    
    btnClear.hidden = YES;
    btnSubmitReview.hidden = YES;
    
    _applyBtn.layer.cornerRadius  = 10.0f;
    
    tblMenu.tableHeaderView = headerView;
    tblMenu.tableFooterView = footerView;
    
    _viewMenu.hidden = YES;
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    self.leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    
    self.leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    self.rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:self.leftSwipeGestureRecognizer];
    [self.view addGestureRecognizer:self.rightSwipeGestureRecognizer];

}
- (void)handleSwipes:(UIPanGestureRecognizer *) sendr
{
    UISwipeGestureRecognizer * sender = (UISwipeGestureRecognizer *) sendr;
    if (_Open)
    {
        if (sender.direction == UISwipeGestureRecognizerDirectionLeft)
        {
            NSLog(@"Close");
            flageIsMenuCame = false;
            [self performSelectorInBackground:@selector(AnimateMenu) withObject:nil];
            [tblMenu reloadData];

        }
        
        if (sender.direction == UISwipeGestureRecognizerDirectionRight)
        {
            
             NSLog(@"Opennnnnnnn");
            [_viewMenu setHidden:NO];
            [self performSelectorInBackground:@selector(AnimateMenu) withObject:nil];
            [tblMenu reloadData];
            
        }
    }
}
- (void) DismissContainer
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
}

- (void)viewDidAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
    viewHeader = nil;
    [super viewDidUnload];
}

#pragma mark Container Methods -- Starts

#pragma mark TableView Delegate methods For Menu

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 55.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    unsigned long int count = [[ContainerWork ContainerWorkObject:self] getMArrMenu].count;
    
    return count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * ids = @"tableView";
    
    ContainerMenuCell * cell = [tableView dequeueReusableCellWithIdentifier:ids];
    
    if (!cell)
    {
        NSArray * arr = nil;
        arr = [[NSBundle mainBundle] loadNibNamed:@"ContainerMenuCell" owner:self options:nil];
        
        if (arr)
            if (arr.count > 0)
                cell = arr[0];
    }
     NSMutableDictionary * mDict = [[ContainerWork ContainerWorkObject:self] getMArrMenu][indexPath.row];
    
    cell.lblTitle.text = mDict[@"TITLE"];
    cell.imgCell.image = [UIImage imageNamed:mDict[@"IMAGE"]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.layer.backgroundColor = [UIColor clearColor].CGColor;
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row == 0)
    {
        /// ~Home
        
        
      //  [[ContainerWork ContainerWorkObject:self] Push:VC_Home Data:nil];
    }
    else  if (indexPath.row == 11)
    {
        
        //// Logout
        
        UserInfo * obUser = nil;
        [obNet setUserInfoObject:obUser];
        
      //  [[ContainerWork ContainerWorkObject:self] ContainerOpenWithVC:VC_Menu_Login];
        
        
    }
    else
    {
        
    }
}

- (IBAction)actionResignKeyboard:(id)sender
{
    [self.view endEditing:YES];
}

- (IBAction) btnMenuVC:(id)sender {
    UIButton * btn = (UIButton *) sender;
    
    [[ContainerWork ContainerWorkObject:self] ContainerOpenWithVC:(unsigned int)btn.tag];
}



- (IBAction)btnMenu:(id)sender
{
    if (IsObNotNil([[[obNet getUserInfoObject] valueForKey:@"data"] valueForKey:@"name"]))
    {
        lblName.text = [[[obNet getUserInfoObject] valueForKey:@"data"] valueForKey:@"name"];
    }
    [_viewMenu setHidden:NO];
  
    [self performSelectorInBackground:@selector(AnimateMenu) withObject:nil];
    [tblMenu reloadData];
}

- (IBAction)btnBack:(id)sender
{
   
    
    [[ContainerWork ContainerWorkObject:self] PopViewController];
}

- (void) AnimateMenu {
    if (flageIsMenuCame) {
        [tblMenu setContentOffset:CGPointZero];
        [UIView animateWithDuration:MenuAnimateTime animations:^{
            CGRect frame = viewAnimation.frame;
            frame.origin.x = 0.0;//rect.size.width;
            [viewAnimation setFrame:frame];
            
            [btnMenuShadow setHidden:NO];
            
            CGRect frameHeader = viewHeader.frame;
            frameHeader.origin.x = viewAnimation.frame.size.width;
            [viewHeader setFrame:frameHeader];
            
        
            // Open
            
            CGRect frame2 = btnMenu.frame;
            frame2.origin.x = [obNet deviceFrame].size.width  - 140;//rect.size.width;
            [btnMenu setFrame:frame2];
            
            CGRect frame1 = _imgHeader.frame;
            frame1.origin.x = frame2.origin.x + 50;//rect.size.width;
            [_imgHeader setFrame:frame1];
    

        }];
    } else {
        [UIView animateWithDuration:MenuAnimateTime animations:^{
            CGRect frame = viewAnimation.frame;
            frame.origin.x = -viewAnimation.frame.size.width;
            [viewAnimation setFrame:frame];
            
            [btnMenuShadow setHidden:YES];
            
            CGRect frameHeader = viewHeader.frame;
            frameHeader.origin.x = 0.0;
            [viewHeader setFrame:frameHeader];
            
            // Close
            
            CGRect frame2 = btnMenu.frame;
            frame2.origin.x = 0.0;//rect.size.width;
            [btnMenu setFrame:frame2];
            
            CGRect frame1 = _imgHeader.frame;
            frame1.origin.x = frame2.origin.x + 50;//rect.size.width;
            [_imgHeader setFrame:frame1];
            
        }];
    }
    
    flageIsMenuCame = !flageIsMenuCame;
}

- (void) AnimateMenuBack {
    [UIView animateWithDuration:MenuAnimateTime animations:^{
        
        CGRect frame = viewAnimation.frame;
        frame.origin.x = -viewAnimation.frame.size.width;
        [viewAnimation setFrame:frame];
        
        [btnMenuShadow setHidden:YES];
        
        CGRect frameHeader = viewHeader.frame;
        frameHeader.origin.x = 0.0;
        [viewHeader setFrame:frameHeader];
        
        flageIsMenuCame = YES;
    }];
}

- (void) animateBackBtn:(int) which {
    imgAnimationTesting.image = [UIImage new];
    
    NSMutableArray * myImages = nil;
    
    if (which == 1)
        myImages = mArrMenu_Back;
    else if (which == 2)
        myImages = mArrBack_Menu;
    else if (which == 3)
        myImages = mArraBack_Back;
    else if (which == 4)
        myImages = mArrMenu_Menu;
    
    imgAnimationTesting.hidden = NO;
    imgAnimationTesting.animationImages = myImages;
    imgAnimationTesting.animationDuration = 0.5;
    imgAnimationTesting.animationRepeatCount = 1;
    //imgAnimationTesting.an
    [imgAnimationTesting startAnimating];
    
    NSLog(@"which %d", which);
    
    [self performSelectorInBackground:@selector(setMenuBackIMage:) withObject:[NSNumber numberWithInt:which]];
}

- (void) setMenuBackIMage:(NSNumber *) number {
    sleep(1.0);
    
    NSLog(@"number.intValue %d", number.intValue);
    
    if (number.intValue == 1 || number.intValue == 3)
        imgAnimationTesting.image = [UIImage imageNamed:@"Back.png"];
    else
        imgAnimationTesting.image = [UIImage imageNamed:@"menu555-1.png"];
}

#pragma mark Container Methods -- Ends

#pragma mark - Container Extra Delegate Methods

#pragma mark Container Extra Delegate Methods -- Ends

#pragma mark - Email Delegate Method

- (void) btnChoosePicture:(UIImageView *) imgView
{

    imgFromImagePicker = imgView;
    
    UIActionSheet * actionSheet = [[UIActionSheet alloc]initWithTitle:@"CHOOSE PICTURE" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"From Camera" otherButtonTitles:@"From Gallery",nil];
    [actionSheet showInView:self.view];
}

#pragma mark - Action Sheet Delegate For Image Picker
- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0) {
        [self imageUploadFromCamera];
    } else if(buttonIndex == 1) {
        [self imageUploadFromGallery];
    }
}

- (void) imageUploadFromGallery {
    if (!imgPkr) {
        imgPkr = [[UIImagePickerController alloc]init];
        imgPkr.delegate = (id)self;
    }
    
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary])
        imgPkr.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    else if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeSavedPhotosAlbum])
        imgPkr.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    imgPkr.allowsEditing = YES;
    
    [self presentViewController:imgPkr animated:YES completion:^{ }];
}

- (void) imageUploadFromCamera {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        imgPkr=[[UIImagePickerController alloc]init];
        
        imgPkr.sourceType = UIImagePickerControllerSourceTypeCamera;
        imgPkr.delegate = (id)self;
        imgPkr.showsCameraControls = YES;
        imgPkr.allowsEditing = YES;
        
        //[self hideStatusBar];
        [self presentViewController:imgPkr animated:YES completion:^{ }];
    }
}

- (void) logout
{
    @try {
        /*if (FBSession.activeSession.state == FBSessionStateOpen || FBSession.activeSession.state == FBSessionStateOpenTokenExtended) {
            [FBSession.activeSession closeAndClearTokenInformation];
        }*/
        
        NSHTTPCookie *cookie;
        NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (cookie in [storage cookies]) {
            NSString* domainName = [cookie domain];
            NSRange domainRange = [domainName rangeOfString:@"facebook"];
            if(domainRange.length > 0) {
                [storage deleteCookie:cookie];
            }
        }
        
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        [defaults removeObjectForKey:USERLOGINDATA];
        [defaults synchronize];
        
        //[[GPPSignIn sharedInstance] signOut];
    } @catch (NSException *exception) { }
    
    ToastMSG(@"Logout successfully");
}


- (IBAction)btnEditProfile:(id)sender {
    [[ContainerWork ContainerWorkObject:self] btnSaveData:sender];
}

- (IBAction)btnSendMail:(id)sender {
    [[ContainerWork ContainerWorkObject:self] btnSendMail:sender];
}

// Set Image ////////////////////////////////////////////////////////

- (void) borderForPictureEditInnerView {
    viewEditPictureInner.layer.masksToBounds = YES;
    viewEditPictureInner.layer.borderColor = [UIColor lightGrayColor].CGColor;
    viewEditPictureInner.layer.cornerRadius = 5.0;
    viewEditPictureInner.layer.borderWidth = 1.0;
}

- (IBAction)btnRemoveEditImageView:(id)sender {
    [viewEditPicture removeFromSuperview];
}

- (IBAction)btnDeleteRecentPictures:(id)sender {
}

- (IBAction)btnPichUpPictureFromGallery:(id)sender {
    if (!imgPkr) {
        imgPkr = [[UIImagePickerController alloc]init];
        imgPkr.delegate = (id)self;
    }
    
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary])
        imgPkr.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    else if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeSavedPhotosAlbum])
        imgPkr.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    imgPkr.allowsEditing = YES;
    
    [self presentViewController:imgPkr animated:YES completion:^{ }];
}

- (IBAction)btnPichUpPictureFromCamera:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){        imgPkr=[[UIImagePickerController alloc]init];
        
        imgPkr.sourceType = UIImagePickerControllerSourceTypeCamera;
        imgPkr.delegate = (id)self;
        imgPkr.showsCameraControls = YES;
        imgPkr.allowsEditing = YES;
        
        [self presentViewController:imgPkr animated:YES completion:^{ }];
    }
}

#pragma mark - UIImagePickerController Delegates
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self btnRemoveEditImageView:nil];
}

-(void) imagePickerController:(UIImagePickerController *) picker didFinishPickingMediaWithInfo:(NSDictionary *) info
{
    @try {
        UIImage * myImage = [info objectForKey:UIImagePickerControllerEditedImage];
        
        if (!myImage) {
            myImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        } else if (!myImage) {
            myImage = [info objectForKey:UIImagePickerControllerEditedImage];
        }
        
        if (myImage) {
            imgFromImagePicker.tag = 1;
            imgFromImagePicker.image = myImage;
                        
            //[KAppDelegate saveRecentPictureForImage:myImage];
            //[self setRecentPictureToImgView];
        } else {
            imgFromImagePicker.tag = 0;
            [obNet PopUpMSG:@"Can't get your picture" Header:@""];
        }
                
//        if (imgFromImagePicker == KAppDelegate.imgComposeMailAttachment) {
//            [[ContainerWork ContainerWorkObject:self] iGotImage:myImage];
//        }
    } @catch (NSException *exception) { }
    
    [picker dismissViewControllerAnimated:YES completion:^{
        [self btnRemoveEditImageView:nil];
    }];
}

- (void) showEmail
{
    if ([MFMailComposeViewController canSendMail])
    {
       NSArray *toRecipents = [NSArray arrayWithObject:@"daimondtrade@gmail.com"];
        
        MFMailComposeViewController * mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        
        [mc setSubject:@"Regarding DiamondTrade Query"];
        [mc setMessageBody:@"Write Your Feddback" isHTML:NO];
        [mc setToRecipients:toRecipents];
        
        [self presentViewController:mc animated:YES completion:nil];
    } else {
        //ToastMSG(@"Please coofigure your mail.");
    }
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            //[obNet PopUpMSG:@"Mail cancelled" Header:@""];
            ToastMSG(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            //[obNet PopUpMSG:@"Mail saved" Header:@""];
            ToastMSG(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            //[obNet PopUpMSG:@"Mail sent" Header:@""];
            ToastMSG(@"Mail sent");
            break;
        case MFMailComposeResultFailed: {
            //[obNet PopUpMSG:[NSString stringWithFormat:@"Mail sent failure: %@", [error localizedDescription]] Header:@""];
            NSString * ss = [NSString stringWithFormat:@"Mail sent failure: %@", [error localizedDescription]];
            
            ToastMSG(ss);
        }
            break;
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}
-(void)ShowVehicleView
{
    VehiclePage * mc = [[VehiclePage alloc] init];
    [self presentViewController:mc animated:YES completion:nil];
}
-(void)ShowLocationView
{
    LocationPage * mc = [[LocationPage alloc] init];
    [self presentViewController:mc animated:YES completion:nil];
}


- (IBAction)btnSubmitReview:(id)sender {
    [[ContainerWork ContainerWorkObject:self] btnSubmitReview:sender];
}

- (IBAction)btnRemoveMenu:(id)sender
{
    
    [UIView animateWithDuration:MenuAnimateTime animations:^{
        
        if (btnMenuShadow.hidden)
        {
            // Open
            
            CGRect frame = btnMenu.frame;
            frame.origin.x = [obNet deviceFrame].size.width  - 140;//rect.size.width;
            [btnMenu setFrame:frame];
            
            CGRect frame1 = _imgHeader.frame;
            frame1.origin.x = frame.origin.x + 50;//rect.size.width;
            [_imgHeader setFrame:frame1];
        }
        else
        {
            // Close
            
            CGRect frame = btnMenu.frame;
            frame.origin.x = 0.0;//rect.size.width;
            [btnMenu setFrame:frame];
            
            CGRect frame1 = _imgHeader.frame;
            frame1.origin.x = frame.origin.x + 50;//rect.size.width;
            [_imgHeader setFrame:frame1];
            
        }
        
        
        CGRect frame = viewAnimation.frame;
        frame.origin.x = -viewAnimation.frame.size.width;
        [viewAnimation setFrame:frame];
        
        [btnMenuShadow setHidden:YES];
        
        CGRect frameHeader = viewHeader.frame;
        frameHeader.origin.x = 0.0;
        [viewHeader setFrame:frameHeader];
        
        flageIsMenuCame = YES;
    }];

    
}

- (IBAction)btnRemoveCustomPopUp:(id)sender
{
    [viewCustomPopUp removeFromSuperview];
}
- (IBAction)btnRemoveCustomPopUpNoti:(id)sender
{
    [[ContainerWork ContainerWorkObject:self] btnPushSubCat:sender];
    [viewCustomNoti removeFromSuperview];
}

- (void) addCustomPopup:(NSString *) msg
{
    if (IsObNotNil(msg)) {
        viewCustomPopUp.frame = self.view.bounds;
        lblCustomPopUPMessage.text = msg;
        [self.view addSubview:viewCustomPopUp];
    }
}


- (IBAction)SignOutFire:(id)sender
{
    CGRect frame = btnMenu.frame;
    frame.origin.x = 0.0;//rect.size.width;
    [btnMenu setFrame:frame];
    
    CGRect frame1 = _imgHeader.frame;
    frame1.origin.x = frame.origin.x + 50;//rect.size.width;
    [_imgHeader setFrame:frame1];
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:USERLOGINDATA];
    [defaults synchronize];
    
    [[ContainerWork ContainerWorkObject:self] Push:VC_TutorialPage Data:nil];
}


- (IBAction)saveFire:(id)sender
{
    [[ContainerWork ContainerWorkObject:self] SaveFire];
}
- (IBAction)nextFire:(id)sender
{
    [[ContainerWork ContainerWorkObject:self] setNext:sender];
}
@end
