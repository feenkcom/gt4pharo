Class {
	#name : #GtRefactoringButtonAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#traits : 'TGtAnnouncer',
	#classTraits : 'TGtAnnouncer classTrait',
	#instVars : [
		'actionBlock',
		'icon',
		'label',
		'visible',
		'announcer',
		'enterBlock',
		'leaveBlock',
		'id'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Base'
}

{ #category : #'instance creation' }
GtRefactoringButtonAttribute class >> action: aBlock icon: anIcon [
	^ self new
		actionBlock: aBlock;
		icon: anIcon;
		yourself
]

{ #category : #'instance creation' }
GtRefactoringButtonAttribute class >> action: aBlock icon: anIcon label: aString [
	^ self new
		actionBlock: aBlock;
		icon: anIcon;
		label: aString;
		yourself
]

{ #category : #'instance creation' }
GtRefactoringButtonAttribute class >> action: aBlock icon: anIcon label: aString id: aSymbol [
	^ self new
		actionBlock: aBlock;
		icon: anIcon;
		label: aString;
		id: aSymbol;
		yourself
]

{ #category : #accessing }
GtRefactoringButtonAttribute >> actionBlock [
	^ actionBlock
]

{ #category : #accessing }
GtRefactoringButtonAttribute >> actionBlock: aBlock [
	actionBlock := aBlock
]

{ #category : #announcer }
GtRefactoringButtonAttribute >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #accessing }
GtRefactoringButtonAttribute >> doAffect: aTBrTextEditorTextualPiece in: anEditorElement [
	| button |
	button := BrButton new.
	button icon: icon.
	button label: self label.
	button
		aptitude: BrGlamorousButtonExteriorAptitude
				+ ((BrGlamorousButtonRectangularAptitude paddingScale: 2 / 3)
						+ BrGlamorousButtonIconAptitude
						+ BrGlamorousButtonWithLabelTooltipAptitude2).
	button beMiniSize.
	button
		margin: (BlInsets
				top: 1
				right: 4
				bottom: 0
				left: 4).
	button action: [ :anEvent | actionBlock cull: anEvent ].
	button id: id.
	button
		when: BlMouseEnterEvent
		do: [ :event | enterBlock ifNotNil: [ enterBlock cull: event ] ].
	button
		when: BlMouseLeaveEvent
		do: [ :event | leaveBlock ifNotNil: [ leaveBlock cull: event ] ].
	self updateButton: button.
	self
		when: GtRefactoringButtonVisibilityChanged
		send: #value
		to: (WeakMessageSend
				receiver: self
				selector: #updateButton:
				arguments: {button}).
	^ button
]

{ #category : #accessing }
GtRefactoringButtonAttribute >> icon [
	^ icon
]

{ #category : #accessing }
GtRefactoringButtonAttribute >> icon: anObject [
	icon := anObject
]

{ #category : #accessing }
GtRefactoringButtonAttribute >> id [
	^ id
]

{ #category : #accessing }
GtRefactoringButtonAttribute >> id: aString [
	id := aString asSymbol
]

{ #category : #'initialize-release' }
GtRefactoringButtonAttribute >> initialize [
	super initialize.
	visible := true.
	self beAppend.
	self beNotOverwritableByStyler.
	id := #'reorder-parameter-button'
]

{ #category : #accessing }
GtRefactoringButtonAttribute >> label [
	^ label ifNil: [ 'Reorder' ]
]

{ #category : #accessing }
GtRefactoringButtonAttribute >> label: aString [
	label := aString
]

{ #category : #accessing }
GtRefactoringButtonAttribute >> onEnter: aBlock [
	enterBlock := aBlock
]

{ #category : #accessing }
GtRefactoringButtonAttribute >> onLeave: aBlock [
	leaveBlock := aBlock
]

{ #category : #private }
GtRefactoringButtonAttribute >> updateButton: aButton [
	aButton
		visibility: (visible ifTrue: [ BlVisibility visible ] ifFalse: [ BlVisibility hidden ])
]

{ #category : #accessing }
GtRefactoringButtonAttribute >> visible [
	^ visible
]

{ #category : #accessing }
GtRefactoringButtonAttribute >> visible: aBoolean [
	visible := aBoolean.
	self announce: (GtRefactoringButtonVisibilityChanged new visible: aBoolean)
]
