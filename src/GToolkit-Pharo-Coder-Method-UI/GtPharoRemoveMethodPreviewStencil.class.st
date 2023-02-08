Class {
	#name : #GtPharoRemoveMethodPreviewStencil,
	#superclass : #BrStencil,
	#instVars : [
		'selectorToRemove',
		'isEmptyMethod',
		'anElement'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-Utilities'
}

{ #category : #accessing }
GtPharoRemoveMethodPreviewStencil >> anElement [
	^ anElement
]

{ #category : #accessing }
GtPharoRemoveMethodPreviewStencil >> anElement: anObject [
	^ anElement := anObject
]

{ #category : #'as yet unclassified' }
GtPharoRemoveMethodPreviewStencil >> create [
	| referencesButton waitingLabel container noReferencesLabel selectorLabel references |
	noReferencesLabel := BrLabel new
			margin: (BlInsets all: 10);
			aptitude: BrGlamorousLabelAptitude new glamorousRegularFont;
			text: 'Remove method?' asRopedText.
	(self isEmptyMethod or: [ self selectorToRemove isNil ])
		ifTrue: [ ^ noReferencesLabel ].

	references := self selectorToRemove gtReferences.

	noReferencesLabel
		text: self selectorToRemove asRopedText bold , ' is not referenced' asRopedText.

	waitingLabel := BrLabel new
			aptitude: BrGlamorousLabelAptitude new italic;
			margin: (BlInsets all: 10);
			text: 'Searching references...'.

	selectorLabel := BrLabel new
			margin: (BlInsets
					top: 10
					left: 10
					bottom: 10
					right: 0);
			aptitude: BrGlamorousLabelAptitude new;
			text: self selectorToRemove asRopedText bold , ' is still referenced in ' asRopedText.

	referencesButton := BrButton new
			aptitude: BrGlamorousLinkSquaredButtonWithLabelAptitude new glamorousCodeSmallSize;
			beSmallSize;
			margin: (BlInsets
					top: 10
					left: 2
					bottom: 10
					right: 10);
			label: '0 methods';
			action: [ self anElement phlow spawnObject: references ].

	container := BrHorizontalPane new
			fitContent;
			withAsyncSinkDo: [ :anElementSink | 
				anElementSink
					sink: AsyncCounterSink new;
					whenPending: [ :aContainer :aSink | 
						aSink count > 0
							ifTrue: [ waitingLabel visibility: BlVisibility gone.
								selectorLabel visibility: BlVisibility visible.
								referencesButton visibility: BlVisibility visible ].

						referencesButton
							label: (String
									streamContents: [ :aStream | 
										aStream
											print: aSink count;
											space;
											nextPutAll: ('method' asPluralBasedOn: aSink count);
											nextPutAll: '...' ]) ];
					whenSuccess: [ :aContainer :aSink | 
						waitingLabel visibility: BlVisibility gone.

						aSink count > 0
							ifTrue: [ selectorLabel visibility: BlVisibility visible.
								referencesButton visibility: BlVisibility visible ]
							ifFalse: [ selectorLabel visibility: BlVisibility gone.
								referencesButton visibility: BlVisibility gone.
								noReferencesLabel visibility: BlVisibility visible ].

						referencesButton
							label: (String
									streamContents: [ :aStream | 
										aStream
											print: aSink count;
											space;
											nextPutAll: ('method' asPluralBasedOn: aSink count) ]) ] ].

	container asyncSink forwardStream: references asAsyncStream.

	container
		addChildren: {waitingLabel.
				selectorLabel visibility: BlVisibility gone.
				referencesButton visibility: BlVisibility gone.
				noReferencesLabel visibility: BlVisibility gone}.

	^ container
]

{ #category : #accessing }
GtPharoRemoveMethodPreviewStencil >> isEmptyMethod [
	^ isEmptyMethod
]

{ #category : #accessing }
GtPharoRemoveMethodPreviewStencil >> isEmptyMethod: anObject [
	^ isEmptyMethod := anObject
]

{ #category : #accessing }
GtPharoRemoveMethodPreviewStencil >> selectorToRemove [
	^ selectorToRemove
]

{ #category : #accessing }
GtPharoRemoveMethodPreviewStencil >> selectorToRemove: anObject [
	^ selectorToRemove := anObject
]
