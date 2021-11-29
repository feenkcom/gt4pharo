Class {
	#name : #GtBaselinePackageCompletionStrategy,
	#superclass : #GtBaselineCompletionStrategy,
	#category : #'GToolkit-Pharo-Coder-AddOns-Expandable baseline'
}

{ #category : #private }
GtBaselinePackageCompletionStrategy >> nameStreamMatching: aString [
	^ (RPackageOrganizer default packages asAsyncStream select: [ :each | each name beginsWith: aString ])
		collect: [ :each | each name ]
]
