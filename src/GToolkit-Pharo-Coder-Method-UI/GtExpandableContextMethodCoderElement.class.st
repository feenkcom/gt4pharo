Class {
	#name : #GtExpandableContextMethodCoderElement,
	#superclass : #GtExpandableMethodCoderElement,
	#instVars : [
		'uninstalledIndicator'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-! Views'
}

{ #category : #accessing }
GtExpandableContextMethodCoderElement >> coderViewModel: aCoderViewModel [
	super coderViewModel: aCoderViewModel.
	aCoderViewModel
		ifNotNil: [ aCoderViewModel coder weak
				when: GtCoderMethodModified
				send: #updateUninstalledIndicator
				to: self.
			self updateUninstalledIndicator ]
]

{ #category : #initialization }
GtExpandableContextMethodCoderElement >> initialize [
	super initialize.
	uninstalledIndicator := self newUninstalledIndicator.
	uninstalledIndicator visibility: BlVisibility gone.
	self addChild: uninstalledIndicator before: modificationIndicator
]

{ #category : #accessing }
GtExpandableContextMethodCoderElement >> newUninstalledIndicator [
	^ BlElement new
		constraintsDo: [ :c | 
			c ignoreByLayout.
			c ignored horizontal alignLeft.
			c horizontal exact: 5.
			c vertical matchParent.
			c margin: (BlInsets left: 8) ];
		preventMeAndChildrenMouseEvents;
		background: self theme status errorBackgroundColor;
		id: #'coder-uninstalled-indicator'
]

{ #category : #accessing }
GtExpandableContextMethodCoderElement >> updateUninstalledIndicator [
	| method |
	method := self coderViewModel compiledMethod.
	uninstalledIndicator
		inUIProcessDo: [ uninstalledIndicator
				visibility: ((method isDoIt or: [ method isInstalled ])
						ifTrue: [ BlVisibility gone ]
						ifFalse: [ BlVisibility visible ]) ]
]