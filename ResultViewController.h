//
//  ResultViewController.h
//  DataCollectionDemo
//
//  Created by Shawn on 14-5-15.
//  Copyright (c) 2014年 hanlong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectData.h"
@interface ResultViewController : UIViewController<NSFetchedResultsControllerDelegate>

@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic,retain) NSFetchedResultsController *fetchedResultsController;

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

- (IBAction)calcuResult:(id)sender;

@end
