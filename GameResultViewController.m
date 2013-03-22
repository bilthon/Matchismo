//
//  GameResultViewController.m
//  Matchismo
//
//  Created by Nelson Perez on 3/20/13.
//  Copyright (c) 2013 Nelson Perez. All rights reserved.
//

#import "GameResultViewController.h"
#import "GameResult.h"
@interface GameResultViewController ()
@property (weak, nonatomic) IBOutlet UITextView *display;

@end

@implementation GameResultViewController

-(void)updateUI{
    NSString* displayText = @"";
    for (GameResult* result in [GameResult allGameResults]) {
        displayText = [displayText stringByAppendingFormat:@"Score: %d, (%@, %f)\n",result.score, result.end,round(result.duration)];
    }
    self.display.text = displayText;
}

- (IBAction)reset {
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:ALL_RESULTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self updateUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self updateUI];
}

-(void)setup{
    
}

-(void) awakeFromNib{
    [self setup];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    [self setup];
    return self;
}

@end
