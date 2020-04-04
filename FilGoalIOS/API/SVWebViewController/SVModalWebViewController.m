//
//  SVModalWebViewController.m
//
//  Created by Oliver Letterer on 13.08.11.
//  Copyright 2011 Home. All rights reserved.
//
//  https://github.com/samvermette/SVWebViewController

#import "SVModalWebViewController.h"
#import "SVWebViewController.h"

@interface SVModalWebViewController ()

@property (nonatomic, strong) SVWebViewController *webViewController;

@end

@interface SVWebViewController (DoneButton)

- (void)doneButtonTapped:(id)sender;

@end


@implementation SVModalWebViewController

#pragma mark - Initialization


- (instancetype)initWithAddress:(NSString*)urlString {
    return [self initWithURL:[NSURL URLWithString:urlString]];
}

- (instancetype)initWithURL:(NSURL *)URL {
    return [self initWithURLRequest:[NSURLRequest requestWithURL:URL]];
}

- (instancetype)initWithURLRequest:(NSURLRequest *)request {

    self.webViewController = [[SVWebViewController alloc] initWithURLRequest:request];
    ((SVWebViewController*)self.webViewController).isFromMenu=NO;
    if (self = [super initWithRootViewController:self.webViewController]) {
        UIButton * doneButton= [UIButton buttonWithType:UIButtonTypeCustom];
        doneButton.frame=CGRectMake(0, 20, 40, 30);
        [doneButton.titleLabel setFont:[UIFont defaultFontOfSize:15]];
        [doneButton setTitle:@"رجوع" forState:UIControlStateNormal];
        [doneButton.titleLabel setTextColor:[UIColor whiteColor]];
        [doneButton addTarget:self.webViewController action:@selector(doneButtonTapped:) forControlEvents:UIControlEventTouchUpInside];

        /*UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self.webViewController action:@selector(doneButtonTapped:)];
        [doneButton setTitle:@"تم" forState:uicont
        [doneButton setTitleTextAttributes:
        [NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], NSForegroundColorAttributeName, nil]
                              forState:UIControlStateNormal];*/
        [doneButton setTintColor:[UIColor whiteColor]];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            self.webViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView: doneButton];
        else
            self.webViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView: doneButton];
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:NO];
    self.webViewController.title = self.title;
    self.navigationBar.tintColor = [UIColor whiteColor];
}
-(void)viewWillDisappear:(BOOL)animated
{
    
}

#pragma mark - Delegate

- (void)setWebViewDelegate:(id<UIWebViewDelegate>)webViewDelegate {
    self.webViewController.delegate = webViewDelegate;
}

- (id<UIWebViewDelegate>)webViewDelegate {
    return self.webViewController.delegate;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}
@end
