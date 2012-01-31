//
//  AppDelegate.h
//  FancyTableView
//
//  Created by Mike Keller on 1/30/12.
//  Copyright (c) 2012 Meek Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FancyTableVC;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) FancyTableVC *viewController;

@end
