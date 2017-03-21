//
//  CTTableViewDataSource.m
//  CardTilt
//
//  Created by Jack Wu on 2014-05-04.
//  Copyright (c) 2014 Brian Broom. All rights reserved.
//

#import "CTTableViewDataSource.h"
#import "CTCardCell.h"

@implementation CTTableViewDataSource

- (instancetype) init {
    self = [super init];
    if (self) {
        [self loadData];
    }
    return self;
}


#pragma mark - Private

- (void)loadData {
    NSError *error;
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"TeamMembers" ofType:@"json"]];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    self.members = json[@"Team"];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.members count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Card";
    CTCardCell *cell = (CTCardCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    [cell setupWithDictionary:self.members[indexPath.row]];
    
    return cell;
}


@end
