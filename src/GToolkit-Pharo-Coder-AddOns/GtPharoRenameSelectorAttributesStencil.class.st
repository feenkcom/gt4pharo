Class {
	#name : #GtPharoRenameSelectorAttributesStencil,
	#superclass : #BrStencil,
	#instVars : [
		'selectorModel',
		'selectorPartAttributeStencilBuilder',
		'refactoringsConfiguration'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #'api - updating' }
GtPharoRenameSelectorAttributesStencil >> create [
	^ Array
		streamContents: [ :aStream | 
			selectorModel
				selectorPartsAndParametersDo: [ :eachKeyword :eachParameter | 
					self createSelectorPartAttributeFor: eachKeyword into: aStream.
					self createParameterAttributeFor: eachParameter into: aStream ].
			self createRefactoringsPreviewAttributeInto: aStream ]
]

{ #category : #private }
GtPharoRenameSelectorAttributesStencil >> createParameterAttributeFor: aSelectorParameter into: aStream [
	| anAttribute |
	selectorModel numberOfParameters <= 1 ifTrue: [ ^ self ].

	aSelectorParameter originalIndex > 1
		ifTrue: [ anAttribute := GtPharoRenameSelectorSwapButtonAttribute new
					selectorModel: selectorModel;
					relevantModels: {aSelectorParameter};
					icon: BrGlamorousVectorIcons left;
					tooltip: 'Swap parameter with previous';
					action: [ :aButton :aSelectorModel :aTextEditorElement | 
						selectorModel
							swapParameterWithPrevious: aSelectorParameter originalIndex
							source: aButton ];
					id: 'move-parameter-left-' , aSelectorParameter originalIndex printString;
					hovered: [ :aButton :aSelectorModel :aTextEditorElement | 
							selectorModel
								highlight: true
								selectorParameterWithPrevious: aSelectorParameter originalIndex
								source: aButton ]
						after: [ :aButton :aSelectorModel :aTextEditorElement | 
							selectorModel
								highlight: false
								selectorParameterWithPrevious: aSelectorParameter originalIndex
								source: aButton ].

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
			selectorModel: selectorModel;
			relevantModels: {aSelectorParameter};
			icon: BrGlamorousVectorIcons right;
			tooltip: 'Swap parameter with next';
			action: [ :aButton :aSelectorModel :aTextEditorElement | 
				selectorModel
					swapParameterWithNext: aSelectorParameter originalIndex
					source: aButton ];
			id: 'move-parameter-right-' , aSelectorParameter originalIndex printString;
			hovered: [ :aButton :aSelectorModel :aTextEditorElement | 
					selectorModel
						highlight: true
						selectorParameterWithNext: aSelectorParameter originalIndex
						source: aButton ]
				after: [ :aButton :aSelectorModel :aTextEditorElement | 
					selectorModel
						highlight: false
						selectorParameterWithNext: aSelectorParameter originalIndex
						source: aButton ].

	aStream
		nextPut: {aSelectorParameter originalInterval last.
				aSelectorParameter originalInterval last.
				anAttribute}.

	anAttribute := GtPharoRenameSelectorSwapButtonAttribute new
			selectorModel: selectorModel;
			relevantModels: {aSelectorParameter};
			icon: BrGlamorousVectorIcons right;
			tooltip: 'Swap keyword and parameter with next';
			action: [ :aButton :aSelectorModel :aTextEditorElement | 
				selectorModel
					swapSelectorPartAndParameterWithNext: aSelectorParameter originalIndex
					source: aButton ];
			id: 'move-keyword-and-parameter-right-'
					, aSelectorParameter originalIndex printString;
			hovered: [ :aButton :aSelectorModel :aTextEditorElement | 
					selectorModel
						highlight: true
						selectorPartAndParameterWithNext: aSelectorParameter originalIndex
						source: aButton ]
				after: [ :aButton :aSelectorModel :aTextEditorElement | 
					selectorModel
						highlight: false
						selectorPartAndParameterWithNext: aSelectorParameter originalIndex
						source: aButton ].

	aStream
		nextPut: {aSelectorParameter originalInterval last.
				aSelectorParameter originalInterval last.
				anAttribute}
]

{ #category : #'api - updating' }
GtPharoRenameSelectorAttributesStencil >> createRefactoringsPreviewAttributeInto: aStream [
	| anAttribute aModel |
	anAttribute := GtPharoRenameSelectorRefactoringsPreviewAttribute new
			selectorModel: selectorModel;
			refactoringsConfiguration: refactoringsConfiguration.

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
					selectorModel: selectorModel;
					relevantModels: {aSelectorPart};
					icon: BrGlamorousVectorIcons left;
					tooltip: 'Swap keyword and parameter with previous';
					action: [ :aButton :aSelectorModel :aTextEditorElement | 
						selectorModel
							swapSelectorPartAndParameterWithPrevious: aSelectorPart originalIndex
							source: aButton ];
					id: 'move-keyword-and-parameter-left-' , aSelectorPart originalIndex printString;
					hovered: [ :aButton :aSelectorModel :aTextEditorElement | 
							selectorModel
								highlight: true
								selectorPartAndParameterWithPrevious: aSelectorPart originalIndex
								source: aButton ]
						after: [ :aButton :aSelectorModel :aTextEditorElement | 
							selectorModel
								highlight: false
								selectorPartAndParameterWithPrevious: aSelectorPart originalIndex
								source: aButton ].

			aStream
				nextPut: {aSelectorPart originalInterval first - 1.
						aSelectorPart originalInterval first - 1.
						anAttribute} ].

	anAttribute := GtPharoRenameSelectorPartEditorAttribute new
			selectorModel: selectorModel;
			selectorPartModel: aSelectorPart;
			shouldStartWithFocus: aSelectorPart originalIndex = 1.

	anAttribute shouldStartWithFocus: aSelectorPart originalIndex = 1.

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
GtPharoRenameSelectorAttributesStencil >> refactoringsConfiguration [
	^ refactoringsConfiguration
]

{ #category : #accessing }
GtPharoRenameSelectorAttributesStencil >> refactoringsConfiguration: anObject [
	refactoringsConfiguration := anObject
]

{ #category : #accessing }
GtPharoRenameSelectorAttributesStencil >> selectorModel [
	^ selectorModel
]

{ #category : #accessing }
GtPharoRenameSelectorAttributesStencil >> selectorModel: anObject [
	selectorModel := anObject
]
