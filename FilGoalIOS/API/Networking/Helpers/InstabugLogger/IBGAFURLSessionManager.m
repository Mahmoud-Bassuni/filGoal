//
//  IBGAFURLSessionManager.m
//  FilGoalIOS
//
//  Created by Nada Mohamed on 1/16/18.
//  Copyright © 2018 Sarmady. All rights reserved.
//

#import "IBGAFURLSessionManager.h"
#import <Instabug/Instabug.h>

@implementation IBGAFURLSessionManager

- (instancetype)initWithSessionConfiguration:(nullable NSURLSessionConfiguration *)configuration {
    [Instabug enableLoggingForURLSessionConfiguration:configuration];
    
    return [super initWithSessionConfiguration:configuration];
}

@end
