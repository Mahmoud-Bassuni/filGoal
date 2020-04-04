//
//  XLButtonBarPagerTabStripViewController.m
//  XLPagerTabStrip ( https://github.com/xmartlabs/XLPagerTabStrip )
//
//  Copyright (c) 2015 Xmartlabs ( http://xmartlabs.com )
//
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "XLButtonBarViewCell.h"
#import "XLButtonBarPagerTabStripViewController.h"
#import "TabsViewController.h"
#import "FeaturedSectionTabsViewController.h"
@interface XLButtonBarPagerTabStripViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic) IBOutlet XLButtonBarView * buttonBarView;
@property (nonatomic) BOOL shouldUpdateButtonBarView;
@property (nonatomic) NSArray *cachedCellWidths;
@property (nonatomic) BOOL isViewAppearing;
@property (nonatomic) BOOL isViewRotating;

@end

@implementation XLButtonBarPagerTabStripViewController

#pragma mark - Initialisation

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.shouldUpdateButtonBarView = YES;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.shouldUpdateButtonBarView = YES;
    }
    return self;
}


#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    super.isFromChampSection=self.isFromChampSection;
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(moveToSelectedIndex:) name:@"TabIndex" object:nil];
    if (!self.buttonBarView.superview){
        // If buttonBarView wasn't configured in a XIB or storyboard then it won't have
        // been added to the view so we need to do it programmatically.
        [self.view addSubview:self.buttonBarView];
    }
    
    if (!self.buttonBarView.delegate){
        self.buttonBarView.delegate = self;
    }
    if (!self.buttonBarView.dataSource){
        self.buttonBarView.dataSource = self;
    }
    self.buttonBarView.labelFont = [UIFont fontWithName:@"DINNextLTW23Regular" size:16];
    self.buttonBarView.leftRightMargin = 8;
    self.buttonBarView.scrollsToTop = NO;
    UICollectionViewFlowLayout *flowLayout = (id)self.buttonBarView.collectionViewLayout;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.buttonBarView.showsHorizontalScrollIndicator = NO;
  
    if(_isFromMatchDetails)
    {
        [self moveTabToIndexBasedOnMatchStatus:self.matchStatus];
    }
    else if (self.isFromMatchesList)
    {
        [self moveToViewControllerAtIndex:4 animated:NO];

    }
    else if(_isFromEventsTabs)
    {
        [self moveToViewControllerAtIndex:0 animated:NO];
    }
 

}

-(void)moveToSelectedIndex:(NSNotification*)note
{
    [[NSNotificationCenter defaultCenter]removeObserver:@"TabIndex"];
    //[self moveToViewControllerAtIndex:[[note object]integerValue] animated:YES];
    if(self.childViewControllers.count>3)
    [self moveToViewControllerAtIndex:[[note object]integerValue] animated:NO];
    else
    [self moveToViewControllerAtIndex:[[note object]integerValue]-1 animated:NO];

    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.buttonBarView layoutIfNeeded];
    self.isViewAppearing = YES;

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.buttonBarView layoutIfNeeded];
    self.shouldUpdateButtonBarView = YES;
