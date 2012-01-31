//
//  FancyTableVC.h
//  FancyTableView
//
//  Created by Mike Keller on 1/30/12.
//  Copyright (c) 2012 Meek Apps. All rights reserved.
//
//  A fancy table view that demonstrates gradient cell backgrounds
//    and shadows under the table view to give it depth (like the Clock app).
//    Also, shadowed textLabels and detailTextLabels that adjust themselves when
//    selected (via UITableViewCell subclassing).

#import <UIKit/UIKit.h>

@interface FancyTableVC : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    UITableView *_tableView;
}

@property (nonatomic, retain) UITableView *tableView;

@end
