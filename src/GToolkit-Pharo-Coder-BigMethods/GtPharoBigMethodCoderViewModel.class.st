Class {
	#name : #GtPharoBigMethodCoderViewModel,
	#superclass : #GtExpandableCoderViewModel,
	#traits : 'TGtCoderWithSelfObjectHolder',
	#classTraits : 'TGtCoderWithSelfObjectHolder classTrait',
	#category : #'GToolkit-Pharo-Coder-BigMethods-Coder'
}

{ #category : #accessing }
GtPharoBigMethodCoderViewModel >> addOns [
	^#()
]

{ #category : #converting }
GtPharoBigMethodCoderViewModel >> asEditorState [
	^BrTextEditorCompositeMemento new
]

{ #category : #'api - coder model' }
GtPharoBigMethodCoderViewModel >> behavior [
	^ self coderModel behavior
]

{ #category : #'api - coder model' }
GtPharoBigMethodCoderViewModel >> behavior: aBehavior [
	^ self coderModel behavior: aBehavior
]

{ #category : #accessing }
GtPharoBigMethodCoderViewModel >> completionStrategy [
	^GtCompletionStrategy new
]

{ #category : #'private - addons' }
GtPharoBigMethodCoderViewModel >> computeAddOnsFuture [
	^[GtCoderAddOns new] asAsyncFuture
]

{ #category : #'api - actions' }
GtPharoBigMethodCoderViewModel >> contextActions [
	^#()
]

{ #category : #accessing }
GtPharoBigMethodCoderViewModel >> elementClass [
	^ GtPharoBigMethodExpandableSourceCoderElement
]

{ #category : #accessing }
GtPharoBigMethodCoderViewModel >> highlighter: aHighlighter [
]

{ #category : #accessing }
GtPharoBigMethodCoderViewModel >> isMeta [
	^self coderModel isMeta
]

{ #category : #'api - text' }
GtPharoBigMethodCoderViewModel >> isTextModifiedPromise [
	^[ false ] asAsyncPromise
]

{ #category : #'api - actions' }
GtPharoBigMethodCoderViewModel >> mainActions [
	^#()
]

{ #category : #accessing }
GtPharoBigMethodCoderViewModel >> methodReference [
	^ self coderModel methodReference
]

{ #category : #'as yet unclassified' }
GtPharoBigMethodCoderViewModel >> selector [
	^ self coderModel selector
]

{ #category : #accessing }
GtPharoBigMethodCoderViewModel >> shortcuts [
	^#()
]
