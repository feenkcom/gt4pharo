Class {
	#name : #GtElementConstraintsAdvice,
	#superclass : #GtAdvice,
	#instVars : [
		'fitContentsElement',
		'matchParentElement',
		'vertical'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Advice'
}

{ #category : #comparing }
GtElementConstraintsAdvice >> = anObject [
	^ self class = anObject class
		and: [ self fitContentsElement == anObject fitContentsElement
				and: [ self matchParentElement == anObject matchParentElement
						and: [ self isVertical = anObject isVertical ] ] ]
]

{ #category : #accessing }
GtElementConstraintsAdvice >> description [
	^ 'Element has fit contents and match parent constraints in parent chain.'
		asRopedText
]

{ #category : #accessing }
GtElementConstraintsAdvice >> fitContentsElement [
	^ fitContentsElement
]

{ #category : #accessing }
GtElementConstraintsAdvice >> fitContentsElement: aBlElement [
	fitContentsElement := aBlElement
]

{ #category : #comparing }
GtElementConstraintsAdvice >> hash [
	^ (self class hash bitXor: self fitContentsElement hash)
		bitXor: self matchParentElement hash
]

{ #category : #testing }
GtElementConstraintsAdvice >> isHorizontal [
	^ self isVertical not
]

{ #category : #testing }
GtElementConstraintsAdvice >> isVertical [
	^ vertical = true
]

{ #category : #accessing }
GtElementConstraintsAdvice >> matchParentElement [
	^ matchParentElement
]

{ #category : #accessing }
GtElementConstraintsAdvice >> matchParentElement: aBlElement [
	matchParentElement := aBlElement
]

{ #category : #accessing }
GtElementConstraintsAdvice >> name [
	^ 'Match parent and fit contents constraints used in hierarchy'
]

{ #category : #accessing }
GtElementConstraintsAdvice >> vertical: aBoolean [
	vertical := aBoolean
]
