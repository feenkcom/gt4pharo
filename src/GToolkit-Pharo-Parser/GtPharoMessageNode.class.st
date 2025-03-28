Class {
	#name : #GtPharoMessageNode,
	#superclass : #GtPharoProgramNode,
	#category : #'GToolkit-Pharo-Parser-Parser'
}

{ #category : #accessing }
GtPharoMessageNode class >> priority [
	^ self subclassResponsibility
]

{ #category : #generated }
GtPharoMessageNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitMessage: self
]

{ #category : #accessing }
GtPharoMessageNode >> arguments [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtPharoMessageNode >> bestNodeFor: anInterval ifFound: aFoundBlock ifNone: aNoneBlock [
	(self selectorParts
		anySatisfy: [ :token | 
			(anInterval last < token startPosition
				or: [ anInterval first > token stopPosition ]) not ])
		ifTrue: [ ^ aFoundBlock value: self ].
	^ super
		bestNodeFor: anInterval
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : #testing }
GtPharoMessageNode >> isBinary [
	^ false
]

{ #category : #testing }
GtPharoMessageNode >> isConstructorMessage [
	^ false
]

{ #category : #testing }
GtPharoMessageNode >> isKeyword [
	^ false
]

{ #category : #testing }
GtPharoMessageNode >> isMessage [
	^ true
]

{ #category : #testing }
GtPharoMessageNode >> isUnary [
	^ false
]

{ #category : #accessing }
GtPharoMessageNode >> isUsed [
	^ (parent isCascade not or: [ parent messages last == self ])
		and: [ parent isUsed ]
]

{ #category : #testing }
GtPharoMessageNode >> needsParenthesisForKeyword [
	^ true
]

{ #category : #accessing }
GtPharoMessageNode >> priority [
	^ self class priority
]

{ #category : #accessing }
GtPharoMessageNode >> selector [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtPharoMessageNode >> selectorParts [
	^ self subclassResponsibility
]
