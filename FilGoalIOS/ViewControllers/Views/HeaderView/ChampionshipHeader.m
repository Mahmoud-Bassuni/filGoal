#import "ChampionshipHeader.h"
#import <GSKStretchyHeaderView/GSKGeometry.h>
#import "SponsorOverlayView.h"
#import "SpecialSponsorUrl.h"
#import "FilGoalIOS-Swift.h"

static const BOOL kNavBar = YES;

@interface ChampionshipHeader()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *navigationTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *expansionModeButton;
@end

@implementation ChampionshipHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    self.roundedView.layer.cornerRadius = self.roundedView.frame.size.width/2;
    self.roundedView.layer.borderWidth = 9.0;
    self.roundedView.clipsToBounds = YES;
    self.roundedView.layer.borderColor = [[UIColor colorWithWhite:0 alpha:0.1]CGColor];
    self.whiteView.layer.cornerRadius = self.whiteView.frame.size.width/2;
    self.whiteView.clipsToBounds = YES;
    //Transparent NavigationBar
    //[GetAppDelegate().getSelectedNavigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //[GetAppDelegate().getSelectedNavigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    //[GetAppDelegate().getSelectedNavigationController.navigationBar setShadowImage:[UIImage new]];
    //GetAppDelegate().getSelectedNavigationController.navigationBar.translucent = YES;
    [self.championshipNameLbl setText:self.champion.name];
    [self.championshipNameLbl setTextColor:[UIColor blackColor]];
    self.sponsorImgHeightConstraint.constant=181;
    [self.champImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%ld.png",CHAMP_IMAGES_BASE_URL,(long)self.champion.idField]] placeholderImage:[UIImage imageNamed:@"match_holder_ios"]
                                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)  {
                                    [self.champImgIndicator stopAnimating];
                                }];
   // [self setSponserBgImage];
    
    //Add Gesture
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sponsorChampionBgImgViewTapped)]];
}

-(void) sponsorChampionBgImgViewTapped {
    //Start
    NSString *urlWillOpen;     //Will set it inside that cases
    Sponsorship *sponsorShip = [Global getInstance].appInfo.sponsorship.firstObject;
    
    //Check special_sponsor - Check if the current championship has sponsor
    if (self.champs_id != nil) {
        NSArray *filteredArray = [sponsorShip.mainSponsor.specialSponsor.champsUrl filteredArrayUsingPredicate: [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            
            if ([(SpecialSponsorUrl*)evaluatedObject idField] == self.champs_id) {
                return YES; //Same Id, then this is the one
            }
            return NO;  //Not the same id, then ignore it
        }] ];
        
        if (filteredArray.firstObject != nil) {
            urlWillOpen = [(SpecialSponsorUrl*)filteredArray.firstObject url];
        }
    }
    //Check special_sponsor - Check if the current section has sponsor
    else if (self.section_id != nil) {
        NSArray *filteredArray = [sponsorShip.mainSponsor.specialSponsor.sectionUrl filteredArrayUsingPredicate: [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            
            if ([(SpecialSponsorUrl*)evaluatedObject idField] == self.section_id) {
                return YES; //Same Id, then this is the one
            }
            return NO;  //Not the same id, then ignore it
        }] ];
        
        if (filteredArray.firstObject != nil) {
            urlWillOpen = [(SpecialSponsorUrl*)filteredArray.firstObject url];
        }
    }
    //Check Category - Matches, Albums, News, Videos
    else if ( [[self.activeCategory lowercaseString] containsString: @"album"] ) {
        urlWillOpen = sponsorShip.mainSponsor.perContentTypeSponsor.albumsUrl;
        
    } else if ( [[self.activeCategory lowercaseString] containsString: @"match"] ) {
        urlWillOpen = sponsorShip.mainSponsor.perContentTypeSponsor.matchesUrl;
        
    } else if ( [[self.activeCategory lowercaseString] containsString: @"new"] ) {
        urlWillOpen = sponsorShip.mainSponsor.perContentTypeSponsor.newsUrl;
        
    } else if ( [[self.activeCategory lowercaseString] containsString: @"video"] ) {
        urlWillOpen = sponsorShip.mainSponsor.perContentTypeSponsor.videosUrl;
        
    } else if ( [[self.activeCategory lowercaseString] containsString: @"free"] ) {
        urlWillOpen = sponsorShip.mainSponsor.perContentTypeSponsor.freeOpinionsUrl;
        
    }
    //Check app_sponsor - The General Case and its the last
    if ( urlWillOpen == nil) {
        //Open App Global Sponsor
        urlWillOpen = sponsorShip.mainSponsor.appSponsor.appBarUrl;
        
    }
    //Open The URL
    if (urlWillOpen != nil) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: urlWillOpen]];
    }
}

