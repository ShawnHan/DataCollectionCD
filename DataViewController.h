//
//  DataViewController.h
//  DataCollectionDemo
//
//  Created by Shawn on 14-5-15.
//  Copyright (c) 2014年 hanlong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectData.h"
#import "DetailViewController.h"
@interface DataViewController : UIViewController<UITableViewDataSource,UITabBarDelegate,NSFetchedResultsControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *dataTableView;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
- (IBAction)caluView:(id)sender;
- (IBAction)gotoDetail:(id)sender;

@end
