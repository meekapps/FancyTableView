//
//  FancyTableVC.m
//  FancyTableView
//
//  Created by Mike Keller on 1/30/12.
//  Copyright (c) 2012 Meek Apps. All rights reserved.
//
//  A fancy table view that demonstrates gradient cell backgrounds
//    and shadows under the table view to give it depth (like the Clock app).
//    Also, shadowed textLabels and detailTextLabels that adjust themselves when
//    selected (via UITableViewCell subclassing).

#import "FancyTableVC.h"
#import "FancyTableCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation FancyTableVC

@synthesize tableView = _tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    

    //Create the Table View
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - self.navigationController.navigationBar.frame.size.height) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 100.0f;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    [self.view addSubview:self.tableView];
    
    //Create the background view and gradients (shadows)
    CGRect screenBounds = self.view.bounds;
    UIView *bgView = [[UIView alloc] initWithFrame:screenBounds];
    [bgView setBackgroundColor:[UIColor underPageBackgroundColor]];
    
    //top shadow (pinned under nav bar)
    UIView *topShadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 10)];
    CAGradientLayer *topShadow = [CAGradientLayer layer];
    topShadow.frame = CGRectMake(0, 0, self.tableView.bounds.size.width, 10);
    topShadow.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithWhite:0.0 alpha:0.25f] CGColor], (id)[[UIColor clearColor] CGColor], nil];
    [topShadowView.layer insertSublayer:topShadow atIndex:0];
    
    [bgView addSubview:topShadowView];
    
    //bottom shadow (pinned to bottom of screen, under table view)
    UIView *bottomShadowView = [[UIView alloc] initWithFrame:CGRectMake(0, self.tableView.bounds.size.height-10, self.tableView.bounds.size.width, 10)];
    CAGradientLayer *bottomShadow = [CAGradientLayer layer];
    bottomShadow.frame = CGRectMake(0, 0, self.tableView.bounds.size.width, 10);
    bottomShadow.colors = [NSArray arrayWithObjects:(id)[[UIColor clearColor] CGColor], (id)[[UIColor colorWithWhite:0.0 alpha:0.25f] CGColor], nil];
    [bottomShadowView.layer insertSublayer:bottomShadow atIndex:0];
    
    [bgView addSubview:bottomShadowView];
    
    
    self.tableView.backgroundView = bgView;
    
    //top table shadow (facing up from table view)
    //  Looks best slightly smaller than topShadow
    CAGradientLayer *upGradient = [CAGradientLayer layer];
    upGradient.frame = CGRectMake(0, -7, self.tableView.bounds.size.width, 7);
    upGradient.colors = [NSArray arrayWithObjects:(id)[[UIColor clearColor] CGColor], (id)[[UIColor colorWithWhite:0.0 alpha:0.15f] CGColor], nil];
    [self.tableView.layer addSublayer:upGradient];
    
    //bottom table shadow (facing down from table view)
    //  Looks best slightly smaller than topShadow
    CAGradientLayer *downGradient = [CAGradientLayer layer];
    downGradient.frame = CGRectMake(0, self.tableView.rowHeight*[self.tableView numberOfRowsInSection:0], self.tableView.bounds.size.width, 7);
    downGradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithWhite:0.0 alpha:0.15f] CGColor], (id)[[UIColor clearColor] CGColor], nil];
    [self.tableView.layer addSublayer:downGradient];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UITableView

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath  {
    UIView *backgroundView = [[UIView alloc] initWithFrame:cell.frame];
    
    CAGradientLayer *cellGradient = [CAGradientLayer layer];
    cellGradient.frame = cell.bounds;
    
    cellGradient.colors = [NSArray arrayWithObjects:
                           (id)[UIColor colorWithRed:234.0f/256.0f green:236.0f/256.0f blue:242.0f/256.0f alpha:1.0f].CGColor,
                           (id)[UIColor colorWithRed:209.0f/256.0f green:211.0f/256.0f blue:216.0f/256.0f alpha:1.0f].CGColor, nil];
    [backgroundView.layer addSublayer:cellGradient];
    
    cell.backgroundView = backgroundView;

}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"CellID";
    FancyTableCell *cell = (FancyTableCell*)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[FancyTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.textLabel.shadowColor = [UIColor lightTextColor];		
        cell.textLabel.shadowOffset = CGSizeMake(0, 1);
        
        cell.detailTextLabel.textColor = [UIColor darkGrayColor];
        cell.detailTextLabel.shadowColor = [UIColor lightTextColor];
        cell.detailTextLabel.shadowOffset = CGSizeMake(0, 1);
        cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Cell Title %d", indexPath.row];
    cell.detailTextLabel.text = @"Sweet description about this thing.";

    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {  
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
