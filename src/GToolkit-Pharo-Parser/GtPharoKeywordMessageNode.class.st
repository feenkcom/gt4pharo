Class {
	#name : #GtPharoKeywordMessageNode,
	#superclass : #GtPharoMessageNode,
	#instVars : [
		'selectorParts',
		'values'
	],
	#category : #'GToolkit-Pharo-Parser-Parser'
}

{ #category : #accessing }
GtPharoKeywordMessageNode class >> priority [
	^ 3
]

{ #category : #generated }
GtPharoKeywordMessageNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitKeywordMessage: self
]

{ #category : #accessing }
GtPharoKeywordMessageNode >> arguments [
	^ self values
]

{ #category : #generated }
GtPharoKeywordMessageNode >> compositeNodeVariables [
	^ #(#values)
]

{ #category : #generated }
GtPharoKeywordMessageNode >> compositeTokenVariables [
	^ #(#selectorParts)
]

{ #category : #views }
GtPharoKeywordMessageNode >> gtSelectorPartsAndValuesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Parts and values';
		items: [ (1 to: self selectorParts size)
				collect: [ :i | (self selectorParts at: i) -> (self values at: i) ] ];
		column: 'Selector' text: [ :each | each key value ];
		column: 'Value' text: [ :each | each value ]
]

{ #category : #'generated-initialize-release' }
GtPharoKeywordMessageNode >> initialize [
	super initialize.
	selectorParts := OrderedCollection new: 2.
	values := OrderedCollection new: 2.
]

{ #category : #testing }
GtPharoKeywordMessageNode >> isConstructorMessage [
	^ self selectorParts size = 1 and: [ self selectorParts first source = 'new:' ]
]

{ #category : #testing }
GtPharoKeywordMessageNode >> isKeyword [
	^ true
]

{ #category : #accessing }
GtPharoKeywordMessageNode >> messageReceiver [
	^ values last messageReceiver
]

{ #category : #accessing }
GtPharoKeywordMessageNode >> selector [
	^ (String streamContents: [ :stream | self selectorParts do: [ :each | stream nextPutAll: each source ] ]) asSymbol
]

{ #category : #generated }
GtPharoKeywordMessageNode >> selectorParts [
	^ selectorParts
]

{ #category : #generated }
GtPharoKeywordMessageNode >> selectorParts: anOrderedCollection [
	selectorParts := anOrderedCollection
]

{ #category : #generated }
GtPharoKeywordMessageNode >> values [
	^ values
]

{ #category : #generated }
GtPharoKeywordMessageNode >> values: anOrderedCollection [
	self setParents: self values to: nil.
	values := anOrderedCollection.
	self setParents: self values to: self
]
