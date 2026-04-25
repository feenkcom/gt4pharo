Class {
	#name : #GtPharoRenameSelectorAttributesStencil,
	#superclass : #BrStencil,
	#instVars : [
		'selectorModel',
		'refactoringsBlock',
		'completionAction',
		'cancelAction',
		'showWhenCreated',
		'selectorPartAttributeStencilBuilder'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #accessing }
GtPharoRenameSelectorAttributesStencil >> cancelAction [
	^ cancelAction ifNil: [ [  ] ]
]

{ #category : #accessing }
GtPharoRenameSelectorAttributesStencil >> cancelAction: anObject [
	cancelAction := anObject
]

{ #category : #accessing }
GtPharoRenameSelectorAttributesStencil >> completionAction [
	^ completionAction ifNil: [ [  ] ]
]

{ #category : #accessing }
GtPharoRenameSelectorAttributesStencil >> completionAction: anObject [
	completionAction := anObject
]

{ #category : #'api - updating' }
GtPharoRenameSelectorAttributesStencil >> create [
	^ Array
		streamContents: [ :aStream | 
			selectorModel
				selectorPartsAndParametersDo: [ :eachKeyword :eachParameter | 
					self createSelectorPartAttributeFor: eachKeyword into: aStream.
					self createParameterAttributeFor: eachParameter into: aStream ].
			self createRefactoringPreviewAttributeInto: aStream ]
]

{ #category : #private }
GtPharoRenameSelectorAttributesStencil >> createParameterAttributeFor: aSelectorParameter into: aStream [
	| anAttribute |
	selectorModel numberOfParameters <= 1 ifTrue: [ ^ self ].
	
	aSelectorParameter originalIndex > 1
		ifTrue: [ anAttribute := GtPharoRenameSelectorSwapButtonAttribute new
					icon: BrGlamorousVectorIcons left;
					tooltip: 'Swap parameter with previous';
					action: [ selectorModel swapParameterWithPrevious: aSelectorParameter originalIndex ];
					id: 'move-parameter-left-' , aSelectorParameter originalIndex printString.

			aStream
				nextPut: {aSelectorParameter originalInterval first - 1.
						aSelectorParameter originalInterval first - 1.
						anAttribute} ].

	anAttribute := GtPharoRenameSelectorParameterLabelAttribute new
			parameterModel: aSelectorParameter.

	aStream
		nextPut: {aSelectorParameter originalInterval first.
				aSelectorParameter originalInterval last.
				anAttribute}.

	aSelectorParameter originalIndex < selectorModel numberOfParameters
		ifFalse: [ ^ self ].

	anAttribute := GtPharoRenameSelectorSwapButtonAttribute new
			icon: BrGlamorousVectorIcons right;
			tooltip: 'Swap parameter with next';
			action: [ selectorModel swapParameterWithNext: aSelectorParameter originalIndex ];
			id: 'move-parameter-right-' , aSelectorParameter originalIndex printString.

	aStream
		nextPut: {aSelectorParameter originalInterval last.
				aSelectorParameter originalInterval last.
				anAttribute}.

	anAttribute := GtPharoRenameSelectorSwapButtonAttribute new
			icon: BrGlamorousVectorIcons right;
			tooltip: 'Swap keyword and parameter with next';
			action: [ selectorModel
					swapSelectorPartAndParameterWithNext: aSelectorParameter originalIndex ];
			id: 'move-keyword-and-parameter-right-'
					, aSelectorParameter originalIndex printString.

	aStream
		nextPut: {aSelectorParameter originalInterval last.
				aSelectorParameter originalInterval last.
				anAttribute}
]

{ #category : #'api - updating' }
GtPharoRenameSelectorAttributesStencil >> createRefactoringPreviewAttributeInto: aStream [
	| anAttribute aModel |
	anAttribute := GtRefactoringChangesAttribute new
			refactoringsBlock: self refactoringsBlock;
			completionAction: self completionAction;
			cancelAction: self cancelAction;
			showWhenCreated: self showWhenCreated.

	aModel := selectorModel numberOfParameters < 2
			ifTrue: [ selectorModel selectorParts last ]
			ifFalse: [ selectorModel selectorPartsAndParameters last ].

	aStream
		nextPut: {aModel originalInterval last.
				aModel originalInterval last.
				anAttribute}
]

{ #category : #private }
GtPharoRenameSelectorAttributesStencil >> createSelectorPartAttributeFor: aSelectorPart into: aStream [
	| anAttribute |
	aSelectorPart originalIndex > 1
		ifTrue: [ anAttribute := GtPharoRenameSelectorSwapButtonAttribute new
					icon: BrGlamorousVectorIcons left;
					tooltip: 'Swap keyword and parameter with previous';
					action: [ selectorModel
							swapSelectorPartAndParameterWithPrevious: aSelectorPart originalIndex ];
					id: 'move-keyword-and-parameter-left-' , aSelectorPart originalIndex printString.

			aStream
				nextPut: {aSelectorPart originalInterval first - 1.
						aSelectorPart originalInterval first - 1.
						anAttribute} ].

	anAttribute := GtPharoRenameSelectorPartEditorAttribute new
			selectorModel: selectorModel;
			selectorPartModel: aSelectorPart.

	aStream
		nextPut: {aSelectorPart originalInterval first.
				aSelectorPart originalInterval last.
				anAttribute}
]

{ #category : #'gt - extensions' }
GtPharoRenameSelectorAttributesStencil >> gtAttributesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Attributes';
		items: [ self create ];
		column: 'Range'
			text: [ :aCol | 
				'{1}..{2}'
					format: {aCol at: 1.
							aCol at: 2} ] width: 70;
		column: 'Attribute' text: [ :aCol | aCol at: 3 ];
		send: [ :aCol | aCol at: 3 ]
]

{ #category : #'gt - extensions' }
GtPharoRenameSelectorAttributesStencil >> gtLiveFor: aView [
	^ aView empty
]

{ #category : #initialization }
GtPharoRenameSelectorAttributesStencil >> initialize [
	super initialize.
	selectorPartAttributeStencilBuilder := GtPharoRenameSelectorPartEditorAttributeStencilBuilder
			new
]

{ #category : #accessing }
GtPharoRenameSelectorAttributesStencil >> refactoringsBlock [
	^ refactoringsBlock ifNil: [ [ {} ] ]
]

{ #category : #accessing }
GtPharoRenameSelectorAttributesStencil >> refactoringsBlock: anObject [
	refactoringsBlock := anObject
]

{ #category : #accessing }
GtPharoRenameSelectorAttributesStencil >> selectorModel [
	^ selectorModel
]

{ #category : #accessing }
GtPharoRenameSelectorAttributesStencil >> selectorModel: anObject [
	selectorModel := anObject
]

{ #category : #accessing }
GtPharoRenameSelectorAttributesStencil >> showWhenCreated [
	^ showWhenCreated ifNil: [ false ]
]

{ #category : #accessing }
GtPharoRenameSelectorAttributesStencil >> showWhenCreated: anObject [
	showWhenCreated := anObject
]
