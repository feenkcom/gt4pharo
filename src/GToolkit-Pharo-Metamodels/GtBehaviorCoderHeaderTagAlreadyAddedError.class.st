Class {
	#name : #GtBehaviorCoderHeaderTagAlreadyAddedError,
	#superclass : #GtBehaviorCoderHeaderTagError,
	#category : #'GToolkit-Pharo-Metamodels-Behavior - Errors'
}

{ #category : #accessing }
GtBehaviorCoderHeaderTagAlreadyAddedError >> description [
	^ 'Tag named {1} already exists in the definition' format: { self tagName }
]
