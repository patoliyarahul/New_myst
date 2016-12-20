//
//  ContainerWork.m
//  Loyalty App
//
//  Created by Techlect on 11/09/14.
//  Copyright (c) 2014 Techlect. All rights reserved.
//

#import "ContainerWork.h"
#import "ContainerViewController.h"
//#import "EditProfile.h"
#import "UserInfo.h"
//#import "TodaysMenu.h"
//#import "FilterPage.h"
//#import "RateNReview.h"

//#import "GenericViewController.h"
////#import "SearchPage.h"
//#import "HomePage.h"

#define ContainerTypePopAll 0

static int CurrentNavigationStack;
static ContainerWork * obContainerWork;
static ContainerViewController * vcContainerVC;

/////////////    GenericViewController Class     /////////////
@interface GenericViewController : UIViewController
- (void) viewWillAppearClone;
- (void) viewWillAppearPop;
@property id delegate;
@property (strong, nonatomic) id dataInfo;
@end

@implementation GenericViewController
@synthesize delegate, dataInfo;
- (void) viewWillAppearClone {}
- (void) viewWillAppearPop {}
@end
////////////////////////////////////////////////////////

/////////////    ContainerObject Class     /////////////
@interface ContainerObject : NSObject
@property int whichView;
@property int extraIndex;
@property int whichfooter;
@property (strong, nonatomic) id dataInfo;
@property (strong, nonatomic) NSMutableArray * arrExtraData;
@end

@implementation ContainerObject
@synthesize whichView, dataInfo, arrExtraData, extraIndex, whichfooter;
@end

////////////////////////////////////////////////////////

@implementation ContainerWork

@synthesize delegate;

+ (ContainerWork *) ContainerWorkObject:(id) vc
{
    if (!obContainerWork)
        obContainerWork = [ContainerWork new];
    
    [obContainerWork getMArrMenu];
    
    vcContainerVC = vc;
    obContainerWork.delegate = vc;
    
    return obContainerWork;
}

- (NSMutableArray *) getMArrMenu
{
    [self InitMenu];
    
    return mArrMenu;
}

- (void) ContainerOpenWithVC:(int) whichVC
{
    [self ClickMenuTempButton:whichVC AndData:nil];
}

- (void) InitMainVCStack
{
    VCStack = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < NOOFTABS; i++)
        [VCStack addObject:[[NSMutableArray alloc]init]];

    [self InitVCData];
}

- (void) ClickMenuTempButton:(int) whichTempbutton AndData:(id) dataInfo {
    CurrentNavigationStack = whichTempbutton;
    menuAnimation = NO;
    
    if (menuAnimation)
        [self btnMenu:nil];
    else
        menuAnimation = YES;
    
    ContainerObject * obContainerObject = [[ContainerObject alloc] init];
    obContainerObject.whichView = CurrentNavigationStack;
    obContainerObject.dataInfo = dataInfo;
    
    NSMutableArray * arr = [VCStack objectAtIndex:CurrentNavigationStack];
    
    if (ContainerTypePopAll) {
        if (!arr)
            arr = [NSMutableArray new];
    } else {
        arr = [NSMutableArray new];
    }
    
    if ([arr count] == 0)
    {
        [arr addObject:obContainerObject];
        [VCStack insertObject:arr atIndex:CurrentNavigationStack];
        [self AddView:CurrentNavigationStack Data:obContainerObject.dataInfo WhichFooter:Footer_1 State:Container_State_Push];
    } else if ([arr count] > 0)
    {
        [self Pop:CurrentNavigationStack State:Container_State_Push Major:1];
    }
}

- (void) Pop:(int) vc State:(int) state Major:(int) major
{
    NSMutableArray * arr = [VCStack objectAtIndex:vc];
    ContainerObject * obContainerObject = [arr objectAtIndex:[arr count] - major];
    
    if ([arr count] >= major)
        [self AddView:obContainerObject.whichView Data:obContainerObject.dataInfo WhichFooter:Footer_1 State:state];
    
    [arr removeLastObject];
}

