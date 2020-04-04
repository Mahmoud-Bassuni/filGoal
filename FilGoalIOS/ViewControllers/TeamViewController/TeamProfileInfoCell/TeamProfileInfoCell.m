//
//  TeamProfileInfoCell.m
//  FilGoalIOS
//
//  Created by Nada Mohamed on 9/11/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "TeamProfileInfoCell.h"

@implementation TeamProfileInfoCell
{
    NSString * websiteUrl;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setRoundCornersForImages];
    UIView *overlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screenwidth, _teamImgView.frame.size.height)];
    [overlay setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
    [self.teamImgView addSubview:overlay];

}


-(void)setRoundCornersForImages
{
    self.coachImgView.layer.cornerRadius = self.coachImgView.frame.size.width/2;
    //self.coachImgView.layer.borderWidth = 5.0;
    self.coachImgView.clipsToBounds = YES;
    // self.coachImgView.layer.borderColor = [[UIColor colorWithRed:0.27 green:0.27 blue:0.28 alpha:1.0]CGColor];
    self.teamLogoView.layer.cornerRadius = self.teamLogoView.frame.size.width/2;
    self.teamLogoView.layer.borderWidth = 9.0;
    self.teamLogoView.clipsToBounds = YES;
    self.teamLogoView.layer.borderColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]CGColor];
    self.followBtn.layer.cornerRadius = 12;
    self.followBtn.clipsToBounds = YES;
    
    self.whiteView.layer.cornerRadius = self.whiteView.frame.size.width/2;
    self.whiteView.clipsToBounds = YES;

}

-(void)initWithCell:(TeamProfile*)teamProfile
{
    UIColor *color = [UIColor whiteColor];
    UIFont * font = [UIFont fontWithName:@"DINNextLTW23Regular" size:14.0];
    NSDictionary *attrs = @{ NSForegroundColorAttributeName : color, NSFontAttributeName:font };
    UIColor * grayColor = [UIColor colorWithRed:0.66 green:0.66 blue:0.66 alpha:1.0];
    NSDictionary * grayAttrs = @{ NSForegroundColorAttributeName : grayColor , NSFontAttributeName:font };
    if(teamProfile.data.count>0)
    {
        Data * item = teamProfile.data[0];
        // Website Url
        self.teamNameLbl.text = item.name;
       if(item.website !=nil)
        websiteUrl = [[NSString alloc]initWithString:item.website];
        // set Team Image
        [self.teamImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%li.png",TEAM_BASE_URL,(long)item.idField]] placeholderImage:[UIImage imageNamed:@"Team-Image-Placeholder"]
                                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)  {
                                       [self.teamImgActivityIndicator stopAnimating];
                                       
                                   }];
        
        [self.teamLogoImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%li.png",TEAM_IMAGES_BASE_URL,(long)item.idField]] placeholderImage:[UIImage imageNamed:@"Team-Image-Placeholder"]
                                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)  {
                                       [self.teamLogoActivityIndicator stopAnimating];
                                       
                                   }];
        NSMutableAttributedString * attributeStr = [[NSMutableAttributedString alloc]init];
        NSAttributedString * countryNameStr = [[NSAttributedString alloc] initWithString:item.countryName attributes:attrs];
        NSAttributedString * countryNameLbl = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"الدولة:" ] attributes:grayAttrs];
        [attributeStr appendAttributedString:countryNameLbl];
        [attributeStr appendAttributedString:[[NSAttributedString alloc]initWithString:@"  "]];
        [attributeStr appendAttributedString:countryNameStr];
        //self.playgroundNameLbl.attributedText = attributeStr;
        self.playgroundNameLbl.text = item.countryName ;
        //foundation Label
        
        attributeStr = [[NSMutableAttributedString alloc]init];
        NSAttributedString * foundationStr = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%li",(long)item.founded] attributes:attrs];
        NSAttributedString * foundationLbl = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"سنة التأسيس:" ] attributes:grayAttrs];
        [attributeStr appendAttributedString:foundationLbl];
        [attributeStr appendAttributedString:[[NSAttributedString alloc]initWithString:@"  "]];
        [attributeStr appendAttributedString:foundationStr];
        //  self.foundationDateLbl.attributedText = attributeStr;
        self.foundationDateLbl.text = [NSString stringWithFormat:@"%li",(long)item.founded];
        
        
        // Coach Details
        
        NSArray * careerData = [[NSArray alloc]initWithArray: item.careerData];
        if(careerData.count>0)
        {
            CareerData * person = [careerData objectAtIndex:0];
            
            // Coach Image
            [self.coachImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%li.png",PERSON_IMAGES_BASE_URL,(long)person.personId]] placeholderImage:[UIImage imageNamed:@"Coach-Image-Placeholder"]
                                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)  {
                                            [self.coachImgActivityIndicator stopAnimating];
                                            UIImageView * imageView = [[UIImageView alloc]initWithImage:image];
                                            imageView.frame = self.coachImgView.frame;
                                            
                                        }];
            // Coach Name
            
            attributeStr = [[NSMutableAttributedString alloc]init];
            NSAttributedString * coachNameStr = [[NSAttributedString alloc] initWithString:person.personName attributes:attrs];
            NSAttributedString * coachNameLbl = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"المدرب:" ] attributes:grayAttrs];
            [attributeStr appendAttributedString:coachNameLbl];
            [attributeStr appendAttributedString:[[NSAttributedString alloc]initWithString:@"  "]];
            [attributeStr appendAttributedString:coachNameStr];
            // self.coachNameLbl.attributedText = attributeStr;
            self.coachNameLbl.text = person.personName;
            
            
        }
        
    }

}
- (IBAction)teamWebsitePressed:(id)sender {
    AppDelegate * appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    UINavigationController * navigationController = appDelegate.getSelectedNavigationController;
    GlobalViewController * viewController = [[GlobalViewController alloc]initWithUrl:websiteUrl];
    [navigationController pushViewController:viewController animated:YES];
}
- (IBAction)followBtnPressed:(id)sender
{
    
}
@end