-(void)setSponserBgImage{
    self.championshipNameLbl.textColor=[UIColor blackColor];
//    [GetAppDelegate().getSelectedNavigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    [GetAppDelegate().getSelectedNavigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
//    [GetAppDelegate().getSelectedNavigationController.navigationBar setShadowImage:[UIImage new]];
//    GetAppDelegate().getSelectedNavigationController.navigationBar.translucent = YES;
    
    if(_sectionId!=0&&[AppSponsors isSectionActiveUsingId:self.sectionId])
    {
        NSString * sponsorUrl=[AppSponsors getSpecialSectionImagePathUsingId: self.sectionId];
        self.section_id = self.sectionId;
        
        //[self.championBgImgView sd_setImageWithURL:[NSURL URLWithString:sponsorUrl]placeholderImage:[UIImage imageNamed:@"Default"]];
        __weak __typeof(self) weakSelf = self;
        [self.championBgImgView sd_setImageWithURL:[NSURL URLWithString:sponsorUrl] placeholderImage:[UIImage imageNamed:@"Default"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            
            [self.championBgImgView setImage: [image resizeImageScaledToWidthWithWidth: strongSelf.frame.size.width]];
        }];
    }
    else if(self.champion.idField!=0&&[AppSponsors isChampionActiveUsingId: self.champion.idField])
    {
        NSString * sponsorUrl=[AppSponsors getSpecialChampionImagePathUsingId: self.champion.idField];
        self.champs_id = self.champion.idField;
        
        //[self.championBgImgView sd_setImageWithURL:[NSURL URLWithString:sponsorUrl] placeholderImage:[UIImage imageNamed:@"Default"]];
        __weak __typeof(self) weakSelf = self;
        [self.championBgImgView sd_setImageWithURL:[NSURL URLWithString:sponsorUrl] placeholderImage:[UIImage imageNamed:@"Default"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            
            //Commented bec. the pic was pixlated and when u try to scroll any direction its quality improves and gets slightly down
            //[self.championBgImgView setImage: [image resizeImageScaledToWidthWithWidth: strongSelf.frame.size.width]];
        }];
    }
    else
    {
        NSString * sponsorUrl=[AppSponsors getChampionDefaultBackground];
        UIImage * image = [[SDImageCache sharedImageCache]imageFromDiskCacheForKey:sponsorUrl];
        if(image!=nil)
        {
            [self.championBgImgView setImage:image];
        }
        else
        {
            __weak __typeof(self) weakSelf = self;
            [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:sponsorUrl] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                __strong __typeof(weakSelf) strongSelf = weakSelf;
                
                if (image && finished) {
                    [[SDImageCache sharedImageCache] storeImage:image forKey:sponsorUrl toDisk:YES];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.championBgImgView setImage: [image resizeImageScaledToWidthWithWidth: strongSelf.frame.size.width]]; //image
                    });
                }
            }];
        }
    }
    
}
-(void)setBannerView
{
    GADAdSize customAdSize = GADAdSizeFromCGSize(CGSizeMake(300, 250));
    self.bannerView=[[DFPBannerView alloc]initWithAdSize:customAdSize origin:CGPointMake((Screenwidth-300)/2, 0)];
    self.bannerView.adUnitID = MeduimRectangle_AD_UNIT_ID;
    self.bannerView.delegate = self;
    self.bannerView.adSize=customAdSize;
    self.bannerView.rootViewController = self;
    DFPRequest *request = [DFPRequest request];
    if(self.champion.name!=nil)
        request.customTargeting=[[NSDictionary alloc]initWithObjects:@[@[@"Inner",@"Championship",[NSString stringWithFormat:@"بطولة %@",self.champion.name]],@[]] forKeys:@[@"Keyword",@"Position"]];
    [self.bannerView loadRequest:request];
}
-(void)adViewDidReceiveAd:(GADBannerView *)bannerView
{
    self.isExpand=YES;
    self.bannerView=bannerView;
    //self.observingScrollView=NO;
    //  [self observeScrollViewIfPossible];
}
-(void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error
{
    self.championBgImgView.hidden=NO;
    self.roundedView.hidden=NO;
    self.championshipNameLbl.hidden=NO;
    // self.observingScrollView=YES;
    self.isExpand=NO;
}
-(void)setNavigationBarBackgroundImage
{
    if([AppSponsors isAppNavigationbarSponsorActive])
    {
        UIImage * image = [[SDImageCache sharedImageCache]imageFromDiskCacheForKey:SponsorImagePathKey];
        if(image!=nil)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.championBgImgView setImage:image];
                self.sponsorImgHeightConstraint.constant=64;

            });
        }
        else
        {
            [self.championBgImgView sd_setImageWithURL:[NSURL URLWithString:[AppSponsors getAppNavigationbarSponsorImagePath]]placeholderImage:[UIImage imageNamed:@"Default"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                self.sponsorImgHeightConstraint.constant=64;
            }];
        }
        
        
    }
    
}

#pragma mark - NavigationBar Images

-(void)setNavigationBarBackgroundImage:(NSString*)mainSponsorUrl
{
    UIImage * image = [[SDImageCache sharedImageCache]imageFromDiskCacheForKey:mainSponsorUrl];
    if(image == nil)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:mainSponsorUrl] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                if (image && finished) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[SDImageCache sharedImageCache] storeImage:image forKey:mainSponsorUrl toDisk:YES];
                        [GetAppDelegate().getSelectedNavigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
                    });
                    
                }
            }];
            
        });
    }
    else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [GetAppDelegate().getSelectedNavigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        });

    }
}

@end