- (void) PopViewController
{
    NSMutableArray * arr = [VCStack objectAtIndex:CurrentNavigationStack];
    
    if ([arr count] > 1)
        [self Pop:CurrentNavigationStack State:Container_State_Pop Major:2];
    else
        [self DismissContainer];
}

- (void) Push:(int)vc Data:(id) dataInfo
{
    ContainerObject * obContainerObject = [[ContainerObject alloc] init];
    obContainerObject.whichView = vc;
    obContainerObject.dataInfo = dataInfo;
    
    NSMutableArray * arr = [VCStack objectAtIndex:CurrentNavigationStack];
    
    if (!arr)
        arr = [NSMutableArray new];
    
    if ([arr count] > 0) {
        ContainerObject * ob = [arr objectAtIndex:[arr count]-1];
        if (ob.whichView != vc)
            [arr addObject:obContainerObject];
    } else {
        [arr addObject:obContainerObject];
    }
    
    [self AddView:obContainerObject.whichView Data:obContainerObject.dataInfo WhichFooter:Footer_1 State:Container_State_Push];
}

- (void) btnChoosePicture:(UIImageView *) imgView
{
    [delegate btnChoosePicture:imgView];
}

- (void) showEmail {
    [delegate showEmail];
}
#define  Show Vehicle View

-(void)ShowVehicleView
{
    [delegate ShowVehicleView];
}
-(void)ShowLocationView
{
    [delegate ShowLocationView];
}
- (void) openViewAskToPractitioner:(NSMutableDictionary *) dict {
    [delegate openViewAskToPractitioner:dict];
}

- (void) DismissContainer
{
    [delegate DismissContainer];
}

- (void) AnimateMenuBack
{
    [delegate AnimateMenuBack];
}

- (IBAction)btnMenu:(id)sender {
    [delegate btnMenu:sender];
}

- (void) logout
{
    [delegate logout];
}

- (void) addCustomPopup:(NSString *) msg {
    [delegate addCustomPopup:msg];
}
- (void) addCustomPopupNoti:(NSString *) msg imagepath:(NSString *)imagepath category_image:(NSString *)category_image category_id:(NSString *)category_id subcat_name:(NSString *)subcat_name subcategory_id:(NSString *)subcategory_id dict:(NSMutableDictionary *)dict
{
    [delegate addCustomPopupNoti:msg imagepath:imagepath category_image:category_image category_id:category_id subcat_name:subcat_name subcategory_id:subcategory_id dict:dict];
}
- (NSMutableDictionary *) mD:(NSString *) vcName mBtn:(int) menubtn Ttl:(NSString *) title Img:(NSString *) img Xib:(NSString *) xib {
    if (title == nil)
        title = @"";
    
    if (img == nil)
        img = @"";
    
    if (xib == nil)
        xib = vcName;
    
    return [NSMutableDictionary dictionaryWithDictionary:@{@"vcname":vcName, @"menubtn":[self str:menubtn], @"headertitle":title, @"headerimage":img, @"vcxib":xib}];
}

- (NSString *) str:(int) intVC {
    return [NSString stringWithFormat:@"%d", intVC];
}

- (IBAction)btnSaveData:(id)sender {
    
}

- (IBAction)btnSendMail:(id)sender {
    
}

- (IBAction)btnDraft:(id)sender {
    
}

- (void) iGotImage:(UIImage *) img {
    
}

- (void) setTotalCountToCart:(NSString *) totalCount {
    [delegate setTotalCountToCart:totalCount];
}

