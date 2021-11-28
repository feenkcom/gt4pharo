Extension { #name : #GtPharoMethodCoder }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtPharoMethodCoder >> asCoderUIModel [
	^ GtPharoMethodCoderViewModel new coder: self
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtPharoMethodCoder >> browseFrom: anEditorElement [ 
	((GtCoder forMethod: self compiledMethod)
		openInPagerFrom: anEditorElement)
			maximized
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtPharoMethodCoder >> buildRemoveMethodLabel: anElement [
	| noReferencesLabel container waitingLabel selectorLabel referencesButton references |

	noReferencesLabel := BrLabel new
		margin: (BlInsets all: 10);
		aptitude: BrGlamorousLabelAptitude new glamorousRegularFont;
		text: 'Remove method?' asRopedText.

	(self isNewMethod or: [ selector isNil ])
		ifTrue: [ ^ noReferencesLabel ].

	references := self selector gtReferences. 
	
	noReferencesLabel text: (selector asRopedText bold, ' is not referenced' asRopedText).

	waitingLabel := BrLabel new
		aptitude: BrGlamorousLabelAptitude new italic;
		margin: (BlInsets all: 10);
		text: 'Searching references...'.

	selectorLabel := BrLabel new
		margin: (BlInsets top: 10 left: 10 bottom: 10 right: 0);
		aptitude: BrGlamorousLabelAptitude new;
		text: (selector asRopedText bold, ' is still referenced in ' asRopedText).

	referencesButton := BrButton new
		aptitude: BrGlamorousLinkSquaredButtonWithLabelAptitude new glamorousCodeSmallSize;
		beSmallSize;
		margin: (BlInsets top: 10 left: 2 bottom: 10 right: 10);
		label: '0 methods';
		action: [ anElement phlow spawnObject: references ].
		
	container := BrHorizontalPane new
		fitContent;
		withAsyncSinkDo: [ :anElementSink |
			anElementSink
				sink: AsyncCounterSink new;
				whenPending: [ :aContainer :aSink |
					aSink count > 0
						ifTrue: [
							waitingLabel visibility: BlVisibility gone.
							selectorLabel visibility: BlVisibility visible.
							referencesButton visibility: BlVisibility visible ].
					
					referencesButton label: (String streamContents: [ :aStream |
						aStream
							print: aSink count;
							space;
							nextPutAll: ('method' asPluralBasedOn: aSink count);
							nextPutAll: '...' ]) ];
				whenSuccess: [ :aContainer :aSink | 
					waitingLabel visibility: BlVisibility gone.

					aSink count > 0
						ifTrue: [
							selectorLabel visibility: BlVisibility visible.
							referencesButton visibility: BlVisibility visible ]
						ifFalse: [
							selectorLabel visibility: BlVisibility gone.
							referencesButton visibility: BlVisibility gone.
							noReferencesLabel visibility: BlVisibility visible ].
						
					referencesButton label: (String streamContents: [ :aStream |
						aStream
							print: aSink count;
							space;
							nextPutAll: ('method' asPluralBasedOn: aSink count) ]) ] ].

	(references asAsyncStream forward: container asyncSink) await.

	container addChildren: {
		waitingLabel.
		selectorLabel visibility: BlVisibility gone.
		referencesButton visibility: BlVisibility gone.
		noReferencesLabel visibility: BlVisibility gone
	}.

	^ container
]
