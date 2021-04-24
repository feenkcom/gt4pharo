Class {
	#name : #GtPharoMessageNode,
	#superclass : #GtPharoProgramNode,
	#category : #'GToolkit-Pharo-Parser-Parser'
}

{ #category : #generated }
GtPharoMessageNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitMessage: self
]

{ #category : #accessing }
GtPharoMessageNode >> arguments [
	^ self subclassResponsibility
]

{ #category : #testing }
GtPharoMessageNode >> isBinary [
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

{ #category : #testing }
GtPharoMessageNode >> needsParenthesisForKeyword [
	^ true
]

{ #category : #accessing }
GtPharoMessageNode >> selector [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtPharoMessageNode >> selectorParts [
	^ self subclassResponsibility
]