//        if(_isFromEventsTabs)
//        {
//        [self moveToViewControllerAtIndex:2 animated:NO];
//        }
 

}
-(void)moveTabToIndexBasedOnMatchStatus:(NSInteger)matchStatus
{
    switch (matchStatus) {
        case KMatchNotStarted:
            [self moveToViewControllerAtIndex:2];
            break;
        case KMatchSoon:
            [self moveToViewControllerAtIndex:1];
            break;
        case KMatchFirstHalf:
            [self moveToViewControllerAtIndex:1];
            break;
        case KMatchBreak:
            [self moveToViewControllerAtIndex:1];
            break;
        case KMatchSecondHalf:
            [self moveToViewControllerAtIndex:1];
            break;
        case KMatchFirstExtraHalf:
            [self moveToViewControllerAtIndex:1];
            break;
        case KMatchSecondExtraHalf:
            [self moveToViewControllerAtIndex:1];
            break;
        case KPlenties:
            [self moveToViewControllerAtIndex:1];
            break;
        case KMatchEnd:
            [self moveToViewControllerAtIndex:0];
            break;
        case KMatchStopped:
            [self moveToViewControllerAtIndex:1];
            break;
        case KMatchPostponed:
            [self moveToViewControllerAtIndex:2];
            break;
        case KMatchCancelled:
            [self moveToViewControllerAtIndex:2];
            break;
            
        default:
            [self moveToViewControllerAtIndex:0];
            
            break;
    }
    
}
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    if (self.isViewAppearing || self.isViewRotating) {
        self.cachedCellWidths = nil; // Clear/invalidate our cache of cell widths
        UICollectionViewFlowLayout *flowLayout = (id)self.buttonBarView.collectionViewLayout;
        [flowLayout invalidateLayout];
        
        // Ensure the buttonBarView.frame is sized correctly after rotation on iOS 7 devices
        [self.buttonBarView layoutIfNeeded];
        
        // When the view first appears or is rotated we also need to ensure that the barButtonView's
        // selectedBar is resized and its contentOffset/scroll is set correctly (the selected
        // tab/cell may end up either skewed or off screen after a rotation otherwise)
        [self.buttonBarView moveToIndex:self.currentIndex animated:NO swipeDirection:XLPagerTabStripDirectionLeft pagerScroll:XLPagerScrollOnlyIfOutOfScreen];
    }
}


#pragma mark - View Rotation

// Called on iOS 8+ only
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    self.isViewRotating = YES;
    __typeof__(self) __weak weakSelf = self;
    [coordinator animateAlongsideTransition:nil
                                 completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
                                     weakSelf.isViewRotating = NO;
                                 }];
}

// Called on iOS 7 only
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    self.isViewRotating = YES;
}

#pragma mark - Public methods

-(void)reloadPagerTabStripView
{
    self.cachedCellWidths = nil; // Clear/invalidate our cache of cell widths
    
    [super reloadPagerTabStripView];
    if ([self isViewLoaded]){
        [self.buttonBarView reloadData];
        [self.buttonBarView moveToIndex:self.currentIndex animated:NO swipeDirection:XLPagerTabStripDirectionLeft pagerScroll:XLPagerScrollYES];
    }
}


#pragma mark - Properties

-(XLButtonBarView *)buttonBarView
{
    if (_buttonBarView) return _buttonBarView;
    
    // If _buttonBarView is nil then it wasn't configured in a XIB or storyboard so
    // this class is being used programmatically. We need to initialise the buttonBarView,
    // setup some sensible defaults (which can of course always be re-set in the sub-class),
    // and set an appropriate frame. The buttonBarView gets added to to the view in viewDidLoad:
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 35, 0, 35);
    _buttonBarView = [[XLButtonBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44.0f) collectionViewLayout:flowLayout];
    _buttonBarView.backgroundColor = [UIColor orangeColor];
    _buttonBarView.selectedBar.backgroundColor = [UIColor blackColor];
    _buttonBarView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    // If a XIB or storyboard hasn't been used we also need to register the cell reuseIdentifier
    // as well otherwise we'll get a crash when the code attempts to dequeue any cell's
    NSBundle * bundle = [NSBundle bundleForClass:[XLButtonBarView class]];
    NSURL * url = [bundle URLForResource:@"XLPagerTabStrip" withExtension:@"bundle"];
    if (url){
        bundle =  [NSBundle bundleWithURL:url];
    }
    [_buttonBarView registerNib:[UINib nibWithNibName:@"ButtonCell" bundle:bundle] forCellWithReuseIdentifier:@"Cell"];
    // If a XIB or storyboard hasn't been used then the containView frame that was setup in the
    // XLPagerTabStripViewController won't have accounted for the buttonBarView. So we need to adjust
    // its y position (and also its height) so that childVC's don't appear under the buttonBarView.
    CGRect newContainerViewFrame = self.containerView.frame;
    newContainerViewFrame.origin.y = 44.0f;
    newContainerViewFrame.size.height = self.containerView.frame.size.height - (44.0f - self.containerView.frame.origin.y);
    self.containerView.frame = newContainerViewFrame;
    
    return _buttonBarView;
}

