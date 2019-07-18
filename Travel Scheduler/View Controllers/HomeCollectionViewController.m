//
//  HomeCollectionsViewController.m
//  Travel Scheduler
//
//  Created by frankboamps on 7/16/19.
//  Copyright © 2019 aliu18. All rights reserved.
//

#import "HomeCollectionViewController.h"
#import "PlacesToVisitTableViewCell.h"
#import "AttractionCollectionCell.h"
#import "MoreOptionViewController.h"
#import "TravelSchedulerHelper.h"

@interface HomeCollectionViewController () <UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource>

@property(strong, nonatomic) UITableView *homeTable;
@property(strong, nonatomic) UITableViewCell *placesToVisitCell;
@property(nonatomic, strong) NSArray *allLocationsArray;
@property(nonatomic, strong) NSArray *restaurantsArray;
@property(nonatomic, strong) NSArray *hotelsArray;
@property(nonatomic, strong) NSArray *attractionsArray;
@property (nonatomic, strong) NSArray *colorArray;
@property (nonatomic, strong) NSMutableDictionary *contentOffsetDictionary;

@end

@implementation HomeCollectionViewController

#pragma mark - View controller life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.homeTable = [[UITableView alloc] initWithFrame:CGRectMake(5, 150, CGRectGetWidth(self.view.frame) - 15, CGRectGetHeight(self.view.frame) - 100) style:UITableViewStylePlain];
    self.homeTable.delegate = self;
    self.homeTable.dataSource = self;
    self.homeTable.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.homeTable setAllowsSelection:YES];
    [self.view addSubview:self.homeTable];
    UILabel *label = makeHeaderLabel(@"Places to Visit");
    [self.view addSubview:label];
    [self.homeTable reloadData];
}

//-(void) loadView  // code for making colors to be used for mean time
//{
//    [super loadView];
//    const NSInteger numberOfTableViewRows = 3;
//    const NSInteger numberOfCollectionViewCells = 8;
//    NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:numberOfTableViewRows];
//    for (NSInteger tableViewRow = 0; tableViewRow < numberOfTableViewRows; tableViewRow++){
//        NSMutableArray *colorArray = [NSMutableArray arrayWithCapacity:numberOfCollectionViewCells];
//        for (NSInteger collectionViewItem = 0; collectionViewItem < numberOfCollectionViewCells; collectionViewItem++){
//            CGFloat red = arc4random() % 255;
//            CGFloat green = arc4random() % 255;
//            CGFloat blue = arc4random() % 255;
//            UIColor *color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0f];
//            [colorArray addObject:color];
//        }
//        [mutableArray addObject:colorArray];
//    }
//    self.colorArray = [NSArray arrayWithArray:mutableArray];
//    self.contentOffsetDictionary = [NSMutableDictionary dictionary];
//}


#pragma mark - UITableViewDataSource Methods

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog([NSString stringWithFormat:@"%ld", indexPath.row]);
    static NSString *cellIdentifier = @"cellIdentifier";
    PlacesToVisitTableViewCell *cell = (PlacesToVisitTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil){
        cell = [[PlacesToVisitTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        CGRect myFrame = CGRectMake(10.0, 0.0, 220, 25.0);
        cell.labelWithSpecificPlaceToVisit = [[UILabel alloc] initWithFrame:myFrame];
        if(indexPath.row == 0){
            cell.labelWithSpecificPlaceToVisit.text = @"Attractions";
        }
        else if (indexPath.row == 1) {
            cell.labelWithSpecificPlaceToVisit.text = @"Restaurants";
        }
        else if (indexPath.row == 2){
            cell.labelWithSpecificPlaceToVisit.text = @"Hotels";
        }
        cell.labelWithSpecificPlaceToVisit.font = [UIFont boldSystemFontOfSize:17.0];
        cell.labelWithSpecificPlaceToVisit.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:cell.labelWithSpecificPlaceToVisit];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(PlacesToVisitTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setCollectionViewDataSourceDelegate:self indexPath:indexPath];
    NSInteger index = cell.placesToVisitCollectionView.indexPath.row;
    CGFloat horizontalOffset = [self.contentOffsetDictionary[[@(index) stringValue]] floatValue];
    [cell.collectionView setContentOffset:CGPointMake(horizontalOffset, 0)];
    
}

-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(PlacesToVisitTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat horizontalOffset = cell.collectionView.contentOffset.x;
    NSInteger index = cell.placesToVisitCollectionView.indexPath.row;
    self.contentOffsetDictionary[[@(index) stringValue]] = @(horizontalOffset);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}
/*
-(void)tableView:(UITableView *)tableView didSelectRowAt:(NSIndexPath *)indexPath {
    int cellNum = indexPath.row;
    MoreOptionViewController *moreOptionViewController = [[MoreOptionViewController alloc] init];
    if (cellNum == 0) {
        moreOptionViewController.stringType = @"Attractions";
    } else if (cellNum == 1) {
        moreOptionViewController.stringType = @"Restaurants";
    } else if (cellNum == 2) {
        moreOptionViewController.stringType = @"Hotels";
    }
    [self.navigationController pushViewController:moreOptionViewController animated:true];
}*/

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    int cellNum = indexPath.row;
    MoreOptionViewController *moreOptionViewController = [[MoreOptionViewController alloc] init];
    if (cellNum == 0) {
        moreOptionViewController.stringType = @"Attractions";
    } else if (cellNum == 1) {
        moreOptionViewController.stringType = @"Restaurants";
    } else if (cellNum == 2) {
        moreOptionViewController.stringType = @"Hotels";
    }
    [self.navigationController pushViewController:moreOptionViewController animated:true];
    return indexPath;
}

#pragma mark - UICollectionViewDataSource Methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView registerClass:[AttractionCollectionCell class] forCellWithReuseIdentifier:@"AttractionCollectionCell"];
    AttractionCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AttractionCollectionCell" forIndexPath:indexPath];
    //NSArray *collectionViewArray = self.colorArray[[(PlacesToVisitCollectionView *)collectionView indexPath].row];
    //cell.backgroundColor = collectionViewArray[indexPath.item];
   //UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    //cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photo-frame.png"]];
    [cell setImage];
    //[self.view addSubview:recipeImageView];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) collectionView.collectionViewLayout;
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    CGFloat postersPerLine = 3;
    CGFloat itemWidth = (collectionView.frame.size.width - layout.minimumInteritemSpacing * (postersPerLine - 1)) / postersPerLine;
    CGFloat itemHeight = itemWidth;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    return CGSizeMake(itemWidth, itemHeight);
}

#pragma mark - UIScrollViewDelegate Methods

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (![scrollView isKindOfClass:[UICollectionView class]]) return;
    CGFloat horizontalOffset = scrollView.contentOffset.x;
    PlacesToVisitCollectionView *collectionView = (PlacesToVisitCollectionView *)scrollView;
    NSInteger index = collectionView.indexPath.row;
    self.contentOffsetDictionary[[@(index) stringValue]] = @(horizontalOffset);
}

@end


