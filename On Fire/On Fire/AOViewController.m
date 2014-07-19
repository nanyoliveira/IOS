//
//  AOViewController.m
//  On Fire
//
//  Created by Ariane de Oliveira on 09/07/2014.
//  Copyright (c) 2014 Ariane de Oliveira. All rights reserved.
//

#import "AOViewController.h"

@interface AOViewController ()

@property UIImageView * animeImageView ;

@property NSMutableArray *imagesMutable;
@property NSMutableArray *imagesMutableOff;
@property   AOAudioListener * audio;


@end

@implementation AOViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
    /* normal playing */
    //images name
    NSArray * imagesArray = @[@"fire_00", @"fire_01", @"fire_02", @"fire_03", @"fire_04", @"fire_05", @"fire_06", @"fire_07", @"fire_08", @"fire_09", @"fire_10"];
    
    
    //inserting UIImages on an array based on its name
    self.imagesMutable = [[NSMutableArray alloc]init];
    for (int i =0; i < imagesArray.count; i++) {
        [self.imagesMutable addObject:[UIImage imageNamed:[imagesArray objectAtIndex:i ] ]];
    }
    
    /* on Blowing*/
    
    //images name
    NSArray * imagesArrayOff = @[@"fireOff_00", @"fireOff_01", @"fireOff_02", @"fireOff_03", @"fireOff_04", @"fireOff_05", @"fireOff_06", @"fireOff_07", @"fireOff_08", @"fireOff_09", @"fireOff_10", @"fireOff_11", @"fireOff_12", @"fireOff_13"];
    
    
    //inserting UIImages on an array based on its name
    self.imagesMutableOff = [[NSMutableArray alloc]init];
    for (int j =0; j < imagesArrayOff.count; j++) {
        [self.imagesMutable addObject:[UIImage imageNamed:[imagesArrayOff objectAtIndex:j ] ]];
    }
    
    
    //seting UIImages with base on the UIImage Array
    self.animeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    self.animeImageView.animationImages = self.imagesMutable;
    self.animeImageView.animationDuration = .9;
    
    [self.view addSubview:self.animeImageView];
    [self.animeImageView startAnimating];
    
    SEL selector = @selector(whenBlowing);
    self.audio = [[AOAudioListener alloc] init];
    self.audio.delegate = self;
    [self.audio startListening];
}

-(void)blowingAction
{
    [self whenBlowing];
}


- (void)whenBlowing
{
    NSLog(@"blowing on view");
    [self.animeImageView stopAnimating];
    self.animeImageView.animationImages = self.imagesMutable;
    self.animeImageView.animationRepeatCount = 1;
    [self.animeImageView startAnimating];
    [self.audio stopListening];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