- (NSArray *)cachedCellWidths
{
    if (!_cachedCellWidths)
    {
        // First calculate the minimum width required by each cell
        
        UICollectionViewFlowLayout *flowLayout = (id)self.buttonBarView.collectionViewLayout;
        NSUInteger numberOfCells = self.pagerTabStripChildViewControllers.count;
        
        NSMutableArray *minimumCellWidths = [[NSMutableArray alloc] init];
        
        CGFloat collectionViewContentWidth = 0;
        
        for (UIViewController<XLPagerTabStripChildItem> *childController in self.pagerTabStripChildViewControllers)
        {
            UILabel *label = [[UILabel alloc] init];
            label.translatesAutoresizingMaskIntoConstraints = NO;
            label.font = self.buttonBarView.labelFont;
            label.text = [childController titleForPagerTabStripViewController:self];
            CGSize labelSize = [label intrinsicContentSize];
            
            CGFloat minimumCellWidth = labelSize.width + (self.buttonBarView.leftRightMargin * 2);
            NSNumber *minimumCellWidthValue = [NSNumber numberWithFloat:minimumCellWidth];
            [minimumCellWidths addObject:minimumCellWidthValue];
            
            collectionViewContentWidth += minimumCellWidth;
        }
        
        // To get an acurate collectionViewContentWidth account for the spacing between cells
        CGFloat cellSpacingTotal = ((numberOfCells-1) * flowLayout.minimumInteritemSpacing);
        collectionViewContentWidth += cellSpacingTotal;
        
        CGFloat collectionViewAvailableVisibleWidth = self.buttonBarView.frame.size.width - flowLayout.sectionInset.left - flowLayout.sectionInset.right;
        
        // Do we need to stetch any of the cell widths to fill the screen width?
        if (!self.buttonBarView.shouldCellsFillAvailableWidth || collectionViewAvailableVisibleWidth < collectionViewContentWidth)
        {
            // The collection view's content width is larger that the visible width available so it needs to scroll
            // OR shouldCellsFillAvailableWidth == NO...
            // No need to stretch any of the cells, we can just use the minimumCellWidths for the cell widths.
            _cachedCellWidths = minimumCellWidths;
        }
        else
        {
            // The collection view's content width is smaller that the visible width available so it won't ever scroll
            // AND shouldCellsFillAvailableWidth == YES so we want to stretch the cells to fill the width.
            // We now need to calculate how much to stretch each tab...
            
            // In an ideal world the cell's would all have an equal width, however the cell labels vary in length
            // so some of the longer labelled cells might not need to stetch where as the shorter labelled cells do.
            // In order to determine what needs to stretch and what doesn't we have to recurse through suggestedStetchedCellWidth
            // values (the value decreases with each recursive call) until we find a value that works.
            // The first value to try is the largest (for the case where all the cell widths are equal)
            CGFloat stetchedCellWidthIfAllEqual = (collectionViewAvailableVisibleWidth - cellSpacingTotal) / numberOfCells;
            
            CGFloat generalMiniumCellWidth = [self calculateStretchedCellWidths:minimumCellWidths suggestedStetchedCellWidth:stetchedCellWidthIfAllEqual previousNumberOfLargeCells:0];
            
            NSMutableArray *stetchedCellWidths = [[NSMutableArray alloc] init];
            
            for (NSNumber *minimumCellWidthValue in minimumCellWidths)
            {
                CGFloat minimumCellWidth = minimumCellWidthValue.floatValue;
                CGFloat cellWidth = (minimumCellWidth > generalMiniumCellWidth) ? minimumCellWidth : generalMiniumCellWidth;
                NSNumber *cellWidthValue = [NSNumber numberWithFloat:cellWidth];
                [stetchedCellWidths addObject:cellWidthValue];
            }
            
            _cachedCellWidths = stetchedCellWidths;
        }
    }
    return _cachedCellWidths;
}

