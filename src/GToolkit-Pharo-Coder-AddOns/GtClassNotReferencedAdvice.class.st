Class {
	#name : #GtClassNotReferencedAdvice,
	#superclass : #GtAdvice,
	#instVars : [
		'unreferencedClass'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Advice'
}

{ #category : #accessing }
GtClassNotReferencedAdvice >> description [
	^ (unreferencedClass name asString
		, ' is not referenced and has no subclasses. If it isn''t referenced using reflection (e.g., allSubclasses) then it can be removed.')
		asRopedText
]

{ #category : #accessing }
GtClassNotReferencedAdvice >> name [
	^ 'Class not referenced'
]

{ #category : #accessing }
GtClassNotReferencedAdvice >> unreferencedClass [
	^ unreferencedClass
]

{ #category : #accessing }
GtClassNotReferencedAdvice >> unreferencedClass: aClass [
	unreferencedClass := aClass
]
