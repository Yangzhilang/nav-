//
//  ViewController.m
//  nav渐变
//
//  Created by yzl on 16/3/28.
//  Copyright © 2016年 yzl. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,strong)UIView *navigationView;
@property(nonatomic,assign)CGFloat lastAlpha;
@property(nonatomic,strong)UIButton *setting;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.backgroundColor = [UIColor colorWithRed:62/255.0 green:184/255.0 blue:175/255.0 alpha:1];

    [self setUpNav];
}

- (void)setUpNav{
    UINavigationBar *bar = self.navigationController.navigationBar;
    [bar setBackgroundImage:[UIImage imageNamed:@"bg"] forBarMetrics:UIBarMetricsCompact];
    bar.layer.masksToBounds = YES;
    CGRect frame = bar.frame;

    frame.size.height += 20;
    frame.origin = CGPointMake(0, 0);
    self.navigationView = [[UIView alloc] initWithFrame:frame];
    self.navigationView.backgroundColor = [UIColor whiteColor];
    self.navigationView.alpha = 0;
    UILabel *label = [[UILabel alloc] init];
    label.text = @"我的";
    [label sizeToFit];
    label.center = CGPointMake(frame.size.width/2, frame.size.height - 5 - label.bounds.size.height);
    [self.navigationView addSubview:label];
    [self.navigationController.view insertSubview:self.navigationView belowSubview:bar];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:self.setting];
    self.navigationItem.rightBarButtonItem = right;
}

- (UIButton*)setting{
    if (!_setting) {
        _setting = [UIButton buttonWithType:UIButtonTypeCustom];
        _setting.frame = CGRectMake(0, 0, 20, 20);
        [_setting setImage:[UIImage imageNamed:@"icon_homepage_message"] forState:UIControlStateNormal];
    }
    return _setting;
}

- (void)setState:(float)alpha{
    if (alpha < .5) {
        [_setting setImage:[UIImage imageNamed:@"icon_homepage_message"] forState:UIControlStateNormal];
    }
    else{
        [_setting setImage:[UIImage imageNamed:@"icon_homepage_message_normal"] forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return NULL;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset = scrollView.contentOffset;
    self.navigationView.alpha = (offset.y+64)/64;

    if (self.navigationView.alpha > .5f && self.lastAlpha<=.5f) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
        [self setState:self.navigationView.alpha];
    }
    else if (self.navigationView.alpha<.5f && self.lastAlpha>=.5f){
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
        [self setState:self.navigationView.alpha];
    }
    self.lastAlpha = self.navigationView.alpha;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