- (CGFloat)calculateStretchedCellWidths:(NSArray *)minimumCellWidths suggestedStetchedCellWidth:(CGFloat)suggestedStetchedCellWidth previousNumberOfLargeCells:(NSUInteger)previousNumberOfLargeCells
{
    // Recursively attempt to calculate the stetched cell width
    
    NSUInteger numberOfLargeCells = 0;
    CGFloat totalWidthOfLargeCells = 0;
    
    for (NSNumber *minimumCellWidthValue in minimumCellWidths)
    {
        CGFloat minimumCellWidth = minimumCellWidthValue.floatValue;
        if (minimumCellWidth > suggestedStetchedCellWidth) {
            totalWidthOfLargeCells += minimumCellWidth;
            numberOfLargeCells++;
        }
    }
    
    // Is the suggested width any good?
    if (numberOfLargeCells > previousNumberOfLargeCells)
    {
        // The suggestedStetchedCellWidth is no good :-( ... calculate a new suggested width
        UICollectionViewFlowLayout *flowLayout = (id)self.buttonBarView.collectionViewLayout;
        CGFloat collectionViewAvailableVisibleWidth = self.buttonBarView.frame.size.width - flowLayout.sectionInset.left - flowLayout.sectionInset.right;
        NSUInteger numberOfCells = minimumCellWidths.count;
        CGFloat cellSpacingTotal = ((numberOfCells-1) * flowLayout.minimumInteritemSpacing);
        
        NSUInteger numberOfSmallCells = numberOfCells - numberOfLargeCells;
        CGFloat newSuggestedStetchedCellWidth =  (collectionViewAvailableVisibleWidth - totalWidthOfLargeCells - cellSpacingTotal) / numberOfSmallCells;
        
        return [self calculateStretchedCellWidths:minimumCellWidths suggestedStetchedCellWidth:newSuggestedStetchedCellWidth previousNumberOfLargeCells:numberOfLargeCells];
    }
    
    // The suggestion is good
    return suggestedStetchedCellWidth;
}


#pragma mark - XLPagerTabStripViewControllerDelegate

-(void)pagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
          updateIndicatorFromIndex:(NSInteger)fromIndex
                           toIndex:(NSInteger)toIndex
{
    if (self.shouldUpdateButtonBarView){
        XLPagerTabStripDirection direction = XLPagerTabStripDirectionLeft;
        if (toIndex < fromIndex){
            direction = XLPagerTabStripDirectionRight;
        }
        [self.buttonBarView moveToIndex:toIndex animated:YES swipeDirection:direction pagerScroll:XLPagerScrollYES];
        if (self.changeCurrentIndexBlock) {
            XLButtonBarViewCell *oldCell = (XLButtonBarViewCell*)[self.buttonBarView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex != fromIndex ? fromIndex : toIndex inSection:0]];
            XLButtonBarViewCell *newCell = (XLButtonBarViewCell*)[self.buttonBarView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex inSection:0]];
            self.changeCurrentIndexBlock(oldCell, newCell, YES);
            
        }
    }
}

-(void)pagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
          updateIndicatorFromIndex:(NSInteger)fromIndex
                           toIndex:(NSInteger)toIndex
            withProgressPercentage:(CGFloat)progressPercentage
                   indexWasChanged:(BOOL)indexWasChanged
{
    if (self.shouldUpdateButtonBarView){
        [self.buttonBarView moveFromIndex:fromIndex
                                  toIndex:toIndex
                   withProgressPercentage:progressPercentage pagerScroll:XLPagerScrollYES];
        
        if (self.changeCurrentIndexProgressiveBlock) {
            XLButtonBarViewCell *oldCell = (XLButtonBarViewCell*)[self.buttonBarView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex != fromIndex ? fromIndex : toIndex inSection:0]];
            XLButtonBarViewCell *newCell = (XLButtonBarViewCell*)[self.buttonBarView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex inSection:0]];
            self.changeCurrentIndexProgressiveBlock(oldCell, newCell, progressPercentage, indexWasChanged, YES);
        }
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.cachedCellWidths.count > indexPath.row)
    {
        //NSNumber *cellWidthValue = self.cachedCellWidths[indexPath.row];
        if (self.pagerTabStripChildViewControllers.count<3) {
            return CGSizeMake(Screenwidth/self.pagerTabStripChildViewControllers.count, collectionView.frame.size.height);
            
        }
        else
        {
         return CGSizeMake(Screenwidth/3, collectionView.frame.size.height);
        }
    }
    return CGSizeZero;
}

