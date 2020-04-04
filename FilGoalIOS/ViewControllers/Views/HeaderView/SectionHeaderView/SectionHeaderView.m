#import "SectionHeaderView.h"
#import "SponsorOverlayView.h"
#import "SpecialSponsorUrl.h"
#import "FilGoalIOS-Swift.h"


@interface SectionHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *navigationTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *expansionModeButton;
@end

@implementation SectionHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];

    //Add Gesture
    self.userInteractionEnabled = YES;
    self.sectionImgView.userInteractionEnabled = YES;
    [self.sectionImgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sponsorChampionBgImgViewTapped)]];
}
-(void)setSectionBgImage{
    
    if(self.sectionId!=0&&[AppSponsors isSectionActiveUsingId:self.sectionId])
    {
        NSString * sponsorUrl=[AppSponsors getSpecialSectionImagePathUsingId:self.sectionId];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //[self.sectionImgView sd_setImageWithURL:[NSURL URLWithString:sponsorUrl]placeholderImage:[UIImage imageNamed:@"SectionDefault"]];
            __weak __typeof(self) weakSelf = self;
            [self.sectionImgView sd_setImageWithURL:[NSURL URLWithString:sponsorUrl] placeholderImage:[UIImage imageNamed:@"SectionDefault"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                __strong __typeof(weakSelf) strongSelf = weakSelf;
                
                [strongSelf.sectionImgView setImage: [image resizeImageScaledToWidthWithWidth: strongSelf.frame.size.width]];
            }];
        });
    }
    else
    {
        NSString * sponsorUrl=[AppSponsors getSectionDefaultBackground];
        UIImage * image = [[SDImageCache sharedImageCache]imageFromDiskCacheForKey:sponsorUrl];
        if(image!=nil)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.sectionImgView setImage :image];
            });
        }
        else
        {
            __weak __typeof(self) weakSelf = self;
            [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:sponsorUrl] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                __strong __typeof(weakSelf) strongSelf = weakSelf;

                UIImage *resizedImage = [image resizeImageScaledToWidthWithWidth: strongSelf.frame.size.width];
                if (image && finished) {
                    [[SDImageCache sharedImageCache] storeImage:resizedImage forKey:sponsorUrl toDisk:YES];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.sectionImgView setImage :resizedImage];
                    });
                }
            }];
        }
    }
    self.sectionNameLbl.text = self.sectionName;
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
    if (urlWillOpen == nil) {
        //Open App Global Sponsor
        urlWillOpen = sponsorShip.mainSponsor.appSponsor.appBarUrl;
    }
    
    //Open The URL
    if (urlWillOpen != nil) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: urlWillOpen]];
    }
}
@end
