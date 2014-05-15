//
//  CollectData.h
//  DataCollectionDemo
//
//  Created by Shawn on 14-5-15.
//  Copyright (c) 2014年 hanlong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CollectData : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * pressure;
@property (nonatomic, retain) NSNumber * temperature;
@property (nonatomic, retain) NSNumber * number;

@end