#pragma mark - UICollectionViewDelegate


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //There's nothing to do if we select the current selected tab
	if (indexPath.item == self.currentIndex)
		return;
	
    [self.buttonBarView moveToIndex:indexPath.item animated:YES swipeDirection:XLPagerTabStripDirectionLeft pagerScroll:XLPagerScrollYES];
    self.shouldUpdateButtonBarView = NO;
    
    XLButtonBarViewCell *oldCell = (XLButtonBarViewCell*)[self.buttonBarView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex inSection:0]];
    XLButtonBarViewCell *newCell = (XLButtonBarViewCell*)[self.buttonBarView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:indexPath.item inSection:0]];
    if (self.isProgressiveIndicator) {
        if (self.changeCurrentIndexProgressiveBlock) {
            self.changeCurrentIndexProgressiveBlock(oldCell, newCell, 1, YES, YES);
        }
    }
    else{
        if (self.changeCurrentIndexBlock) {
            self.changeCurrentIndexBlock(oldCell, newCell, YES);
        }
    }
    if(self.isFromMatchEventsTabs)
    {
        newCell.label.backgroundColor=[UIColor darkGrayColor];
        newCell.label.textColor=[UIColor lightGrayColor];
        oldCell.label.backgroundColor=[UIColor whiteColor];
        oldCell.label.textColor=[UIColor lightGrayColor];
    }
    else   if(self.isFromTeamProfile)
    {
        newCell.label.backgroundColor=[UIColor whiteColor];
        newCell.label.textColor=[UIColor blackColor];
        oldCell.label.backgroundColor=[UIColor whiteColor];
        oldCell.label.textColor=[UIColor secondGrayColor];
    }
//    else   if([self isKindOfClass:[TabsViewController class]]||[self isKindOfClass:[FeaturedSectionTabsViewController class]])
//    {
//
//        newCell.backgroundColor=[UIColor colorWithRed:0.90 green:0.65 blue:0.23 alpha:1.0];
//
//   // newCell.label.textColor=[UIColor whiteColor];
//  oldCell.backgroundColor=[UIColor colorWithRed:0.0/255.0 green:0.0/255.0  blue:0.0/255.0  alpha:1.0];
//    }
//    else
//    {
//        [oldCell.label setTextColor:[UIColor colorWithWhite:0.665 alpha:1.000]];
//        [newCell.label setTextColor:[UIColor blackColor]];
//        newCell.backgroundColor=[UIColor whiteColor];
//        oldCell.backgroundColor=[UIColor colorWithWhite:0.960 alpha:1.000];
//        oldCell.label.backgroundColor=[UIColor clearColor];
//    }
   // oldCell.label.textColor=[UIColor whiteColor];
    self.isSelected=YES;
    [self moveToViewControllerAtIndex:indexPath.item];
}

