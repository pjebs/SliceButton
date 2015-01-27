//
//  ViewController.m
//  Example
//
//  Created by PJ on 2/12/13.
//
//

#import "ViewController.h"

//These values are specific to the images used
#define DEFAULT_BIG_RADIUS 120
#define DEFAULT_SMALL_RADIUS 41



@interface ViewController ()

@property (strong, nonatomic) IBOutlet SliceButton *LeftControls;
@property (strong, nonatomic) IBOutlet SliceButton *RightControls;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Create button images
    UIImage *imageLeft = [UIImage imageNamed:@"LeftSlice"];
    UIImage *imageRight = [UIImage imageNamed:@"RightSlice"];
    //Create yellow dot image
    UIImage *dotImage = [UIImage imageNamed:@"dot"];

    //The width and height of the dot.png image is 12*12. Therefore we need half the diagonal distance.
    float small_dot_radius_offset = 0.5*sqrtf(12*12 + 12*12)+4; //The 4 is just a small adjustment added on to make the end positioning appear 'nice'
    
    //Allocate and Initalise SliceButtons
    self.LeftControls = [[SliceButton alloc] initWithSettingsSuchAsLeftOrientation:YES ButtonNumber:5 SmallRadius:DEFAULT_SMALL_RADIUS BigRadius:DEFAULT_BIG_RADIUS Image:imageLeft DotImage:dotImage DotImageRadiusOffset:small_dot_radius_offset SuperView:self.view];
    self.RightControls = [[SliceButton alloc] initWithSettingsSuchAsLeftOrientation:NO ButtonNumber:5 SmallRadius:DEFAULT_SMALL_RADIUS BigRadius:DEFAULT_BIG_RADIUS Image:imageRight DotImage:dotImage DotImageRadiusOffset:small_dot_radius_offset SuperView:self.view];
    
    //For testing purposes ONLY. It will reduce alpha value and put in CLEAR markers of slices
    self.LeftControls.debug = YES;
    
    self.LeftControls.delegate = self;
    self.RightControls.delegate = self;
    
    self.view.autoresizingMask = 0;
}

-(void)dealloc
{
    self.LeftControls = nil;
    self.RightControls = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    float h;
    float w;
    
    if ([[[UIDevice currentDevice] systemVersion] compare:@"8" options:NSNumericSearch] != NSOrderedAscending)
    {
        h = self.view.bounds.size.height; //Length of Superview
        w = self.view.bounds.size.width; //Width of Superview
    }
    else
    {
        h = self.view.bounds.size.width; //Length of Superview
        w = self.view.bounds.size.height; //Width of Superview
    }
    
    float r = DEFAULT_BIG_RADIUS; //radius of Left/Right Controls
    
    //Arrange Left and Right SliceButtons
    self.LeftControls.frame = CGRectMake(0, h-2*r, r, 2*r);
    self.RightControls.frame = CGRectMake(w-r, h-2*r, r, 2*r);
    
    self.view.frame = CGRectMake(0,0,w,h);

}

#pragma mark SliceButton delegate methods

-(void)sliceButtonTapped: (SliceButton *)sliceButton buttonIndex:(int) index;
{
    sliceButton.selected = index;

}


@end
