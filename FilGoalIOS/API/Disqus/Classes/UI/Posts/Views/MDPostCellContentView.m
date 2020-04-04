//
//  MDPostCellContentView.m
//  Disqus
//
//  Created by Andrew Kopanev on 1/17/14.
//  Copyright (c) 2014 Moqod. All rights reserved.
//

#import "MDPostCellContentView.h"
#import "UIImageView+WebCache.h"
//#import "NSDate+TimeAgo.h"

const float MDPostCellContentViewVerticalMargin					= 5.0f;
const float MDPostCellContentViewHorizontalMargin				= 10.0f;

@interface MDPostCellContentView () {
	
}
@end

@implementation MDPostCellContentView

#pragma mark -

+ (CGFloat)heightForPost:(PostModel *)post width:(CGFloat)width {
	//CGFloat height = MDPostCellContentViewVerticalMargin * 2.0f + ceilf([self authorLabelFont].lineHeight) + ceilf([self timestampLabelFont].lineHeight);
    CGFloat height =113;
	//NSString *message = post[@"raw_message"];
    NSString *message = post.rawMessage;
	CGRect boundingRect = [message boundingRectWithSize:CGSizeMake(width - MDPostCellContentViewHorizontalMargin * 2.0f, FLT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[self messageLabelFont] forKey:NSFontAttributeName] context:nil];
	return height + ceilf(boundingRect.size.height);
}

+ (UIFont *)authorLabelFont {
	return [UIFont fontWithName:@"HelveticaNeue" size:14.0f];
}

+ (UIFont *)timestampLabelFont {
	return [UIFont fontWithName:@"HelveticaNeue" size:10.0f];
}

+ (UIFont *)messageLabelFont {
	return [UIFont fontWithName:@"HelveticaNeue" size:13.0f];
}

#pragma mark -

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
		self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
       
		//_authorLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		//_authorLabel.font = [MDPostCellContentView authorLabelFont];
		//[self addSubview:_authorLabel];
		
		//_timestampLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		//_timestampLabel.font = [MDPostCellContentView timestampLabelFont];
		//[self addSubview:_timestampLabel];

		//_messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		//_messageLabel.numberOfLines = 0;
		//_messageLabel.font = [MDPostCellContentView messageLabelFont];
		//_messageLabel.textColor = [UIColor darkGrayColor];
		//[self addSubview:_messageLabel];
    }
    return self;
}

#pragma mark -

- (void)layoutSubviews {
	[super layoutSubviews];
	/*_authorLabel.frame = CGRectMake(MDPostCellContentViewHorizontalMargin, MDPostCellContentViewVerticalMargin, self.bounds.size.width - MDPostCellContentViewHorizontalMargin * 2.0f, ceilf(_authorLabel.font.lineHeight));
	_timestampLabel.frame = CGRectMake(MDPostCellContentViewHorizontalMargin, CGRectGetMaxY(_authorLabel.frame), self.bounds.size.width - MDPostCellContentViewHorizontalMargin * 2.0f, ceilf(_timestampLabel.font.lineHeight));
	CGRect boundingRect = [_messageLabel.text boundingRectWithSize:CGSizeMake(self.bounds.size.width - MDPostCellContentViewHorizontalMargin * 2.0f, FLT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[MDPostCellContentView messageLabelFont] forKey:NSFontAttributeName] context:nil];
	_messageLabel.frame = CGRectMake(MDPostCellContentViewHorizontalMargin, CGRectGetMaxY(_timestampLabel.frame), self.bounds.size.width - MDPostCellContentViewHorizontalMargin * 2.0f, ceilf(boundingRect.size.height));*/
}

#pragma mark -

- (void)setPost:(PostModel *)post {
	/*NSDictionary *authorDictionary = postDictionary[@"author"];
    NSDictionary *avatar = authorDictionary[@"avatar"];
    NSDictionary *large = avatar[@"large"];
    NSString*userImage = large[@"permalink"];
	_authorLabel.text = authorDictionary[@"name"];
	_messageLabel.text = postDictionary[@"raw_message"];
    NSString *commentDateString = postDictionary[@"createdAt"];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    NSDate *Commentdate = [dateFormat dateFromString:commentDateString];
  */
    _authorLabel.text = post.authorName;
    _messageLabel.text = post.rawMessage;
    NSString *ago = [post.creationDate timeAgo];
    NSLog(@"Output is: \"%@\"", ago);
	_timestampLabel.text = ago;
    _likeNum.text = [post.likes stringValue];
    _disLikeNum.text = [post.dislikes stringValue];
    [_ind startAnimating];
    [_ind setHidden:NO];

    [_userAvatar sd_setImageWithURL:post.authorAvatarURL placeholderImage:[UIImage imageNamed:@"avatar.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [_ind stopAnimating];
        [_ind setHidden:YES];
    }];
   
 
}


#pragma mark -

- (void)dealloc {
	[_authorLabel release];
	[_timestampLabel release];
	[_messageLabel release];
	[super dealloc];
}

@end
