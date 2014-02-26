//
//  TouchViewController.m
//  challenge2
//
//  Created by David Law on 2/24/14.
//  Copyright (c) 2014 David Law. All rights reserved.
//

#import "TouchViewController.h"

@interface TouchViewController ()
@property (strong, nonatomic) IBOutlet UIView *redBox;
@property (assign, nonatomic) CGFloat x_offset;
@property (assign, nonatomic) CGFloat y_offset;
- (void)onPanHeadline:(UIPanGestureRecognizer *)panGestureRecognizer;


@end

@implementation TouchViewController
/* Pan Gesture Recognizer */

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
    // Do any additional setup after loading the view from its nib.
    [self.redBox setUserInteractionEnabled:YES];
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPanHeadline:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:2];
    [self.redBox addGestureRecognizer:panRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onPanHeadline:(UIPanGestureRecognizer *)panGestureRecognizer {
    CGPoint superViewPoint = [panGestureRecognizer locationInView:self.view];
    CGPoint point = [panGestureRecognizer locationInView:self.redBox];
    CGPoint velocity = [panGestureRecognizer velocityInView:self.redBox];
    
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        self.x_offset = point.x - (self.redBox.frame.size.width / 2);
        self.y_offset = point.y - (self.redBox.frame.size.height / 2);
    }
    else if (panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        self.redBox.center = CGPointMake(superViewPoint.x - self.x_offset, superViewPoint.y - self.y_offset);
    }
    else if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        
    }
}

@end