//- (IBAction)btnPushSearch:(id)sender {
//    HomePage * vc = mDictViewControllers[@"HomePage"];
//    
//    if (vc) {
//        if ([vc isKindOfClass:[HomePage class]]) {
//            if ([vc respondsToSelector:@selector(btnPush:)])
//            {
//                [vc btnPush:nil];
//            }
//        }
//    }
//}
//
//- (IBAction)btnSubmitReview:(id)sender {
//    RateNReview * vc = mDictViewControllers[@"RateNReview"];
//    
//    if (vc) {
//        if ([vc isKindOfClass:[RateNReview class]]) {
//            if ([vc respondsToSelector:@selector(btnSubmitReview:)]) {
//                [vc btnSubmitReview:nil];
//            }
//        }
//    }
//}
//
//- (IBAction)btnClear:(id)sender {
//    FilterPage * vc = mDictViewControllers[@"FilterPage"];
//    
// 
//    if (vc) {
//        if ([vc isKindOfClass:[FilterPage class]]) {
//            if ([vc respondsToSelector:@selector(btnClear:)]) {
//                [vc btnClear:nil];
//            }
//        }
//    }
//}
//
//- (IBAction)setFilters:(id)sender {
//    FilterPage * vc = mDictViewControllers[@"FilterPage"];
//    
//    if (vc) {
//        if ([vc isKindOfClass:[FilterPage class]]) {
//            if ([vc respondsToSelector:@selector(setFilters:)]) {
//                [vc setFilters:nil];
//            }
//        }
//    }
//}
//
//- (IBAction)btnPushSubCat:(id)sender {
//    HomePage * vc = mDictViewControllers[@"HomePage"];
//    
//    if (vc) {
//        if ([vc isKindOfClass:[HomePage class]]) {
//            if ([vc respondsToSelector:@selector(btnPushSubCat:)])
//            {
//                [vc btnPushSubCat:nil];
//            }
//        }
//    }
//}
//
//- (IBAction)setCart:(id)sender {
//    TodaysMenu * vc = mDictViewControllers[@"TodaysMenu"];
//    
//    if (vc) {
//        if ([vc isKindOfClass:[TodaysMenu class]]) {
//            if ([vc respondsToSelector:@selector(setCart:)]) {
//                [vc setCart:nil];
//            }
//        }
//    }
//}
//
//- (void) logoutWork {
//    TodaysMenu * vc = mDictViewControllers[@"TodaysMenu"];
//    
//    if (vc) {
//        if ([vc isKindOfClass:[TodaysMenu class]]) {
//            if ([vc respondsToSelector:@selector(logoutWork)]) {
//                [vc logoutWork];
//            }
//        }
//    }
//}

