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

#define AUDIO_MAX_TIME 10

@interface ContainerViewController ()
{
    AVAudioRecorder *recorder;
    AVAudioPlayer *player;
    
    BOOL exitLimitor;
    BOOL shouldCounterAudioTime;
    int audioTime;
    
    UIImage * imgFilterSelected;
    UIImage * imgFilterSelectedUn;
}

@end

@implementation ContainerViewController
@synthesize viewNewFilter, viewTwoFilters, lblCartTotalCount, viewSendMailAttchment, viewAddVisitor, newVC, viewContainer, lblHeader, btnBack, btnMenu, viewEditProfile, viewComposeMail, viewReply, btnAudioPlayButton, btnAudioRecordPauseButton, btnAudioStopButton, btnEditProfileSave, setFilters, viewFilters, btnClear, btnSubmitReview;

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
    
    [viewReply removeFromSuperview];
    
    imgFilterSelected = [UIImage imageNamed:@"makeChoiseSe"];
    imgFilterSelectedUn = [UIImage imageNamed:@"makeChoiseUn"];
    
    menuAnimation = NO;
    boolIsOpen = NO;
    
    [[ContainerWork ContainerWorkObject:self] InitMainVCStack];
    
    [tblMenu setShowsHorizontalScrollIndicator:NO];
    [tblMenu setShowsVerticalScrollIndicator:NO];
    
    [tblMenu reloadData];
    
    tblMenu.delegate = self;
    tblMenu.dataSource = self;
    
    [[ContainerWork ContainerWorkObject:self] ContainerOpenWithVC:newVC];
    
    arrPaymentType = @[@{@"name":@"Monthly", @"value":@"monthly"},@{@"name":@"Manual", @"value":@"manual"}];
    btnEditProfileSave.hidden = YES;
    btnClear.hidden = YES;
    btnSubmitReview.hidden = YES;
    
    [obNet setBorder:lblCartTotalCount Color:[UIColor lightGrayColor] CornerRadious:lblCartTotalCount.frame.size.height/2 BorderWidth:1.0];
    
    [self makeArraysForMenuBackAnimation];
    
    [self initViewAskToPractitioner];
    
    [self viewCustomPopUpBorder];
    
    _applyBtn.layer.cornerRadius  = 10.0f;
    
    tblMenu.tableHeaderView = headerView;
    tblMenu.tableFooterView = footerView;
    
    _viewMenu.hidden = YES;
}
#define OpenImage
//- (void) OpenPicture:(NSArray *)arrImgView title:(NSArray *)TitleArray index:(int)index
//{
//    
//    SYPhotoBrowser *photoBrowser = [[SYPhotoBrowser alloc] initWithImageSourceArray:arrImgView caption:TitleArray delegate:self];
//    photoBrowser.initialPageIndex = index;
//    photoBrowser.pageControlStyle = SYPhotoBrowserPageControlStyleLabel;
//    photoBrowser.enableStatusBarHidden = YES;
//    [self presentViewController:photoBrowser animated:YES completion:nil];
//}
- (void) DismissContainer
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
    else  if (indexPath.row == 1)
    {
        
        //// Profile
        
    //    [[ContainerWork ContainerWorkObject:self] Push:viewEditProfile Data:nil];
    }
    else  if (indexPath.row == 2)
    {
        
        //// Favourites
        
       // [[ContainerWork ContainerWorkObject:self] Push:VC_FavPage Data:nil];
        
        
    }
    else  if (indexPath.row == 3)
    {
        
        //// Notification
        
        [[ContainerWork ContainerWorkObject:self] Push:VC_Notification Data:nil];
        
        
    }
    else  if (indexPath.row == 4)
    {
        
        //// rapa port
        
        [[ContainerWork ContainerWorkObject:self] Push:VC_Rapaport Data:nil];
        
        
    }
    else  if (indexPath.row == 5)
    {
        
        //// sale your product
        
        [[ContainerWork ContainerWorkObject:self] Push:VC_Salepage Data:nil];
        
        
    }
    else  if (indexPath.row == 6)
    {
        
        //// share
        
        NSString * message = @"Hi, I am happy to share this awesome Diamond Trade app with you!";
        
        NSURL *url=[NSURL URLWithString:@"https://itunes.apple.com/us/app/maaish/id1068433668?ls=1&mt=8"];
        
        NSArray * shareItems = @[message, url];
        
        UIActivityViewController * avc = [[UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:nil];
        
        [self presentViewController:avc animated:YES completion:nil];
        
        
    }
    else  if (indexPath.row == 7)
    {
        
        //// about us
        
        [[ContainerWork ContainerWorkObject:self] Push:VC_Aboutus Data:nil];
        
        
    }
    else  if (indexPath.row == 8)
    {
        
        //// contact us
        
        [[ContainerWork ContainerWorkObject:self] Push:VC_GetContact  Data:nil];
        
        
    }
 
    else  if (indexPath.row == 9)
    {
        
        //// rate us
        
        NSString *str;
        float ver = [[[UIDevice currentDevice] systemVersion] floatValue];
        if (ver >= 7.0 && ver < 7.1) {
            str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@",@"1110647291"];
        } else if (ver >= 8.0) {
            str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software",@"1110647291"];
        } else {
            str = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",@"1110647291"];
        }
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
    }
    else  if (indexPath.row == 10)
    {
        
        //// t&C
        
        [[ContainerWork ContainerWorkObject:self] Push:VC_TermsPage Data:nil];
        
        
    }
    else  if (indexPath.row == 11)
    {
        
        //// Logout
        
        UserInfo * obUser = nil;
        [obNet setUserInfoObject:obUser];
        
      //  [[ContainerWork ContainerWorkObject:self] ContainerOpenWithVC:VC_Menu_Login];
        
        
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

- (void) makeArraysForMenuBackAnimation {
//    mArraBack_Back = [NSMutableArray new];
//    {
//        for (int i = 1; i <= 34; i++)
//            [mArraBack_Back addObject:[UIImage imageNamed:[NSString stringWithFormat:@"arrow_%d.png", i]]];
//    }
//    
//    mArrMenu_Menu = [NSMutableArray new];
//    {
//        for (int i = 1; i <= 36; i++)
//            [mArrMenu_Menu addObject:[UIImage imageNamed:[NSString stringWithFormat:@"s%d.png", i]]];
//    }
//    
//    mArrBack_Menu = [NSMutableArray new];
//    {
//        for (int i = 1; i <= 17; i++)
//            [mArrBack_Menu addObject:[UIImage imageNamed:[NSString stringWithFormat:@"arrow_%d.png", i]]];
//        
//        for (int i = 18; i <= 36; i++)
//            [mArrBack_Menu addObject:[UIImage imageNamed:[NSString stringWithFormat:@"s%d.png", i]]];
//    }
//    
//    mArrMenu_Back = [NSMutableArray new];
//    {
//        for (int i = 1; i <= 18; i++)
//            [mArrMenu_Back addObject:[UIImage imageNamed:[NSString stringWithFormat:@"s%d.png", i]]];
//        
//        for (int i = 19; i <= 34; i++)
//            [mArrMenu_Back addObject:[UIImage imageNamed:[NSString stringWithFormat:@"arrow_%d.png", i]]];
//    }
}

- (IBAction)btnMenu:(id)sender
{
    if (IsObNotNil([[[obNet getUserInfoObject] valueForKey:@"data"] valueForKey:@"name"]))
    {
        lblName.text = [[[obNet getUserInfoObject] valueForKey:@"data"] valueForKey:@"name"];
    }
    [_viewMenu setHidden:NO];
    [self menuBackImagesAnimation];
    [self performSelectorInBackground:@selector(AnimateMenu) withObject:nil];
    [tblMenu reloadData];
}

- (IBAction)btnBack:(id)sender
{
    [self menuBackImagesAnimation];
    
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
//    
//    viewEditPicture.frame = self.view.bounds;
//    [self.view addSubview:viewEditPicture];
//    
//    [self setRecentPictureToImgView];
    
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

- (IBAction)btnRecentPicture1:(id)sender {
    imgFromImagePicker.image = imgRecentP1.image;
    imgFromImagePicker.tag = 1;
    
    [self btnRemoveEditImageView:nil];
    
//    if (imgFromImagePicker == KAppDelegate.imgComposeMailAttachment) {
//        [[ContainerWork ContainerWorkObject:self] iGotImage:imgRecentP1.image];
//    }
}

- (IBAction)btnRecentPicture2:(id)sender {
    imgFromImagePicker.image = imgRecentP2.image;
    imgFromImagePicker.tag = 1;
    
    [self btnRemoveEditImageView:nil];
    
//    if (imgFromImagePicker == KAppDelegate.imgComposeMailAttachment) {
//        [[ContainerWork ContainerWorkObject:self] iGotImage:imgRecentP2.image];
//    }
}

- (IBAction)btnRecentPicture3:(id)sender {
    imgFromImagePicker.image = imgRecentP3.image;
    imgFromImagePicker.tag = 1;
    
    [self btnRemoveEditImageView:nil];
    
//    if (imgFromImagePicker == KAppDelegate.imgComposeMailAttachment) {
//        [[ContainerWork ContainerWorkObject:self] iGotImage:imgRecentP3.image];
//    }
}

- (void) setRecentPictureToImgView {
    /*[imgRecentP1 getSavedPicture:[KAppDelegate getRPAt:1] Block:^(UIImage * image) {
        if (image) {
            imgRecentP1.image = image;
            [btnRecentPicture1 setUserInteractionEnabled:YES];
        } else {
            [btnRecentPicture1 setUserInteractionEnabled:NO];
        }
    }];
    
    [imgRecentP2 getSavedPicture:[KAppDelegate getRPAt:2] Block:^(UIImage * image) {
        if (image) {
            imgRecentP2.image = image;
            [btnRecentPicture1 setUserInteractionEnabled:YES];
        } else {
            [btnRecentPicture1 setUserInteractionEnabled:NO];
        }
    }];
    
    [imgRecentP3 getSavedPicture:[KAppDelegate getRPAt:3] Block:^(UIImage * image) {
        if (image) {
            imgRecentP3.image = image;
            [btnRecentPicture1 setUserInteractionEnabled:YES];
        } else {
            [btnRecentPicture1 setUserInteractionEnabled:NO];
        }
    }];*/
}

- (IBAction) btnPictureSetting:(id)sender {
    viewEditPicture.frame = self.view.bounds;
    [self.view addSubview:viewEditPicture];
    
    [self setRecentPictureToImgView];
}


- (IBAction)btnAddVisitor:(id)sender {
    
}

- (IBAction)btnComposeMail:(id)sender {
    
}

//- (IBAction)btnAttchment:(id)sender {
//    [self btnChoosePicture:KAppDelegate.imgComposeMailAttachment];
//}

- (IBAction)btnReplyMail:(id)sender {
    
}

- (IBAction)btnDraft:(id)sender {
    [[ContainerWork ContainerWorkObject:self] btnDraft:sender];
}

- (void) initViewAskToPractitioner {
    viewAskToPractitionerInner.layer.masksToBounds = YES;
    viewAskToPractitionerInner.layer.cornerRadius = 7.0;
    viewAskToPractitionerInner.layer.borderColor = [UIColor lightGrayColor].CGColor;
    viewAskToPractitionerInner.layer.borderWidth = 1.0;
    
    btnAskToPractitionerEmail.layer.masksToBounds = YES;
    btnAskToPractitionerEmail.layer.cornerRadius = 5.0;
    btnAskToPractitionerEmail.layer.borderColor = [UIColor lightGrayColor].CGColor;
    btnAskToPractitionerEmail.layer.borderWidth = 1.0;
    
    btnAskToPractitionerVoiceMemo.layer.masksToBounds = YES;
    btnAskToPractitionerVoiceMemo.layer.cornerRadius = 5.0;
    btnAskToPractitionerVoiceMemo.layer.borderColor = [UIColor lightGrayColor].CGColor;
    btnAskToPractitionerVoiceMemo.layer.borderWidth = 1.0;
}

- (void) openViewAskToPractitioner:(NSMutableDictionary *) dict {
    mDictPractitioner = nil;
    mDictPractitioner = dict;
    
    viewAskToPractitioner.frame = self.view.bounds;
    
    [self.view addSubview:viewAskToPractitioner];
}

- (IBAction)btnRemoveViewAskToPractitioner:(id)sender {
    [viewAskToPractitioner removeFromSuperview];
}

//- (IBAction)btnAskToPractitionerEmail:(id)sender {
//    [self btnRemoveViewAskToPractitioner:nil];
//    
//    if (mDictPractitioner) {
//        Email_Ob * ob = [[Email_Ob alloc] init];
//        
//        if (IsObNotNil(mDictPractitioner[@"email"])) {
//            ob.emailTo = mDictPractitioner[@"email"];
//
//            [self showEmail:ob];
//        }
//    }
//}
//
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
- (IBAction)btnAskToPractitionerVoiceMemo:(id)sender {
    [self btnRemoveViewAskToPractitioner:nil];
    
    if (mDictPractitioner) {
        [self initAudioPlayer];
        
        viewAudioRecorder.frame = self.view.bounds;
        
        [self.view addSubview:viewAudioRecorder];
    }
}

- (IBAction)btnSubmitReview:(id)sender {
    [[ContainerWork ContainerWorkObject:self] btnSubmitReview:sender];
}

- (void) initAudioPlayer
{
    // Disable Stop/Play button when application launches
    [btnAudioStopButton setEnabled:NO];
    [btnAudioPlayButton setEnabled:NO];
    
    // Set the audio file
    NSArray *pathComponents = [NSArray arrayWithObjects:
                               [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],
                               @"MyAudioMemo.m4a",
                               nil];
    outputFileURL = [NSURL fileURLWithPathComponents:pathComponents];
    
    NSLog(@"outputFileURL %@", outputFileURL);
    
    // Setup audio session
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    // Define the recorder setting
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
    
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    [recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
    [recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
    
    // Initiate and prepare the recorder
    recorder = [[AVAudioRecorder alloc] initWithURL:outputFileURL settings:recordSetting error:nil];
    recorder.delegate = self;
    recorder.meteringEnabled = YES;
    [recorder prepareToRecord];
    
    audioTime = 0;
    
    exitLimitor = NO;
    shouldCounterAudioTime = NO;
    
    [self performSelectorInBackground:@selector(audioRecorderLimitor) withObject:nil];
}

- (IBAction)btnAudioRecordPauseTapped:(id)sender {
    // Stop the audio player before recording
    if (player.playing) {
        [player stop];
    }
    
    if (exitLimitor)
        [self performSelectorInBackground:@selector(audioRecorderLimitor) withObject:nil];
    
    exitLimitor = NO;
    
    if (!recorder.recording) {
        shouldCounterAudioTime = YES;
        
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        
        //Start recording
        [recorder record];
        [btnAudioRecordPauseButton setTitle:@"Pause" forState:UIControlStateNormal];
    } else {
        shouldCounterAudioTime = NO;
        
        //Pause recording
        [recorder pause];
        [btnAudioRecordPauseButton setTitle:@"Record" forState:UIControlStateNormal];
    }
    
    [btnAudioStopButton setEnabled:YES];
    [btnAudioPlayButton setEnabled:NO];
}

- (IBAction)btnAudioStopTapped:(id)sender {
    [recorder stop];
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setActive:NO error:nil];
    
    shouldCounterAudioTime = NO;
    audioTime = 0;
}

- (IBAction)btnAudioPlayTapped:(id)sender {
    if (!recorder.recording){
        {
            AVAudioSession *audioSession = [AVAudioSession sharedInstance]; // get your audio session somehow
            NSError * error = nil;
            
            BOOL success = [audioSession overrideOutputAudioPort:AVAudioSessionPortOverrideSpeaker error:&error];
            if(!success)
                NSLog(@"error doing outputaudioportoverride - %@", [error localizedDescription]);
        }
        
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:recorder.url error:nil];
        [player setDelegate:self];
        [player play];
    }
    
    if (outputFileURL) {
        //NSData * data = [NSData dataWithContentsOfURL:outputFileURL];
        
        //NSLog(@"data %@", data);
    }
}

- (IBAction)btnEditProfileSave:(id)sender {
   // [[ContainerWork ContainerWorkObject:self] btnEditProile:sender];
}

//- (IBAction)btnClear:(id)sender {
//    [KAppDelegate resetSortingParameter];
//    [[ContainerWork ContainerWorkObject:self] btnClear:sender];
//}

- (IBAction)btnRemoveAudioRecorder:(id)sender {
    [viewAudioRecorder removeFromSuperview];
    
    exitLimitor = YES;
}

#pragma mark - AVAudioRecorderDelegate

- (void) audioRecorderDidFinishRecording:(AVAudioRecorder *)avrecorder successfully:(BOOL)flag {
    [btnAudioRecordPauseButton setTitle:@"Record" forState:UIControlStateNormal];
    [btnAudioStopButton setEnabled:NO];
    [btnAudioPlayButton setEnabled:YES];
}

#pragma mark - AVAudioPlayerDelegate

- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Done"
                                                    message: @"Finish playing the recording!"
                                                   delegate: nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void) audioRecorderLimitor {
    
    while (!exitLimitor)
    {
        //NSLog(@"exitLimitor");
        if (shouldCounterAudioTime)
        {
            audioTime ++;
            //NSLog(@"audioTime %d", audioTime);
            
            if (audioTime >= AUDIO_MAX_TIME)
            {
                [self btnAudioStopTapped:nil];
                
                shouldCounterAudioTime = NO;
            }
        }
        
        sleep(1);
    }
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
//- (void) addCustomPopupNoti:(NSString *) msg imagepath:(NSString *)imagepath category_image:(NSString *)category_image category_id:(NSString *)category_id subcat_name:(NSString *)subcat_name subcategory_id:(NSString *)subcategory_id dict:(NSMutableDictionary *)dict
//{
//    if (IsObNotNil(msg))
//    {
//        viewCustomNoti.center = self.view.center;
//        [notiImage GetNSetUIImage:imagepath DefaultImage:nil CustomScale:YES AI:notiAI];
//        notiLbl.text = msg;
//        KAppDelegate.datapass = dict;
//        KAppDelegate.catImage = category_image;
//        [self.view addSubview:viewCustomNoti];
//    }
//}
- (void) viewCustomPopUpBorder {
    //viewCustomPopUpInner.layer.masksToBounds = YES;
    //viewCustomPopUpInner.layer.cornerRadius = 25.0;
}

- (void) menuBackImagesAnimation {
    //[self performSelectorInBackground:@selector(menuBackImagesAnimationThread) withObject:nil];
}

- (void) menuBackImagesAnimationThread {
    imgBack.transform = CGAffineTransformMakeRotation(0 * M_PI/180);
    imgMenu.transform = CGAffineTransformMakeRotation(0 * M_PI/180);
    
    /*[UIView animateWithDuration:5.0 animations:^{
        imgBack.transform = CGAffineTransformMakeRotation(360 * M_PI/180);
        imgMenu.transform = CGAffineTransformMakeRotation(360 * M_PI/180);
    }];*/
    
    for (int i = 1; i <= 5; i++) {
        [self performSelectorInBackground:@selector(degree:) withObject:[NSNumber numberWithInt:i]];
        sleep(0.2);
    }
}

- (void) degree:(NSNumber *) num {
    NSLog(@"num %d", num.intValue);
    //imgAnimationTesting.transform = CGAffineTransformMakeRotation(72 * num.intValue * M_PI/180);
}

- (IBAction)setCart:(id)sender {
    if ([lblCartTotalCount.text intValue])
        [[ContainerWork ContainerWorkObject:self] setCart:sender];
}

- (void) setTotalCountToCart:(NSString *) totalCount {
    if (totalCount.intValue >= 1)
        lblCartTotalCount.hidden = NO;
    else
        lblCartTotalCount.hidden = YES;
    
    lblCartTotalCount.text = totalCount;
}

- (IBAction)setFiltersPopUp:(id)sender {
    [[ContainerWork ContainerWorkObject:self] setFiltersPopUp:sender];
    
    if (viewNewFilter.hidden)
        [viewNewFilter setHidden:NO];
    else
        [viewNewFilter setHidden:YES];
    
    boolFilterImg1 = !boolFilterImg1;
    
    if (!boolFilterImg1) {
        imgFilter1.image = [UIImage imageNamed:@"top1.png"];
    } else {
        imgFilter1.image = [UIImage imageNamed:@"top11.png"];
    }
}

- (IBAction)setFilters:(id)sender {
    [[ContainerWork ContainerWorkObject:self] setFilters:sender];
    /*boolFilterImg2 = !boolFilterImg2;
    
    if (boolFilterImg2) {
        imgFilter2.image = [UIImage imageNamed:@"top2.png"];
    } else {
        imgFilter2.image = [UIImage imageNamed:@"top22.png"];
    }*/
}

//- (void) filterWork {
//    if (KAppDelegate.mArrFilters.count > 0 || KAppDelegate.boolPrice || KAppDelegate.sortByFavRating != 0 || KAppDelegate.sortByUpORDown != 0) {
//        imgFilter2.image = imgFilterSelected;
//    } else {
//        imgFilter2.image = imgFilterSelectedUn;
//    }
//    
//   /* if (KAppDelegate.boolPrice) {
//        imgFilter2.image = imgFilterSelected;
//    } else {
//        imgFilter2.image = imgFilterSelectedUn;
//    }
//    
//    if (KAppDelegate.sortByFavRating != 0) {
//        imgFilter2.image = imgFilterSelected;
//    } else {
//        imgFilter2.image = imgFilterSelectedUn;
//    }*/
//}

- (IBAction)searchFire:(id)sender
{
   [[ContainerWork ContainerWorkObject:self] btnPushSearch:sender];
}
- (IBAction)applyFire:(id)sender
{
    [[ContainerWork ContainerWorkObject:self] setFilters:sender];
}

- (IBAction)clearFire:(id)sender
{
     [[ContainerWork ContainerWorkObject:self] btnClear:sender];
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
@end
