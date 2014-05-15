//
//  ResultViewController.m
//  DataCollectionDemo
//
//  Created by Shawn on 14-5-15.
//  Copyright (c) 2014年 hanlong. All rights reserved.
//

#import "ResultViewController.h"
#import "AppDelegate.h"
#import "BEMSimpleLineGraphView.h"

@interface ResultViewController ()<BEMSimpleLineGraphDelegate>

@end

@implementation ResultViewController

@synthesize managedObjectContext;
@synthesize fetchedResultsController = _fetchedResultsController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    managedObjectContext = [appDelegate managedObjectContext];

    NSError *error;
    if (![[self fetchedResultsController] performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@",error, [error userInfo]);
        exit(-1);
    }
    
    BEMSimpleLineGraphView *myGraph = [[BEMSimpleLineGraphView alloc] initWithFrame:CGRectMake(0, 64, 320, 200)];
    myGraph.delegate = self;
    myGraph.enableTouchReport = YES;
    myGraph.colorXaxisLabel = [UIColor whiteColor];
    [self.view addSubview:myGraph];
    
    UIColor *color;
    color = [UIColor colorWithRed:0.0 green:140.0/255.0 blue:255.0/255.0 alpha:1.0];
    // Do any additional setup after loading the view.
    myGraph.colorTop = color;
    myGraph.colorBottom = color;
    myGraph.widthLine = 3.0;
    myGraph.enableTouchReport = YES;
    myGraph.enableBezierCurve = NO;
    myGraph.backgroundColor = color;

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)calcuResult:(id)sender {
    
    
    
    NSError *error;
    
	if (![[self fetchedResultsController] performFetch:&error]) {
        
		NSLog(@"Error in search %@, %@", error, [error userInfo]);
        
	} else {
        
        
    }

    //CollectData *data = [_fetchedResultsController sections];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObjectsFromArray:_fetchedResultsController.fetchedObjects];
    NSLog(@"date == %@",[[[_fetchedResultsController fetchedObjects] valueForKey:@"date"] objectAtIndex:0]);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
    //NSDate *date = [dateFormatter dateFromString:[[[_fetchedResultsController fetchedObjects] valueForKey:@"date"] objectAtIndex:0]];
    //NSLog(@"date formatter == %@",date);
    //NSDate *date = [dateFormatter dateFromString:[[[_fetchedResultsController fetchedObjects] valueForKey:@"date"] objectAtIndex:0]];
    //NSLog(@"date == %@",date);
    //NSDateFormatter *dateF = [[NSDateFormatter alloc] init];
    //[dateF setDateFormat:@"HH.mm.ss"];
    NSString *dateStr = [dateFormatter stringFromDate:[[[_fetchedResultsController fetchedObjects] valueForKey:@"date"] objectAtIndex:0]];
    NSLog(@"dateStr == %@",dateStr);
    
    NSLog(@"collect data == %i",_fetchedResultsController.fetchedObjects.count);
    
}


-(NSFetchedResultsController *)fetchedResultsController {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"CollectData" inManagedObjectContext:managedObjectContext];
    
    [fetchRequest setEntity:entity];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:@"number" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    [fetchRequest setFetchBatchSize:20];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
    NSDate *date = [dateFormatter dateFromString:@"2014-05-14-14-50-00"];
    NSPredicate  *pred = [NSPredicate predicateWithFormat:@"date > %@",date];


    [fetchRequest setPredicate:pred];
    
    NSFetchedResultsController *theFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:managedObjectContext sectionNameKeyPath:nil
                                                   cacheName:nil]; // better to not use cache
    self.fetchedResultsController = theFetchedResultsController;
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;

    
}

#pragma mark chart delegate
-(NSInteger)numberOfPointsInLineGraph:(BEMSimpleLineGraphView *)graph
{
    
    return _fetchedResultsController.fetchedObjects.count;
}
-(CGFloat)lineGraph:(BEMSimpleLineGraphView *)graph valueForPointAtIndex:(NSInteger)index
{
    return [[[[_fetchedResultsController fetchedObjects] valueForKey:@"temperature"] objectAtIndex:index] floatValue];
}
- (void)lineGraph:(BEMSimpleLineGraphView *)graph didTouchGraphWithClosestIndex:(NSInteger)index {
    // Here you could change the text of a UILabel with the value of the closest index for example.
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd.HH.mm.ss"];
    
    
    _resultLabel.text = [NSString stringWithFormat:@"%@,%@",[[[_fetchedResultsController fetchedObjects] valueForKey:@"temperature"] objectAtIndex:index],[dateFormatter stringFromDate:[[[_fetchedResultsController fetchedObjects] valueForKey:@"date"] objectAtIndex:index]]];
    
    //_resultLabel.text = [NSString stringWithFormat:@"%@,%@",[[[_fetchedResultsController fetchedObjects] valueForKey:@"temperature"] objectAtIndex:index],[[[_fetchedResultsController fetchedObjects] valueForKey:@"number"] objectAtIndex:index]];
    
}

- (NSInteger)numberOfGapsBetweenLabelsOnLineGraph:(BEMSimpleLineGraphView *)graph {
    return 0; // The number of hidden labels between each displayed label.
}
- (NSString *)lineGraph:(BEMSimpleLineGraphView *)graph labelOnXAxisForIndex:(NSInteger)index {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd.HH.mm.ss"];
    //return [dateFormatter stringFromDate:[[[_fetchedResultsController fetchedObjects] valueForKey:@"date"] objectAtIndex:index]];
    return [NSString  stringWithFormat:@"%@",[[[_fetchedResultsController fetchedObjects] valueForKey:@"number"] objectAtIndex:index]];
}


@end
