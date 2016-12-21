//
//  ContainerViewController.h
//  GigMail
//
//  Created by Ideal IT Techno on 20/04/13.
//  Copyright (c) 2013 Ideal It Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MessageUI/MessageUI.h> 
#import "ContainerMenuCell.h"

#import <AVFoundation/AVFoundation.h>
#import "FAImageView.h"
#import "UIImage+FontAwesome.h"
@interface ContainerViewController : CustomViewController <AVAudioRecorderDelegate, AVAudioPlayerDelegate, UITableViewDataSource, UITableViewDelegate, ContainerMenuCellDelegate,UIActionSheetDelegate, ContainerMenuCellDelegate, MFMailComposeViewControllerDelegate> {

   
    IBOutlet UIView *viewHeader;
    
    BOOL boolIsOpen;
    
    IBOutlet UIView *viewAnimation;
        
    IBOutlet UIButton *btnTabBtnUserProfile;
    IBOutlet UIButton *btnTabBtnNotification;
    IBOutlet UIButton *btnTabBtnMessages;
    IBOutlet UIButton *btnTabBtnLikes;
    IBOutlet UIButton *btnTabBtnExplore;
    IBOutlet UIButton *btnTabBtnCategories;
    IBOutlet UIButton *btnTabBtnVouchers;
    IBOutlet UIButton *btnTabBtnPartners;
    
    IBOutlet UIButton *btnCountNotification;
    IBOutlet UIButton *btnCountMessages;
    IBOutlet UIButton *btnCountVouchers;
    IBOutlet UIButton *btnCountPartners;
    
    IBOutlet UILabel *lblHeader;
    
    BOOL menuAnimation;
    BOOL flageIsMenuCame;
    
    UIImagePickerController * imgPkr;
    
    UIImageView * imgFromImagePicker;
    
    
        
    NSArray * arrPaymentType;

    // Set Image
    IBOutlet UIImageView * imgRecentP1;
    IBOutlet UIImageView * imgRecentP2;
    IBOutlet UIImageView * imgRecentP3;
    
    IBOutlet UIView *viewEditPicture;
    IBOutlet UIView *viewEditPictureInner;
    
    IBOutlet UIButton * btnRecentPicture1;
    IBOutlet UIButton * btnRecentPicture2;
    IBOutlet UIButton * btnRecentPicture3;
    
    /////////
    IBOutlet UIButton *btnMenuShadow;
    
    IBOutlet UIView *viewAskToPractitioner;
    IBOutlet UIView *viewAskToPractitionerInner;
    
    IBOutlet UIButton * btnAskToPractitionerEmail;
    IBOutlet UIButton * btnAskToPractitionerVoiceMemo;
    
    NSMutableDictionary * mDictPractitioner;
    
    ////////////////////////////////////////////////////////////
    
    NSURL *outputFileURL;
    
    IBOutlet UIView *viewAudioRecorder;
    
    IBOutlet UIView *viewCustomPopUp;
    IBOutlet UIView *viewCustomPopUpInner;
    IBOutlet UILabel *lblCustomPopUPMessage;
    
    IBOutlet FAImageView *imgBack;
    
    IBOutlet FAImageView *imgMenu;
    IBOutlet UIImageView *imgAnimationTesting;
    
    NSMutableArray * mArraBack_Back;
    NSMutableArray * mArrMenu_Menu;
    NSMutableArray * mArrBack_Menu;
    NSMutableArray * mArrMenu_Back;
    
    IBOutlet UIImageView *imgFilter1;
    IBOutlet UIImageView *imgFilter2;
    
    BOOL boolFilterImg1;
    BOOL boolFilterImg2;
    
    IBOutlet UIImageView *imgHader;
    
    
   
    IBOutlet UIView *viewCustomNoti;
    
    IBOutlet UIView *viewCustomInnerNoti;
    
    IBOutlet UIImageView *notiImage;
  
    IBOutlet UIActivityIndicatorView *notiAI;
    
    IBOutlet UILabel *notiLbl;
    
    
    IBOutlet UIView *headerView;
    IBOutlet UILabel *lblName;
    
    IBOutlet UIView *footerView;
    
    IBOutlet UIButton *btnSupport;
    
    IBOutlet UIButton *btnFaq;
    
    IBOutlet UIButton *btnSignout;
    
    UITableView *tblMenu;
    
     
}

