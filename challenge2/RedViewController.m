//
//  RedViewController.m
//  challenge2
//
//  Created by David Law on 2/24/14.
//  Copyright (c) 2014 David Law. All rights reserved.
//

#import "RedViewController.h"
#import "BlueViewController.h"

@interface RedViewController ()

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactiveTransition;
- (IBAction)onBluePill:(id)sender;
- (void)onPanGesture:(UIPanGestureRecognizer *)panGesture;
@end

@implementation RedViewController 

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
    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPanGesture:)]];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onBluePill:(id)sender {
    BlueViewController *vc = [[BlueViewController alloc] init];
    
    vc.modalPresentationStyle = UIModalPresentationCustom;
    vc.transitioningDelegate = self;

    NSLog(@"Here");
    [self presentViewController:vc animated:YES completion:nil];
    
}


#pragma mark UIViewControllerAnimatedTransitioning Delegate Methods

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self;
}

#pragma mark UIViewControllerContextTransitioning Delegate Methods

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 2;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = [transitionContext containerView];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    
    toViewController.view.frame = fromViewController.view.frame;
    toViewController.view.alpha = 0;
    [containerView addSubview:toViewController.view];
    
    [UIView animateWithDuration:2 animations:^{
        toViewController.view.alpha = 1;
    } completion:^(BOOL finished) {
        [fromViewController.view removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
}

# pragma mark UIViewControllerInteractiveTransitioning delegate methods

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator {
    self.interactiveTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
    return self;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    self.interactiveTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
    return self;
}

- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    [self animateTransition:transitionContext];
}

# pragma mark - Private Methods

- (void)onPanGesture:(UIPanGestureRecognizer *) panGesture {
    CGPoint point = [panGesture locationInView:self.view];
    if (panGesture.state == UIGestureRecognizerStateBegan) {
        BlueViewController *vc = [[BlueViewController alloc] init];
        vc.modalPresentationStyle = UIModalPresentationCustom;
        vc.transitioningDelegate = self;
        [self presentViewController:vc animated:YES completion:nil];

    }
    else if (panGesture.state == UIGestureRecognizerStateChanged) {
        float percentComplete = point.x / self.view.frame.size.width;
        [self.interactiveTransition updateInteractiveTransition:percentComplete];
    }
    else if (panGesture.state == UIGestureRecognizerStateEnded) {
        [self.interactiveTransition finishInteractiveTransition];
    }
}

@end