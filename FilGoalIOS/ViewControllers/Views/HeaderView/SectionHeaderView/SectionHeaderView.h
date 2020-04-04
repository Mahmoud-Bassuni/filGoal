#import <GSKStretchyHeaderView/GSKStretchyHeaderView.h>

@interface SectionHeaderView : UIView<GADBannerViewDelegate>
//For Sponsor
@property (assign) NSInteger champs_id;
@property (assign) NSInteger section_id;
@property (strong, nonatomic) NSString *activeCategory;

@property (weak, nonatomic) IBOutlet UIImageView *sectionImgView;
@property (weak, nonatomic) IBOutlet UILabel *sectionNameLbl;
@property (strong, nonatomic) NSString *sectionName;
@property (assign, nonatomic) NSInteger sectionId;
@property (assign, nonatomic) BOOL  isExpand;
@property(nonatomic,strong) DFPBannerView  *bannerView;
-(void)setSectionBgImage;
@end
