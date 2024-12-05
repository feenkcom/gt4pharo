Extension { #name : #BrMenuExamples }

{ #category : #'*GToolkit-Pharo-Coder-Method-Examples' }
BrMenuExamples >> definingPharoMethodCoderMenu [
	<gtExample>
	| aMenu |
	aMenu := BrMenuExplicit new.
	aMenu
		stencil: [
			| aCoder aCoderViewModel aCoderElement |
			aCoder := GtPharoMethodCoder forMethod: BlElement >> #gtPreviewFor:.
			aCoderViewModel := aCoder asCoderViewModel.
			aCoderElement := aCoderViewModel asExpandedOnlyElement
				hExact: 500;
				vExact: 400;
				border: (BlBorder paint: Color veryLightGray width: 1);
				geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
				clipChildren: false;
				background: Color white;
				addAptitude: BrMenuPinnableAptitude new;
				addAptitude: BrShadowAptitude new ].

	self assert: aMenu stencil isNotNil.
	self assert: (aMenu asElement isKindOf: BlElement).

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
