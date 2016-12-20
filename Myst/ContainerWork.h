//
//  ContainerWork.h
//  Loyalty App
//
//  Created by Techlect on 11/09/14.
//  Copyright (c) 2014 Techlect. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "Email_Ob.h"

#define Container_State_Push 1
#define Container_State_Pop 2

#define Footer_1 1

#define MenuAnimateTime 0.3

@protocol ContainerWorkDelegate <NSObject>
- (void) logout;
- (void) AnimateMenuBack;
- (void) DismissContainer;
- (void) ContainerOpenWithVC:(int) whichVC;
- (void) btnChoosePicture:(UIImageView *) arrImgView;
- (IBAction) btnMenu:(id)sender;

- (IBAction)btnSaveData:(id)sender;
- (IBAction)btnSendMail:(id)sender;
- (void) setTotalCountToCart:(NSString *) totalCount;
- (void) openViewAskToPractitioner:(NSMutableDictionary *) dict;
- (void) addCustomPopup:(NSString *) msg;
- (void) addCustomPopupNoti:(NSString *) msg imagepath:(NSString *)imagepath category_image:(NSString *)category_image category_id:(NSString *)category_id subcat_name:(NSString *)subcat_name subcategory_id:(NSString *)subcategory_id dict:(NSMutableDictionary *)dict;
- (void) OpenPicture:(NSArray *)arrImgView title:(NSArray *)TitleArray index:(int)index;
- (void) showEmail;

/////////////////////// Add vehicle Page

-(void)ShowVehicleView;
-(void)ShowLocationView;

@end

@interface ContainerWork : NSObject
{
    NSMutableDictionary * mDictViewControllers;
    NSMutableDictionary * mDVCData;
    
    NSMutableArray * mArrMenu;
    
    NSMutableArray * VCStack;
    
    BOOL menuAnimation;
    
    UIView * viewGenric;
}

@property (strong, nonatomic) id <ContainerWorkDelegate> delegate;

+ (ContainerWork *) ContainerWorkObject:(id) vc;

- (void) ContainerOpenWithVC:(int) whichVC;

- (void) InitMainVCStack;

- (void) InitVCData;

- (NSMutableArray *) getMArrMenu;

- (void) ClickMenuTempButton:(int) whichTempbutton AndData:(id) dataInfo;

- (IBAction)btnSaveData:(id)sender;
- (IBAction)btnSendMail:(id)sender;
- (IBAction)btnDraft:(id)sender;
- (IBAction)btnPushSearch:(id)sender;
- (IBAction)setFilters:(id)sender;
- (IBAction)btnClear:(id)sender;
- (IBAction)btnSubmitReview:(id)sender;
//btnEditProile

- (void) PopViewController;
//- (void) AddView:(int)whichView Data:(id)dataInfo WhichFooter:(int)whichfooter State:(int) state;
- (void) Push:(int)vc Data:(id)dataInfo;
//- (void) ImageForVC:(int) whichVC;

-(void)hideNav:(int)value;

- (void) iGotImage:(UIImage *) img;

- (void) openViewAskToPractitioner:(NSMutableDictionary *) dict;

- (IBAction)setFiltersPopUp:(id)sender;
- (IBAction)setCart:(id)sender;

@property BOOL isScrolling;

@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;

- (void) logoutWork;
- (IBAction)btnPushSubCat:(id)sender;

@end















