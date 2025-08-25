Class {
	#name : #GtPharoMethodsCoder,
	#superclass : #GtCodersModel,
	#category : #'GToolkit-Pharo-Coder-Coders'
}

{ #category : #testing }
GtPharoMethodsCoder >> isForClass [
	^ false
]

{ #category : #'event handling' }
GtPharoMethodsCoder >> methodAdded: aValueAdded [
	| aCoder |
	(self coders
		anySatisfy: [ :eachCoder | eachCoder isForMethod: aValueAdded newValue ])
		ifTrue: [ ^ self ].
	aCoder := self newCoderFor: aValueAdded newValue.
	self addCoder: aCoder
]

{ #category : #'event handling' }
GtPharoMethodsCoder >> methodChanged: aValueChanged [
	coders
		do: [ :each | 
			(each isForMethod: aValueChanged newValue)
				ifTrue: [ each forMethod: aValueChanged newValue ] ]
]

{ #category : #'event handling' }
GtPharoMethodsCoder >> methodRemoved: aValueRemoved [
	| toRemove |
	toRemove := coders
		select: [ :each | each isForMethod: aValueRemoved oldValue ].
	toRemove
		do: [ :each | 
			self removeCoder: each ]
]

{ #category : #private }
GtPharoMethodsCoder >> newCoderFor: aMethod [
	| coder coderClass |
	coderClass := aMethod gtSelectCoderClass.
	coder := [ coderClass forMethod: aMethod ]
			onErrorDo: [ aMethod gtMethodCoder forMethod: aMethod ].
	coder coders: self.
	^ coder
]

{ #category : #accessing }
GtPharoMethodsCoder >> object [
	^ nil
]

{ #category : #scripting }
GtPharoMethodsCoder >> selectAndScrollTo: aMethodCoder [
	
]

{ #category : #scripting }
GtPharoMethodsCoder >> selectAndScrollToMethod: aCompiledMethod [
	| methodCoder |
	methodCoder := self coders
		detect: [ :each | each isForMethod: aCompiledMethod ]
		ifNone: [ ^ self ].
	self selectAndScrollTo: methodCoder
]
