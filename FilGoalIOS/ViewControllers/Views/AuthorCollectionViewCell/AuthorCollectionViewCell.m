//
//  AuthorCollectionViewCell.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 12/3/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "AuthorCollectionViewCell.h"

@implementation AuthorCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.articleTitleLbl setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.authorNameLbl setTransform:CGAffineTransformMakeScale(-1, 1)];

    self.imgView.layer.cornerRadius = self.imgView.frame.size.width/2;
    self.imgView.clipsToBounds = YES;
}

@end
