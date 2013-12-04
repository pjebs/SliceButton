//
//  SliceButton.m
//
//  Created by PJ
//  Copyright (c) 2013 PJ Engineering and Business Solutions.
//  All rights reserved.
//

#import "SliceButton.h"

@interface SliceButton ()

    @property(nonatomic, strong) UIImageView *overlay;
    @property(nonatomic, strong) UIImageView *smallDot;

@end


@implementation SliceButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithSettingsSuchAsLeftOrientation:(BOOL)orientation_left ButtonNumber:(int)number SmallRadius:(int)small_radius BigRadius:(int)big_radius Image:(UIImage *)image DotImage:(UIImage *)dot_image DotImageRadiusOffset:(float)offset SuperView:(UIView*)superview;
{
    self = [super init];
    if (self)
    {
        self.debug = FALSE;
        
        self.orientation_left = orientation_left;
        [superview addSubview:self];
        self.backgroundColor = [UIColor clearColor];
        self.small_radius = small_radius;
        self.big_radius = big_radius;
        self.buttons = number;
        self.dot_image_radius_offset = offset;
        
        self.overlay = [[UIImageView alloc] initWithImage:image];
        [self addSubview:self.overlay];
        
        self.selected = -1; //none selected
        self.smallDot = [[UIImageView alloc] initWithImage:dot_image];
        self.smallDot.hidden = YES;
        [self addSubview:self.smallDot];
    }
    return self;
}


-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if (self.debug == NO) return;
    
    // Drawing debug circle underneath overlay image
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect half_circle = CGRectMake((self.orientation_left == YES) ? -rect.size.width: 0, 0, rect.size.width * 2 , rect.size.height);
    CGContextAddEllipseInRect(context, half_circle);
    CGContextDrawPath(context, kCGPathStroke);
    
    CGRect half_circle2 = CGRectMake(-self.small_radius + ((self.orientation_left == YES) ? 0 : rect.size.width), rect.size.height / 2 - self.small_radius, self.small_radius * 2  , self.small_radius*2);
    CGContextAddEllipseInRect(context, half_circle2);
    CGContextDrawPath(context, kCGPathStroke);
    
    float incAngle = 180.0/self.buttons;
    
    for (int i=0;i<self.buttons;i++)
    {
        float angle = (i*incAngle-90)*M_PI/180.0;
        CGContextMoveToPoint(context,(self.orientation_left == YES) ? 0 : rect.size.width, rect.size.height/2);
        CGContextAddLineToPoint(context, ((self.orientation_left == YES) ? self.big_radius*cos(angle) : rect.size.width - self.big_radius*cos(angle)), self.big_radius*sin(angle) + rect.size.height/2);
        CGContextStrokePath(context);
    }
}

- (void)setFrame:(CGRect)frame;
{
    [super setFrame:frame];
    self.overlay.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
}

- (void)setSelected:(int)selected
{
    if (selected != _selected)
    {
        _selected = selected;
        
        if (selected == -1)
        {
            self.smallDot.hidden = YES;
        }
        else
        {
            float angle = (180.0/self.buttons)*(0.5 + selected);
                        
            float inner_x_eqn = (self.big_radius - self.dot_image_radius_offset)*sin(angle*M_PI/180.0);
            
            float x = (self.orientation_left == YES) ? inner_x_eqn : self.big_radius - inner_x_eqn;
            float y = self.big_radius - (self.big_radius - self.dot_image_radius_offset)*cos(angle*M_PI/180.0);
            
            self.smallDot.center = CGPointMake(x, y);
            
            self.smallDot.hidden = NO;
        }
        
        
        //Change to display
        [self setNeedsDisplay];
    }
}

- (void)setDebug:(BOOL)debug
{
    if (debug != _debug)
    {
        _debug = debug;
        self.overlay.alpha = (debug == YES) ?  0.5 : 1;
        //Change to big radius
        [self setNeedsDisplay];
    }
}

- (void)setBig_radius:(int)big_radius
{
    if (big_radius != _big_radius)
    {
        _big_radius = big_radius;
        //Change to big radius
        [self setNeedsDisplay];
    }
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    //Respond to one tap only
    if ([[touches anyObject] tapCount] == 1)
    {
        CGPoint point = [[touches anyObject] locationInView:self];
        
        float new_x = (self.orientation_left == YES) ? point.x : self.bounds.size.width - point.x;
        float new_y = point.y - self.frame.size.height/2;
        
        float r = sqrt(new_x*new_x + new_y*new_y);
        float thetha = atan2(new_y,new_x)*180.0/M_PI + 90;   //Thetha seems to range from 90 to -90 (this is correct but not untuitive. So add 90.
        
        if ((r >= self.small_radius) && (r <= self.big_radius))
        {
            if ([self.delegate respondsToSelector:@selector(sliceButtonTapped:buttonIndex:)])
            {
                //optional protocol method has been implemented.
                
                for (int i=0;i<self.buttons;i++)
                {
                    int maxAngle = (i+1)*180/self.buttons;
                    if (thetha <= maxAngle)
                    {
                        [self.delegate sliceButtonTapped:self buttonIndex:i];
                        break;
                    }
                }
            }
        }
    }
}

@end
