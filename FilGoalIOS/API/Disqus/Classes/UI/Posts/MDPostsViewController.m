//
//  MDPostsViewController.m
//  Disqus
//
//  Created by Andrew Kopanev on 1/16/14.
//  Copyright (c) 2014 Moqod. All rights reserved.
//

#import "MDPostsViewController.h"
#import "MDPostCellContentView.h"
#import "MDNewPostViewController.h"
#import "PostModel.h"
const int MDPostsViewControllerAuthorizationSheetViewTag			= 1;

@interface MDPostsViewController () <UIActionSheetDelegate>

{
    UIActivityIndicatorView			*_indicatorView;
}
@property (nonatomic, retain) NSString			*threadId;
@property (nonatomic, retain) NSMutableArray			*postsList;
@property (nonatomic, copy) NSString			*forumShortname;
@property (nonatomic, retain) NSArray			*threadsList;
@property (nonatomic, copy) NSString			*thread_ident;

@end

@implementation MDPostsViewController

- (id)initWithForumShortname:(NSString *)forumShortname  thread_ident:(NSString *)thread_ident {
    if (self = [super init]) {
        self.forumShortname = forumShortname;
        self.thread_ident = thread_ident;
    }
    return self;
}
/*- (id)initWithThreadId:(NSString *)threadId title:(NSString *)title {
	if (self = [super init]) {
		self.threadId = threadId;
		self.title = title;
	}
	return self;
}*/

- (void)requestPosts {
	[self showActivityIndicatorView];
	self.postsList = nil;
	//[self.tableView reloadData];
	
	[GetAppDelegate().disqusComponent requestAPI:@"threads/listPosts" params:@{@"thread" : self.threadId} handler:^(NSDictionary *response, NSError *error) {
		[self hideActivityIndicatorView];		
		if (nil == error) {
			//self.postsList = [response objectForKey:@"response"];
          NSMutableArray  *tempPostsList=[[NSMutableArray alloc]init];
            self.postsList=[[NSMutableArray alloc]init];
       [[response objectForKey:@"response"]enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            PostModel *post = [[PostModel alloc] initWithJSONDictionary:obj];
            [tempPostsList  addObject:post];
            
        }];
       /* [tempPostsList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                PostModel *postObj = (PostModel*)obj;
            if (postObj.isParent) {
                [tempPostsList enumerateObjectsUsingBlock:^(id obj2, NSUInteger idx, BOOL *stop) {
                    PostModel *childPostObj = (PostModel*)obj2;
                    if (postObj.identifier==childPostObj.parentIdenfier) {
                        [postObj.childPosts addObject:childPostObj.identifier];
                    }
                }];
                [self.postsList  addObject:postObj];
            }
            
            }];*/
            [tempPostsList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                PostModel *PostObj = (PostModel*)obj;
                if (PostObj.isChild&&!PostObj.isParent) {
                    [tempPostsList enumerateObjectsUsingBlock:^(id obj2, NSUInteger idx, BOOL *stop) {
                        PostModel *ParentPostObj = (PostModel*)obj2;
                        if (PostObj.parentIdenfier==ParentPostObj.identifier) {
                            ParentPostObj.isParent=true;
                            [ParentPostObj.childPosts addObject:PostObj];
                            [tempPostsList removeObject:PostObj];
                                                    }
                    }];
                    
                }
                
                            }];

			//[self.tableView reloadData];
		} else {
			// TODO: show an alert view
			NSLog(@"%s failed to load posts, error == %@", __PRETTY_FUNCTION__, error);
			[[[[UIAlertView alloc] initWithTitle:nil message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease] show];
		}
	}];
}