- (void) AddView1:(int)whichView Data:(id) dataInfo WhichFooter:(int)whichfooter State:(int) state
{
    @try {
        dispatch_async(dispatch_get_main_queue(), ^{
            [viewGenric removeFromSuperview];
            
            [vcContainerVC.btnMenu setHidden:YES];
            [vcContainerVC.btnBack setHidden:YES];
            
            NSDictionary * dict = mDVCData[[self str:whichView]];
            
            vcContainerVC.lblHeader.text = dict[@"headertitle"];
            
            NSString * menubtn = dict[@"menubtn"];
            
            if (menubtn.intValue)
                [vcContainerVC.btnMenu setHidden:NO];
            else
                [vcContainerVC.btnBack setHidden:NO];
                        
            NSString * vcName = dict[@"vcname"];
            
            //
            
            if ([@"RateNReview" isEqualToString:vcName])
                [vcContainerVC.btnSubmitReview setHidden:NO];
            else
                [vcContainerVC.btnSubmitReview setHidden:YES];
            
            if ([@"Filters" isEqualToString:vcName])
                [vcContainerVC.btnClear setHidden:NO];
            else
                [vcContainerVC.btnClear setHidden:YES];
            
            if ([@"TodaysMenu" isEqualToString:vcName] || [@"MealDetail" isEqualToString:vcName]) {
                [vcContainerVC.viewFilters setHidden:NO];
                
                if ([@"MealDetail" isEqualToString:vcName]) {
                    [vcContainerVC.viewTwoFilters setHidden:YES];
                } else {
                    [vcContainerVC.viewTwoFilters setHidden:NO];
                }
            } else
                [vcContainerVC.viewFilters setHidden:YES];
            
            if ([@"EditProfile" isEqualToString:vcName])
                [vcContainerVC.btnEditProfileSave setHidden:NO];
            else
                [vcContainerVC.btnEditProfileSave setHidden:YES];
            
            if ([@"Profile" isEqualToString:vcName])
                [vcContainerVC.viewEditProfile setHidden:NO];
            else
                [vcContainerVC.viewEditProfile setHidden:YES];
            
            if ([@"VisitorBadge" isEqualToString:vcName])
                [vcContainerVC.viewAddVisitor setHidden:NO];
            else
                [vcContainerVC.viewAddVisitor setHidden:YES];
            
            if ([@"MessageBox" isEqualToString:vcName])
                [vcContainerVC.viewComposeMail setHidden:NO];
            else
                [vcContainerVC.viewComposeMail setHidden:YES];
            
            if ([@"ComposeMail" isEqualToString:vcName])
                [vcContainerVC.viewSendMailAttchment setHidden:NO];
            else
                [vcContainerVC.viewSendMailAttchment setHidden:YES];
            
            if ([@"ComposeMailForward" isEqualToString:vcName])
                [vcContainerVC.viewSendMailAttchment setHidden:NO];
            else
                [vcContainerVC.viewSendMailAttchment setHidden:YES];
            
            if ([@"MessageDetail" isEqualToString:vcName])
                [vcContainerVC.viewReply setHidden:NO];
            else
                [vcContainerVC.viewReply setHidden:YES];
            
            if ([obNet isObject:vcName TypeOf:Type_Str]) {
                if (mDictViewControllers == nil)
                    mDictViewControllers = [NSMutableDictionary new];
                
                GenericViewController * vc = mDictViewControllers[vcName];
                
                if (vc == nil) {
                    vc = [[NSClassFromString(vcName) alloc] initWithNibName:vcName bundle:nil];
                    
                    if ([vc respondsToSelector:@selector(delegate)])
                        vc.delegate = self;
                    
                    mDictViewControllers[vcName] = vc;
                }
                
                if ([vc respondsToSelector:@selector(dataInfo)]) {
                    vc.dataInfo = dataInfo;
                    
                    if ([obNet isObject:dataInfo TypeOf:Type_Dct]) {
                        if ([dataInfo objectForKey:@"data"])
                            vc.dataInfo = [dataInfo objectForKey:@"data"];
                        if ([dataInfo objectForKey:@"headerTitle"])
                            vcContainerVC.lblHeader.text = [dataInfo objectForKey:@"headerTitle"];
                    }
                }
                
                //vc.view.frame = vcContainerVC.viewContainer.bounds;
                //[vcContainerVC.viewContainer addSubview:vc.view];
                
                if (menubtn.intValue == 2) {
                    vc.view.frame = vcContainerVC.view.bounds;
                    [vcContainerVC.view addSubview:vc.view];
                } else {
                    vc.view.frame = vcContainerVC.viewContainer.bounds;
                    [vcContainerVC.viewContainer addSubview:vc.view];
                }
                
                BOOL boolPushFirstTime = NO;
                
                if (viewGenric != vc.view)
                    boolPushFirstTime = YES;
                
                viewGenric = vc.view;
                
                if (state == Container_State_Push && boolPushFirstTime) {
                    if ([vc respondsToSelector:@selector(viewWillAppearClone)])
                        [vc viewWillAppearClone];
                }
                
                if (state == Container_State_Pop) {
                    if ([vc respondsToSelector:@selector(viewWillAppearPop)])
                        [vc viewWillAppearPop];
                }
            }
        });
        
        [delegate AnimateMenuBack];
    } @catch (NSException *exception) { }
}
-(void)hideNav:(int)value
{
    if (value == 0)
    {
        //show
        [vcContainerVC.navBar setHidden:NO];
        vcContainerVC.viewContainer.frame = CGRectMake(0, 55, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-55);

    }
    else
    {
        [vcContainerVC.navBar setHidden:true];
        vcContainerVC.viewContainer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        //hide
        
    }
   }
