#import <GSKStretchyHeaderView/GSKStretchyHeaderView.h>

@interface ChampionshipHeader:UIView
//For Sponsor
@property (assign) NSInteger champs_id;
@property (assign) NSInteger section_id;
@property (strong, nonatomic) NSString *activeCategory;

@property (weak, nonatomic) IBOutlet UIImageView *champImgView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *champImgIndicator;
@property (weak, nonatomic) IBOutlet UIImageView *championBgImgView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *bgActivityIndicator;
@property (weak, nonatomic) IBOutlet UIView *whiteView;
@property (weak, nonatomic) IBOutlet UILabel *championshipNameLbl;
@property (strong,nonatomic) ChampionShipData * champion;
@property (weak, nonatomic) IBOutlet UIView *roundedView;
@property (assign, nonatomic) BOOL  isExpand;
@property (assign, nonatomic) NSInteger  sectionId;
@property(nonatomic,strong) DFPBannerView  *bannerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sponsorImgHeightConstraint;
-(void)setSponserBgImage;
@end