- (void)requestThreadsList {
    [self showActivityIndicatorView];
    
    assert( self.forumShortname != nil );
    //News_167628
    [GetAppDelegate().disqusComponent requestAPI:@"threads/list" params:@{@"forum" : self.forumShortname ,@"thread:ident":self.thread_ident} handler:^(NSDictionary *response, NSError *error) {
        [self hideActivityIndicatorView];
        if (nil == error) {
            self.threadsList = [response objectForKey:@"response"];
            NSDictionary *threadDictionary = [self.threadsList objectAtIndex:0];
            
            //self.threadId = [threadDictionary objectForKey:@"id"];
            
          //  self.title = [threadDictionary objectForKey:@"title"];
           /* self.disqusView.disqusShortname = @"sarmady-filgoal";
            self.disqusView.originalArticleUrl = @"http://www.filgoal.com/Arabic/news.aspx?NewsID=167237";
            self.disqusView.originalArticleTitle = @"FilGoal | اراء |انقذوا استوديو القمة";
            self.disqusView.originalArticleIdentifier = @"News_167237";*/
            self.disqusView.disqusShortname = [threadDictionary objectForKey:@"forum"];
            self.disqusView.originalArticleUrl = [threadDictionary objectForKey:@"link"];
            self.disqusView.originalArticleTitle = [threadDictionary objectForKey:@"clean_title"];
            self.disqusView.originalArticleIdentifier = [[threadDictionary objectForKey:@"identifiers"]objectAtIndex:0];;
            self.disqusView.originalArticleTitle=[self.disqusView.originalArticleTitle stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            self.disqusView.originalArticleTitle=[self.disqusView.originalArticleTitle stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
            [self.disqusView loadComments];
            
           // [self requestPosts];
          
                    } else {
            // TODO: show an alert view
            NSLog(@"%s failed to load threads, error == %@", __PRETTY_FUNCTION__, error);
            [[[[UIAlertView alloc] initWithTitle:nil message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease] show];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

- (void)viewDidLoad {
    self.screenName=[NSString stringWithFormat:@"iOS-Comments-Screen with disqus_identifier =%@",self.thread_ident ];
    [super viewDidLoad];
    //[self requestThreadsList];
	//self.tableView.tableFooterView = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
	//self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewPostAction)] autorelease];
     //self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissViewController)] autorelease];
    
}
- (void)dismissViewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
    
    UIButton *refresh = [UIButton buttonWithType:UIButtonTypeCustom];
    [refresh setFrame:CGRectMake(0, 0, 20, 20)];
    [refresh setBackgroundImage:[UIImage imageNamed:@"Refresh11.png"] forState:UIControlStateNormal];
    [refresh addTarget:self action:@selector(reloadWebView:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc]initWithCustomView:refresh];
    self.navigationItem.rightBarButtonItem = refreshButton;
	[self requestThreadsList];
}

#pragma mark - actions

- (void)addNewPostAction {
	if (YES == GetAppDelegate().disqusComponent.isAuthorized) {
		MDNewPostViewController *newpostViewController = [[[MDNewPostViewController alloc] initWithThreadId:self.threadId] autorelease];
		[self.navigationController pushViewController:newpostViewController animated:YES];
	} else {
		UIActionSheet *actionSheet = [[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Disqus", @"Facebook", @"Twitter", @"Google", nil] autorelease];
		actionSheet.tag = MDPostsViewControllerAuthorizationSheetViewTag;
		[actionSheet showInView:self.view];
	}
}

- (void)authorizeVia:(MDDisqusComponentAuthorizationType)authType {
	[GetAppDelegate().disqusComponent authorizeVia:authType modallyOnViewController:self completionHandler:^(NSError *error) {
		if (nil == error) {
			[self addNewPostAction];
		} else {
			[[[[UIAlertView alloc] initWithTitle:nil message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease] show];
		}
	}];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.postsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	//const int cellContentViewTag = 1;
    MDPostCellContentView *cell = [tableView dequeueReusableCellWithIdentifier:@"MDPostCellContentView"];
    if (nil == cell) {
           cell =  [[[NSBundle mainBundle]loadNibNamed:@"MDPostCellContentView" owner:self options:nil]lastObject];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	//	MDPostCellContentView *contentView = [[[MDPostCellContentView alloc] initWithFrame:cell.contentView.bounds] autorelease];
		//contentView.tag = cellContentViewTag;
		//[cell.contentView addSubview:contentView];
	}
	
	//MDPostCellContentView *contentView = (MDPostCellContentView *)[cell.contentView viewWithTag:cellContentViewTag];
    
	[cell setPost:[self.postsList objectAtIndex:indexPath.row]];
	[cell.contentView setNeedsDisplay];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSDictionary *threadDictionary = [self.postsList objectAtIndex:indexPath.row];
	return [MDPostCellContentView heightForPost:threadDictionary width:tableView.bounds.size.width];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
	if (MDPostsViewControllerAuthorizationSheetViewTag == actionSheet.tag) {
		if (buttonIndex != actionSheet.cancelButtonIndex) {
			[self authorizeVia:buttonIndex];
		}
	}
}

#pragma mark -

- (void)dealloc {
	[_postsList release];
	[_threadId release];
    [_threadsList release];
    [_forumShortname release];
    [_indicatorView release];
	[super dealloc];
}
#pragma mark -

- (void)showActivityIndicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    [_indicatorView startAnimating];
   // [self.tableView addSubview:_indicatorView];
}

- (void)hideActivityIndicatorView {
    [_indicatorView stopAnimating];
    [_indicatorView removeFromSuperview];
}

#pragma mark -

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    //_indicatorView.center = CGPointMake(self.tableView.bounds.size.width * 0.5f, self.tableView.bounds.size.height * 0.1f);
}

#pragma mark -

-(IBAction)back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)dismissViewPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    // [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (IBAction)backPressed:(id)sender {
    //  request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    //[self.webView loadRequest:request];    
    [self.disqusView goBack];
}

- (IBAction)nextPressed:(id)sender {
    //  [self.webView loadRequest:request];
    
    [self.disqusView   goForward];
    
}
- (IBAction)reloadWebView:(id)sender {
    
    [self.disqusView reload];
}
@end