@property (strong, nonatomic) IBOutlet UIButton *btnSave;
- (IBAction)saveFire:(id)sender;


//@property (strong , nonatomic) IBOutlet
- (IBAction)SignOutFire:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *lblHeaderTitle;

@property (strong, nonatomic) IBOutlet UILabel *lblHeader;

@property (strong, nonatomic) IBOutlet UIImageView *imgHeader;

@property (strong, nonatomic)  IBOutlet UIButton *applyBtn;
@property (strong, nonatomic)   IBOutlet UIButton *clearBtn;
- (IBAction)applyFire:(id)sender;

- (IBAction)clearFire:(id)sender;


@property (strong, nonatomic) IBOutlet UIView *navBar;

@property (strong, nonatomic) IBOutlet UIButton *searchBtn;
- (IBAction)searchFire:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *viewMenu;
- (IBAction)btnRemoveMenu:(id)sender;

- (IBAction)btnRemoveCustomPopUp:(id)sender;
- (IBAction)btnRemoveCustomPopUpNoti:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *viewNewFilter;
@property (weak, nonatomic) IBOutlet UIButton *btnAudioRecordPauseButton;
@property (weak, nonatomic) IBOutlet UIButton *btnAudioStopButton;
@property (weak, nonatomic) IBOutlet UIButton *btnAudioPlayButton;
@property (weak, nonatomic) IBOutlet UIButton *btnEditProfileSave;
@property (weak, nonatomic) IBOutlet UIButton *setFilters;
@property (weak, nonatomic) IBOutlet UIView *viewFilters;
@property (strong, nonatomic) IBOutlet UIButton *btnClear;
@property (strong, nonatomic) IBOutlet UIView *btnSubmitReview;

- (IBAction)btnRemoveAudioRecorder:(id)sender;
- (IBAction)btnAudioRecordPauseTapped:(id)sender;
- (IBAction)btnAudioStopTapped:(id)sender;
- (IBAction)btnAudioPlayTapped:(id)sender;
- (IBAction)btnEditProfileSave:(id)sender;
- (IBAction)btnClear:(id)sender;

- (IBAction)btnRemoveViewAskToPractitioner:(id)sender;
- (IBAction)btnAskToPractitionerEmail:(id)sender;
- (IBAction)btnAskToPractitionerVoiceMemo:(id)sender;
- (IBAction)btnSubmitReview:(id)sender;

- (IBAction)btnAddVisitor:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *viewTwoFilters;
// Set Image
- (IBAction)btnRemoveEditImageView:(id)sender;
- (IBAction)btnDeleteRecentPictures:(id)sender;
- (IBAction)btnPichUpPictureFromGallery:(id)sender;
- (IBAction)btnPichUpPictureFromCamera:(id)sender;
- (IBAction)btnRecentPicture1:(id)sender;
- (IBAction)btnRecentPicture2:(id)sender;
- (IBAction)btnRecentPicture3:(id)sender;

/////////

- (IBAction)btnEditProfile:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *viewEditProfile;
@property (strong, nonatomic) IBOutlet UIView *btnBack;
@property (strong, nonatomic) IBOutlet UIView *btnMenu;


@property int newVC;



@property (strong, nonatomic) IBOutlet UIView * viewContainer;

@property (strong, nonatomic) IBOutlet UIView *viewAddVisitor;

- (IBAction) btnBack:(id)sender;
- (IBAction) btnMenu:(id)sender;
- (IBAction) btnMenuVC:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *viewComposeMail;

- (IBAction)btnComposeMail:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *viewSendMailAttchment;

- (IBAction)btnAttchment:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *viewReply;
- (IBAction)btnReplyMail:(id)sender;
- (IBAction)btnDraft:(id)sender;

- (IBAction)setFilters:(id)sender;
- (IBAction)setFiltersPopUp:(id)sender;
- (IBAction)setCart:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lblCartTotalCount;
- (void) animateBackBtn:(int) which;

- (void) filterWork;
- (void) addCustomPopup:(NSString *) msg;
- (void) addCustomPopupNoti:(NSString *) msg imagepath:(NSString *)imagepath category_image:(NSString *)category_image category_id:(NSString *)category_id subcat_name:(NSString *)subcat_name subcategory_id:(NSString *)subcategory_id dict:(NSMutableDictionary *)dict;
@end













