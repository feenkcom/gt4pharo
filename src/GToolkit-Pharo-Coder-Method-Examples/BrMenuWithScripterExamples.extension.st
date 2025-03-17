Extension { #name : #BrMenuWithScripterExamples }

{ #category : #'*GToolkit-Pharo-Coder-Method-Examples' }
BrMenuWithScripterExamples >> hoverDefiningPharoMethodCoderMenuItem [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterWithElement: [ self buttonWithDropdownMenu: BrMenuExamples new menuItems_withPharoMethodCoder ].

	aScripter click
		label: 'Open dropdown';
		id: #'menu-dropdown-button';
		play.

	aScripter mouseMoveOver
		label: 'Open defining method menu item';
		onSpaceRoot;
		id: #'menu-defining-method-item' asBlocElementId;
		play.

	aScripter mouseMoveOver
		label: 'Move mouse to coder menu handle';
		onSpaceRoot;
		id: #'menu--pinned-handle';
		play.
		
	aScripter assert
		label: 'Dropdown container does not exist';
		exists;
		onSpaceRoot;
		// BrMenuSteppedElement;
		play.

	(aScripter mouseDragBy: 50 @ 100)
		label: 'Move method coder menu';
		onSpaceRoot;
		id: #'menu--pinned-handle';
		play.

	aScripter assert
		label: 'Dropdown container does not exist';
		notExists;
		onSpaceRoot;
		// BrMenuSteppedElement;
		play.

	^ aScripter
]
