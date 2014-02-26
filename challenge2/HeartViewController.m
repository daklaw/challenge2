//
//  HeartViewController.m
//  challenge2
//
//  Created by David Law on 2/24/14.
//  Copyright (c) 2014 David Law. All rights reserved.
//

#import "HeartViewController.h"

@interface HeartViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *image;

- (void) doDoubleTap;

@end

@implementation HeartViewController

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
    [self.image setImage:[UIImage imageNamed:@"search"]];
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget: self action:@selector(doDoubleTap)];
    doubleTap.numberOfTapsRequired = 2;
    [self.image addGestureRecognizer:doubleTap];
    [self.image setUserInteractionEnabled:YES];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark Private Method

- (void) doDoubleTap {
    UIImageView *heartView = [[UIImageView alloc] initWithFrame:CGRectMake(self.image.frame.origin.x, self.image.frame.origin.y, self.image.frame.size.width, self.image.frame.size.width)];
    heartView.alpha = 0;
    [self.view addSubview:heartView];
    [heartView setImage:[UIImage imageNamed:@"heart"]];
    [UIView animateWithDuration:2 animations:^{
        heartView.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:2 animations:^{
            [heartView setAlpha:0];
        } completion:nil];
    }];
}

@end