- (void) AddView:(int)whichView Data:(id) dataInfo WhichFooter:(int)whichfooter State:(int) state
{
    @try {
        dispatch_async(dispatch_get_main_queue(), ^{
            [viewGenric removeFromSuperview];
            
            int menu_old = vcContainerVC.btnMenu.hidden;
            int back_old = vcContainerVC.btnBack.hidden;
            
            [vcContainerVC.btnMenu setHidden:YES];
            [vcContainerVC.btnBack setHidden:YES];
            
            NSDictionary * dict = mDVCData[[self str:whichView]];
            
            vcContainerVC.lblHeader.text = dict[@"headertitle"];
            
            NSString * menubtn = dict[@"menubtn"];
            
            if (menubtn.intValue)
            {
                if (menu_old == 0)
                {
                    [vcContainerVC animateBackBtn:4];
                }
                else if (back_old == 0)
                {
                    [vcContainerVC animateBackBtn:2];
                }
                
                [vcContainerVC.btnMenu setHidden:NO];
            }
            else
            {
                if (menu_old == 0)
                {
                    [vcContainerVC animateBackBtn:1];
                }
                else if (back_old == 0)
                {
                    [vcContainerVC animateBackBtn:3];
                }
                
                [vcContainerVC.btnBack setHidden:NO];
            }
            
            /*
             if (which == 1)
             myImages = mArrMenu_Back;
             else if (which == 2)
             myImages = mArrBack_Menu;
             else if (which == 3)
             myImages = mArraBack_Back;
             else if (which == 4)
             myImages = mArrMenu_Menu;
             */
            
            
            NSString * vcName = dict[@"vcname"];
    
            vcContainerVC.lblHeader.hidden = YES;
            vcContainerVC.lblHeaderTitle.hidden = NO;
            vcContainerVC.imgHeader.hidden = YES;
            
            vcContainerVC.navBar.backgroundColor = [obNet colorWithHexString:@colorPrimary];
            
            if ([@"TutorialPage" isEqualToString:vcName])
            {
                vcContainerVC.lblHeader.hidden = YES;
                vcContainerVC.lblHeaderTitle.hidden = NO;
                vcContainerVC.imgHeader.hidden = NO;
                
                [vcContainerVC.btnBack setHidden:YES];
                [vcContainerVC.btnMenu setHidden:YES];
                vcContainerVC.viewContainer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
                [vcContainerVC.viewMenu setHidden:YES];
                
            }
           else if ([@"RegisterPage" isEqualToString:vcName])
            {
                vcContainerVC.lblHeader.hidden = YES;
                
                vcContainerVC.lblHeaderTitle.hidden = NO;
                vcContainerVC.imgHeader.hidden = NO;
                
                vcContainerVC.navBar.backgroundColor = [obNet colorWithHexString:@colorPrimaryDark];
                vcContainerVC.viewContainer.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-100);
            }
           else if ([@"TermsPage" isEqualToString:vcName])
           {
               vcContainerVC.lblHeader.hidden = NO;
               vcContainerVC.lblHeaderTitle.hidden = YES;
               vcContainerVC.imgHeader.hidden = YES;
               vcContainerVC.navBar.backgroundColor = [obNet colorWithHexString:@colorPrimaryDark];
            vcContainerVC.viewContainer.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-100);
           }
           else if ([@"LoginPage" isEqualToString:vcName])
           {
               vcContainerVC.lblHeader.hidden = YES;
               vcContainerVC.lblHeaderTitle.hidden = NO;
               vcContainerVC.imgHeader.hidden = NO;
                vcContainerVC.navBar.backgroundColor = [obNet colorWithHexString:@colorPrimaryDark];
               vcContainerVC.viewContainer.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-100);
           
           }
           else if ([@"ForgetPwdPage" isEqualToString:vcName])
           {
               vcContainerVC.lblHeader.hidden = YES;
               vcContainerVC.lblHeaderTitle.hidden = NO;
               vcContainerVC.imgHeader.hidden = NO;
              vcContainerVC.navBar.backgroundColor = [obNet colorWithHexString:@colorPrimaryDark];
               vcContainerVC.viewContainer.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-100);
               
           }
           else if ([@"HomePage" isEqualToString:vcName])
           {
              // vcContainerVC.tblMenu.hidden = NO;
               
               vcContainerVC.lblHeader.hidden = YES;
               vcContainerVC.lblHeaderTitle.hidden = YES;
               vcContainerVC.imgHeader.hidden = NO;
               
               vcContainerVC.viewContainer.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-100);
               
           }
           else if ([@"AddvehiclePage" isEqualToString:vcName])
           {
               vcContainerVC.lblHeader.hidden = NO;
               vcContainerVC.lblHeaderTitle.hidden = YES;
               vcContainerVC.imgHeader.hidden = YES;
               
               vcContainerVC.viewContainer.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-100);
               
           }
           else if ([@"SelectPackagePage" isEqualToString:vcName])
           {
              
               vcContainerVC.lblHeader.hidden = NO;
               vcContainerVC.lblHeaderTitle.hidden = YES;
               vcContainerVC.imgHeader.hidden = YES;
               
               vcContainerVC.viewContainer.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-100);
               
           }
           else if ([@"AddLocationPage" isEqualToString:vcName])
           {
               
               vcContainerVC.lblHeader.hidden = NO;
               vcContainerVC.lblHeaderTitle.hidden = YES;
               vcContainerVC.imgHeader.hidden = YES;
               
               vcContainerVC.viewContainer.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-100);
               
           }
         else
          {

                 vcContainerVC.viewContainer.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-100);
            }
        
            if ([obNet isObject:vcName TypeOf:Type_Str])
            {
                if (mDictViewControllers == nil)
                    mDictViewControllers = [NSMutableDictionary new];
                
                GenericViewController * vc = mDictViewControllers[vcName];
                
                if (vc == nil) {
                    vc = [[NSClassFromString(vcName) alloc] initWithNibName:vcName bundle:nil];
                    
                    if ([vc respondsToSelector:@selector(delegate)])
                        vc.delegate = self;
                    
                    mDictViewControllers[vcName] = vc;
                }
                
                if ([vc respondsToSelector:@selector(dataInfo)])
                {
                    vc.dataInfo = dataInfo;
                    
                    if ([obNet isObject:dataInfo TypeOf:Type_Dct])
                    {
                        if ([dataInfo objectForKey:@"data"])
                            vc.dataInfo = [dataInfo objectForKey:@"data"];
                        if ([dataInfo objectForKey:@"headerTitle"])
                            vcContainerVC.lblHeader.text = [dataInfo objectForKey:@"headerTitle"];
                    }
                }
                
                [vcContainerVC.viewNewFilter setHidden:YES];
                
                {
                    if (menubtn.intValue == 2) {
                        vc.view.frame = vcContainerVC.view.bounds;
                        [vcContainerVC.view addSubview:vc.view];
                    } else {
                        vc.view.frame = vcContainerVC.viewContainer.bounds;
                        [vcContainerVC.viewContainer addSubview:vc.view];
                    }
                }
                
                BOOL boolPushFirstTime = NO;
                
                if (viewGenric != vc.view)
                    boolPushFirstTime = YES;
                
                //[viewGenric removeFromSuperview];
                viewGenric = vc.view;
                
                if (state == Container_State_Push && boolPushFirstTime)
                {
                    if ([vc respondsToSelector:@selector(viewWillAppearClone)])
                        [vc viewWillAppearClone];
                }
                
                if (state == Container_State_Pop)
                {
                    if ([vc respondsToSelector:@selector(viewWillAppearPop)])
                        [vc viewWillAppearPop];
                }
            }
            
            if ([vcContainerVC respondsToSelector:@selector(filterWork)])
                [vcContainerVC filterWork];
        });
        
        [delegate AnimateMenuBack];
    }
    @catch (NSException *exception)
    {
    }
}