#pragma merk - UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.pagerTabStripChildViewControllers.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XLButtonBarViewCell * cell ;
    if(_isFromFeaturedSection) {
        
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
        
    }
    else{
        
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    }
    if (!cell){
        cell = [[XLButtonBarViewCell alloc] initWithFrame:CGRectMake(0, 0, 50, self.buttonBarView.frame.size.height)];
    }
    
    NSAssert([cell isKindOfClass:[XLButtonBarViewCell class]], @"UICollectionViewCell should be or extend XLButtonBarViewCell");
    XLButtonBarViewCell * buttonBarCell = (XLButtonBarViewCell *)cell;
    UIViewController<XLPagerTabStripChildItem> * childController =   [self.pagerTabStripChildViewControllers objectAtIndex:indexPath.item];
    
    [buttonBarCell.label setText:[childController titleForPagerTabStripViewController:self]];
    buttonBarCell.label.textColor=[UIColor blackColor];

    if (self.buttonBarView.labelFont) {
        buttonBarCell.label.font = self.buttonBarView.labelFont;
    }
    if (self.isFromMatchDetails) {
        if(self.currentIndex==indexPath.row)
        {
            buttonBarCell.backgroundColor=[UIColor whiteColor];;
            buttonBarCell.label.textColor=[UIColor blackColor];
            buttonBarCell.label. backgroundColor=[UIColor whiteColor];
        }
        else
        {
            buttonBarCell.backgroundColor=[UIColor colorWithWhite:0.960 alpha:1.000];;
            buttonBarCell.label.textColor=[UIColor colorWithWhite:0.665 alpha:1.000];
            buttonBarCell.label. backgroundColor=[UIColor clearColor];

        }
    }
    else if (self.isFromMatchEventsTabs)
    {

        if(self.currentIndex==indexPath.row)
        {
            buttonBarCell.label.backgroundColor=[UIColor darkGrayColor];
            buttonBarCell.label.textColor=[UIColor lightGrayColor];
            buttonBarCell.backgroundColor=[UIColor clearColor];;

        }
        else
        {
            buttonBarCell.label.backgroundColor=[UIColor whiteColor];
            buttonBarCell.backgroundColor=[UIColor clearColor];;
            buttonBarCell.label.textColor=[UIColor lightGrayColor];
        }
        [buttonBarCell.label. layer setCornerRadius:15.0f];
        [buttonBarCell.label. layer setMasksToBounds:YES];
    }
    else if (self.isFromTeamProfile)
    {

        if(self.currentIndex==indexPath.row)
        {
            buttonBarCell.label.backgroundColor=[UIColor whiteColor];
            buttonBarCell.label.textColor=[UIColor blackColor];

        }
        else
        {
            buttonBarCell.label.backgroundColor=[UIColor whiteColor];
            buttonBarCell.label.textColor=[UIColor secondGrayColor];
        }
       // [buttonBarCell.label. layer setCornerRadius:12.0f];
       // [buttonBarCell.label. layer setMasksToBounds:YES];
    }
    
//    else
//    {
//    if(self.currentIndex==indexPath.row)
//    {
//        buttonBarCell.backgroundColor=[UIColor colorWithRed:0.90 green:0.65 blue:0.23 alpha:1.0];
//        buttonBarCell.label.textColor=[UIColor whiteColor];
//    }
//    else
//    {
//         buttonBarCell.backgroundColor=[UIColor colorWithRed:0.0/255.0 green:0.0/255.0  blue:0.0/255.0  alpha:1.0];
//
//    }
//    }
    if ([childController respondsToSelector:@selector(imageForPagerTabStripViewController:)]) {
        UIImage *image = [childController imageForPagerTabStripViewController:self];
        buttonBarCell.imageView.image = image;
    }
    
    if ([childController respondsToSelector:@selector(highlightedImageForPagerTabStripViewController:)]) {
        UIImage *image = [childController highlightedImageForPagerTabStripViewController:self];
        buttonBarCell.imageView.highlightedImage = image;
    }
    
    if (self.isProgressiveIndicator) {
        if (self.changeCurrentIndexProgressiveBlock) {
            self.changeCurrentIndexProgressiveBlock(self.currentIndex == indexPath.item ? nil : cell , self.currentIndex == indexPath.item ? cell : nil, 1, YES, NO);
        }
    }
    else{
        if (self.changeCurrentIndexBlock) {
            self.changeCurrentIndexBlock(self.currentIndex == indexPath.item ? nil : cell , self.currentIndex == indexPath.item ? cell : nil, NO);
        }
    }
    
    return buttonBarCell;
}


#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [super scrollViewDidEndScrollingAnimation:scrollView];
    if (scrollView == self.containerView){
        self.shouldUpdateButtonBarView = YES;
    }
}


@end
