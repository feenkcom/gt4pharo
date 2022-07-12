Class {
	#name : #GtRBNamespace,
	#superclass : #RBNamespace,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Base'
}

{ #category : #accessing }
GtRBNamespace >> allImplementorsOf: aSelector [ 
	^ (GtPharoIndex current implementersOf: aSelector) collect: [:each | self classNamed: each methodClass name ]
]

{ #category : #accessing }
GtRBNamespace >> allReferencesTo: aSelector [ 
	^ (GtPharoIndex current sendersOf: aSelector) collect: [:each | (self classNamed: each methodClass name) methodFor: each selector ]
]
