Extension { #name : #BrMenuExamples }

{ #category : #'*GToolkit-Pharo-Coder-Method-Examples' }
BrMenuExamples >> definingPharoMethodCoderMenu [
	<gtExample>
	| aMenu |
	aMenu := GtPharoMethodCoderMenu new 
		forMethod: BlElement >> #gtPreviewFor:.

	self assertGlamorousElementForMenuModel: aMenu.

	^ aMenu
]

{ #category : #'*GToolkit-Pharo-Coder-Method-Examples' }
BrMenuExamples >> menuItems_withPharoMethodCoder [
	<gtExample>
	| aMenuItems |
	aMenuItems := self menuItems.
	aMenuItems items last
		label: 'Defining method';
		submenu: self definingPharoMethodCoderMenu.

	^ aMenuItems
]
