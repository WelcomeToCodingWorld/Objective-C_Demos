- (void)keyboardWillAppear:(BOOL)appear endToFrame:(CGRect)frame{
	CGRect frameInView = [self.view convertRect:_currentTextField.frame fromView:_currentTextField.superview];
	if (!appear) {//键盘将要消失
		_scrollView.contentOffset = CGPointMake(0, -kNavHeight);
		return;
	}
	
	if (CGRectGetMaxY(frameInView)<=CGRectGetMinY(frame)) {//不需要适应
		if (!keyBoardAppeared) {
			_scrollView.contentOffset = CGPointMake(0, -kNavHeight);
		}
		return;
	}
	_scrollView.contentOffset = CGPointMake(0, -kNavHeight + (CGRectGetMaxY(frameInView)-CGRectGetMinY(frame)));
	keyBoardAppeared = appear;
}