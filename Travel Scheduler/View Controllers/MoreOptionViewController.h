//
//  MoreOptionViewController.h
//  Travel Scheduler
//
//  Created by aliu18 on 7/16/19.
//  Copyright © 2019 aliu18. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MoreOptionViewController : UIViewController

@property (strong, nonatomic) NSString *stringType;
@property (strong, nonatomic) NSMutableArray *places;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UIButton *scheduleButton;
@property (strong, nonatomic) NSMutableArray *selectedPlacesArray;
@property (strong, nonnull) UISearchBar *moreOptionSearchBarAutoComplete;
@property (strong, nonatomic) NSArray *filteredPlaceToVisit;
@property (strong, nonatomic) UIButton *searchButton;
@property (strong, nonatomic) NSMutableArray *resultsArr;

@end

NS_ASSUME_NONNULL_END