- (void) InitMenu
{
    mArrMenu = [NSMutableArray new];

    
    {
        NSMutableDictionary * mDict = [NSMutableDictionary new];
        mDict[@"VC"] = [NSString stringWithFormat:@"%d", VC_HomePage];
        mDict[@"IMAGE"] = @"history - FontAwesome.png";
        mDict[@"TITLE"] = @"Order History";
        [mArrMenu addObject:mDict];
    }
    
    {
        NSMutableDictionary * mDict = [NSMutableDictionary new];
        mDict[@"VC"] = [NSString stringWithFormat:@"%d", VC_HomePage];
        mDict[@"IMAGE"] = @"car - FontAwesome.png";
        mDict[@"TITLE"] = @"Manage Vehicles";
        [mArrMenu addObject:mDict];
    }
    
    {
        NSMutableDictionary * mDict = [NSMutableDictionary new];
        mDict[@"VC"] = [NSString stringWithFormat:@"%d", VC_HomePage];
        mDict[@"IMAGE"] = @"map-marker - FontAwesome.png";
        mDict[@"TITLE"] = @"Manage Addresses";
        [mArrMenu addObject:mDict];
    }
    
    {
        NSMutableDictionary * mDict = [NSMutableDictionary new];
        mDict[@"VC"] = [NSString stringWithFormat:@"%d", VC_HomePage];
        mDict[@"IMAGE"] = @"setting.png";
        mDict[@"TITLE"] = @"Settings";
        [mArrMenu addObject:mDict];
    }


}
- (void) OpenPicture:(NSArray *)arrImgView title:(NSArray *)TitleArray index:(int)index
{
    [delegate OpenPicture:arrImgView title:TitleArray index:index];
}
- (void) InitVCData
{
    mDVCData = [NSMutableDictionary new];

     mDVCData[[self str:VC_TutorialPage]]           = [self mD:@"TutorialPage"              mBtn:0 Ttl:@""                 Img:nil Xib:nil];
    mDVCData[[self str:VC_RegisterPage]]             = [self mD:@"RegisterPage"                mBtn:0 Ttl:@"Car Wash Concierge®"                    Img:nil Xib:nil];
    mDVCData[[self str:VC_LoginPage]]        = [self mD:@"LoginPage"           mBtn:0 Ttl:@"Car Wash Concierge®"            Img:nil Xib:nil];
    mDVCData[[self str:VC_ForgetPwdPage]]         = [self mD:@"ForgetPwdPage"            mBtn:0 Ttl:@"Car Wash Concierge®"                Img:nil Xib:nil];
    mDVCData[[self str:VC_HomePage]]         = [self mD:@"HomePage"            mBtn:1 Ttl:@""            Img:nil Xib:nil];
    mDVCData[[self str:VC_AddvehiclePage]]       = [self mD:@"AddvehiclePage"          mBtn:0 Ttl:@"Request a Wash"             Img:nil Xib:nil];
    
    
    
    mDVCData[[self str:VC_VehiclePage]]        = [self mD:@"VehiclePage"           mBtn:0 Ttl:@""  Img:nil Xib:nil];
    mDVCData[[self str:VC_SelectPackage]]             = [self mD:@"SelectPackagePage"                mBtn:0 Ttl:@"Select a Package"                Img:nil Xib:nil];
    mDVCData[[self str:VC_LocationPage]]  = [self mD:@"LocationPage"     mBtn:0 Ttl:@""     Img:nil Xib:nil];
    mDVCData[[self str:VC_AddLocationPage]]         = [self mD:@"AddLocationPage"            mBtn:0 Ttl:@"Request a Wash"             Img:nil Xib:nil];
    mDVCData[[self str:VC_Salepage]]           = [self mD:@"SalePage"              mBtn:0 Ttl:@"SALE YOUR PRODUCT"                  Img:nil Xib:nil];
    mDVCData[[self str:VC_Aboutus]]           = [self mD:@"AboutusPage"              mBtn:0 Ttl:@"ABOUT US"                  Img:nil Xib:nil];
    mDVCData[[self str:VC_TermsPage]]             = [self mD:@"TermsPage"                mBtn:0 Ttl:@"TERMS & CONDITION"              Img:nil Xib:nil];
//
    mDVCData[[self str:VC_Rapaport]]             = [self mD:@"RapaportPage"           mBtn:0 Ttl:@"RAPPA PORT PRICE LIST"              Img:nil Xib:nil];
    mDVCData[[self str:VC_GetContact]]                   = [self mD:@"ContactusPage"                 mBtn:0 Ttl:@"CONTACT US"                     Img:nil Xib:nil];
    mDVCData[[self str:VC_Notification]]                   = [self mD:@"NotificationPage"           mBtn:0 Ttl:@"NOTIFICATION"                     Img:nil Xib:nil];
//    mDVCData[[self str:VC_MealDetail]]             = [self mD:@"MealDetail"           mBtn:0 Ttl:@""                         Img:nil Xib:nil];
//    mDVCData[[self str:VC_Registration]]           = [self mD:@"Registration"         mBtn:0 Ttl:@"REGISTRATION"             Img:nil Xib:nil];
//    mDVCData[[self str:VC_ForgotPassword]]         = [self mD:@"ForgotPassword"       mBtn:0 Ttl:@"FORGOT PASSWORD"          Img:nil Xib:nil];
//    mDVCData[[self str:VC_Filters]]                = [self mD:@"Filters"              mBtn:0 Ttl:@"FILTERS"                  Img:nil Xib:nil];
//    mDVCData[[self str:VC_ChefDetail]]             = [self mD:@"ChefDetail"           mBtn:0 Ttl:@"ABOUT CHEF"               Img:nil Xib:nil];
//    //mDVCData[[self str:VC_Payment]]                = [self mD:@"Payment"              mBtn:1 Ttl:@"CONFIRM"                  Img:nil Xib:nil];
//    mDVCData[[self str:VC_Payment]]                = [self mD:@"AddNewCard"           mBtn:0 Ttl:@"CONFIRM"                  Img:nil Xib:nil];
//
//    mDVCData[[self str:VC_RateNReview]]            = [self mD:@"RateNReview"          mBtn:0 Ttl:@"RATE & REVIEW"            Img:nil Xib:nil];
//    mDVCData[[self str:VC_RegistrationSocial]]     = [self mD:@"RegistrationSocial"   mBtn:0 Ttl:@"REGISTRATION"             Img:nil Xib:nil];
//    mDVCData[[self str:VC_OrderStatus]]            = [self mD:@"OrderStatus"          mBtn:0 Ttl:@"ORDER TRACK"              Img:nil Xib:nil];
//    mDVCData[[self str:VC_MyAddress]]              = [self mD:@"MyAddress"            mBtn:0 Ttl:@"MY ADDRESSES"             Img:nil Xib:nil];
//    mDVCData[[self str:VC_AddAddressBill]]         = [self mD:@"AddAddress"           mBtn:0 Ttl:@"ADD BILLING DETAILS"              Img:nil Xib:nil];

    if (IS_IPHONE_4) {
        
    } else if (IS_IPHONE_5) {
        
    } else if (IS_IPHONE_6) {
        
    } else if (IS_IPHONE_6P) {
        
    }
}

@end













