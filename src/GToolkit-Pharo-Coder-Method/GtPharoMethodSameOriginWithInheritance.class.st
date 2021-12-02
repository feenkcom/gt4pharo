Class {
	#name : #GtPharoMethodSameOriginWithInheritance,
	#superclass : #GtPharoMethodSameOrigin,
	#instVars : [
		'isOverridden',
		'isOverriding'
	],
	#category : #'GToolkit-Pharo-Coder-Method-Origin'
}

{ #category : #accessing }
GtPharoMethodSameOriginWithInheritance >> isOverridden [

	^ isOverridden
]

{ #category : #accessing }
GtPharoMethodSameOriginWithInheritance >> isOverridden: anObject [

	isOverridden := anObject
]

{ #category : #accessing }
GtPharoMethodSameOriginWithInheritance >> isOverriding [

	^ isOverriding
]

{ #category : #accessing }
GtPharoMethodSameOriginWithInheritance >> isOverriding: anObject [

	isOverriding := anObject
]
