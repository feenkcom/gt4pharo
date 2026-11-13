"
Signals an invalid replacement or an error raised while matching or replacing a node. node identifies the original input node when it can be found by equality and source positions. replacementNode contains an incompatible proposed replacement for validation failures. originalError retains the underlying exception for matching or replacement failures. An enclosing cascade can be obtained from node's parent chain. Existing GtParseTreeRewriteErrors propagate without being wrapped again. The rewriter does not publish a partial result on failure.
"
Class {
	#name : #GtParseTreeRewriteError,
	#superclass : #Error,
	#instVars : [
		'node',
		'replacementNode',
		'originalError'
	],
	#category : #'GToolkit-Pharo-BaseRefactorings-Rewriting'
}

{ #category : #views }
GtParseTreeRewriteError >> gtDetailsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Details';
		priority: 20;
		items: [ {'Message' -> self messageText.
				'Node' -> node.
				'Replacement' -> replacementNode.
				'Original error' -> originalError} reject: [ :each | each value isNil ] ];
		column: 'Property' text: #key;
		column: 'Value' text: [ :each | each value gtDisplayString ];
		send: [ :each | each value ]
]

{ #category : #views }
GtParseTreeRewriteError >> gtOriginalErrorFor: aView [
	<gtView>
	originalError ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Original error';
		priority: 30;
		object: [ originalError ];
		view: #gtStackFor:
]

{ #category : #views }
GtParseTreeRewriteError >> gtSourceFor: aView [
	<gtView>
	node ifNil: [ ^ aView empty ].
	^ aView textEditor
		title: 'Source';
		priority: 0;
		aptitude: BrGlamorousCodeEditorAptitude;
		styler: BrRBTextStyler new;
		text: [ self highlightedSourceText ]
]

{ #category : #accessing }
GtParseTreeRewriteError >> highlightedSourceText [
	| text |
	text := self originalSource asRopedText.
	(node isNil or: [ text isEmpty ]) ifTrue: [ ^ text ].
	node gtInterestingHighlightingIntervals
		do: [ :interval | 
			| first last |
			first := interval first max: 1.
			last := interval last min: text size.
			first <= last
				ifTrue: [ (text from: first to: last)
						attribute: (BlTextHighlightAttribute paint: (Color red alpha: 0.2))
								beNotOverwritableByStyler ] ].
	^ text
]

{ #category : #accessing }
GtParseTreeRewriteError >> node [
	^ node
]

{ #category : #accessing }
GtParseTreeRewriteError >> node: anObject [
	node := anObject
]

{ #category : #accessing }
GtParseTreeRewriteError >> originalError [
	^ originalError
]

{ #category : #accessing }
GtParseTreeRewriteError >> originalError: anError [
	originalError := anError
]

{ #category : #accessing }
GtParseTreeRewriteError >> originalSource [
	node ifNil: [ ^ '' ].
	node methodNode
		ifNotNil: [ :method | ^ method source ifNil: [ method formattedCode ] ].
	^ node formattedCode
]

{ #category : #accessing }
GtParseTreeRewriteError >> replacementNode [
	^ replacementNode
]

{ #category : #accessing }
GtParseTreeRewriteError >> replacementNode: anObject [
	replacementNode := anObject
]
